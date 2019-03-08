function [lambda_hat,lambda_optbound,c,CV,EI,flag_opt,lambda_feas_out] =  BCS_3_EAM(q,sgn_q,lambda_feas,lambda_Estep,c_Estep,CV_Estep,maxviol_Estep,lambda_init,c_init,CV_init,maxviol_init,f_ineq,f_eq,f_ineq_keep,f_eq_keep,f_stdev_ineq,f_stdev_eq,G_ineq,G_eq,KMSoptions)
%% Code description: EAM
%  This function executes the EAM algorithm and outputs the BCS interval.
%
%  This function outputs the value that solves the following problem:
%
%  (Eq 2.16)
%  max/min lambda
%  s.t. inf_{p'lambda=lambda}T_n(lambda) <= c(lambda)
%
%  If sgn_q = 1, then we solve max lambda. If sgn_q = -1, then we solve
%  min lambda.
%
% INPUTS:
%   q                   dim_p-by-1 directional vector.  This is either
%                       p or -p
%
%   sgn_q               Equal to 1 or -1.  This determines the value of the
%                       problem.
%
%   lambda_feas         Feasible point found in auxiliary search
%
%   f_ineq,f_eq         Empirical moments
%
%   f_ineq_keep,f_eq_keep      Moments to keep
%
%  f_stdev_ineq,f_stdev_eq     Standard deviation of empirical moments
%
%   G_ineq,G_eq         Bootstrapped and recentered moments
%
%   KMSoptions.         This is a structure of additional inputs held
%                       constant over the program.  In the 2x2 entry game,
%                       KMSoptions includes the support for the covariates
%                       and the probability of support point occuring.
%                       There are also options in KMSoptions to  specify
%                       optimization algorithm, tolerance, and tuning
%                       parameters.  However, it is not recommended that
%                       the user adjusts these.
%
% OUTPUT:
%   lambda_hat          dim_p-by-1 parameter vector that solves the optimization problem
%
%   lambda_optbound      1-by-1 optimal value/projection: abs(q')*lambda_hat.
%
%   flag_opt            flag_opt = 1 if program converged
%                       flag_opt = -1 if no feasible points can be found
%                       (output point that minimizes constraint violation)
%                       flag_opt = 0 if EAM did not converge in the maximum
%                       number of iterations.
%   c                   Critical value c(lambda)
%
%   CV                  Constriant violation -- 0 if converged
%
%   EI                  Expected improvement -- should be small if
%                       converged

%% Extract relevant information from KMSoptions
LB_lambda            = KMSoptions.LB_theta(KMSoptions.component); % May need to change the dimension
UB_lambda            = KMSoptions.UB_theta(KMSoptions.component);
CI_lo               = KMSoptions.CI_lo;
CI_hi               = KMSoptions.CI_hi;
sample_method       = KMSoptions.sample_method;
dim_p               = KMSoptions.dim_p;
dace_theta          = KMSoptions.dace_theta;
dace_lob            = KMSoptions.dace_lob;
dace_upb            = KMSoptions.dace_upb;
e_points_init       = KMSoptions.e_points_init;
options_fmincon     = KMSoptions.options_fmincon;
options_linprog     = KMSoptions.options_linprog;
EAM_maxit           = KMSoptions.EAM_maxit;
EAM_minit           = KMSoptions.EAM_minit;
EAM_tol             = KMSoptions.EAM_tol;
h_rate              = KMSoptions.h_rate;
h_rate2             = KMSoptions.h_rate2;
parallel            = KMSoptions.parallel;
unif_num            = KMSoptions.unif_num;
EI_num              = KMSoptions.EI_num;
EI_multi_num        = KMSoptions.EI_multi_num;
EAM_obj_tol         = KMSoptions.EAM_obj_tol;
r_min               = KMSoptions.r_min;
EAM_maxviol_tol     = KMSoptions.EAM_maxviol_tol;
EAM_lambdadistort    = KMSoptions.EAM_thetadistort;
CVtol               = KMSoptions.CVtol;
seed             = KMSoptions.seed;

%% Set seed
stream=RandStream('mlfg6331_64','Seed',seed);
RandStream.setGlobalStream(stream);
stream.Substream = 1000000000000001;
%% Extracto information for BCS_EAM %%%
BCS_EAM = KMSoptions.BCS_EAM;
mbase = KMSoptions.mbase;
component = KMSoptions.component;

%% Initialize EAM
% Number of feasible points
num_feas = size(lambda_feas,1);

% lambda_Astep is the set of lambdas that EAM has explored
% So that the program runs correctly, I initiate it to be the empty set.
% lambda_Astep will be updated shortly in the EAM algorithm
lambda_Astep    = lambda_init;
c_Astep         = c_init;
CV_Astep        = CV_init;
maxviol_Astep   = maxviol_init;

% Change in optimal projection is undefined for the first iteration
opt_val_old = nan;

% Contraction counter counts the degree to which we contract the parameter
% space.  It is an integer with value {0,1,2,...,EAM_maxit}.
% If on the previous iteration we failed to find a feasible point, then we
% contract the parameter space by increasing the counter.
% If, on the other hand, the new feasible point is close to the boundary,
% we expand the parameter space by reducing the counter.
% The parameter space is contracted/expanded at rate 1/h_rate^{counter}.
contraction_counter = 0;

% opt_bound is upper bound on the parameter space in direction q.
% opt_dagger is the upper bound on the contracted parameter space in
% direction q.  opt_dagger changes iteration-to-iteration.
if sgn_q == 1
    opt_dagger   = CI_hi;
    opt_bound    = CI_hi;
else
    opt_dagger   = CI_lo;
    opt_bound    = CI_lo;
end

%% EAM optimization routine
% We run EAM for up to EAM_maxit times.  Each loop adds more evaluation points
% until we yield convergence.
fprintf('Iteration     |     Opt Proj     | Change in EI proj        |     Change     |     Max Violation   | Feasible points    |  Multi. Start Num.  | Percent conv. EI>0  |  Contraction counter \n')
fprintf('------------------------------------------------------------------------------------------------------------------------------------------------------- \n')
for iter=1:EAM_maxit
    if iter > 1
        % Step 1) E-step
        num_Estep = size(lambda_Estep,1);
        theta_Estep = zeros(num_Estep,dim_p);
        theta_Estep(:,component) = lambda_Estep;
        [c_Estep,CV_Estep,theta_Estep,maxviol_Estep] = KMS_31_Estep(theta_Estep,f_ineq,f_eq,f_ineq_keep,f_eq_keep,f_stdev_ineq,f_stdev_eq,G_ineq,G_eq,KMSoptions);
        lambda_Estep = theta_Estep(:,component);
    end
    
    % Update (lambda,c) for the A-step
    lambda_Astep  = [lambda_Astep ; lambda_Estep];
    c_Astep       = [c_Astep ; c_Estep];
    CV_Astep      = [CV_Astep;CV_Estep];
    maxviol_Astep = [maxviol_Astep;maxviol_Estep];
    
    
    % Keep only unique points
    [lambda_Astep,ind] =  unique(lambda_Astep,'rows');
    c_Astep           = c_Astep(ind);
    CV_Astep          = CV_Astep(ind);
    maxviol_Astep     = maxviol_Astep(ind);
    
    % Step 2) A-Step
    % This step interpolates critical values outside of the evaluation
    % points
    % Make sure design points are not too close together
    [lambda_dmodel,ind1] = uniquetol(lambda_Astep,1e-10,'ByRows',true);
    maxviol_dmodel_BCS = maxviol_Astep(ind1,:);
    dace_theta_BCS = dace_theta(KMSoptions.component);
    dace_lob_BCS = dace_lob(KMSoptions.component);
    dace_upb_BCS = dace_upb(KMSoptions.component);
    dmodel = dacefit(lambda_dmodel,maxviol_dmodel_BCS,@regpoly0,@corrgauss,dace_theta_BCS,dace_lob_BCS,dace_upb_BCS);
    
    
    % Step 3) M-Step
    % This step draws new point for next iteration
    % The next point(s) are drawn using Jones' expected improvement method
    % with constraints.  Briefly: a prior is put over the constraints and
    % the next point(s) are drawn to maximize the expected gain in the
    % objective function.  The expected improvement function can be written
    % as a minimax problem.  We, however, write the minimax problem so that
    % fmincon can solve it, since we found that fminimax is unstable in
    % simulations.
    %
    % Define h_L(lambda) = inf_{p'theta=lambda}Q(theta)-c(theta), which are the
    % the standardized moments.  The expected improvement objective
    % function can be written as:
    %
    %   max_j(lambda - lambda_#)_{+}*Phi(h_L(lambda)/sigma_L(lambda))
    %
    % where  h_L(lambda) and sigma_L(lambda) are estimated from the DACE
    % model, and lambda_# is the point that maximizes the objective function
    % lambda subject to the constraint that lambda is in the set
    % S = {lambda_1,...,lambda_L : CV(lambda_l) = 0},
    % i.e., the set of lambda's already explored that are feasible.
    % We can further simplify the problem by searching over
    % the space of lambda satisfying lambda  >= lambda_# and drop the
    % (.)_{+} operator.
    % Find points that have 0 constraint violation.  The auxiliary
    % feasible search gaurantees that such a point exists (namely,
    % lambda_feas.
    feas = find(maxviol_Astep <= CVtol);
    lambda_feas = lambda_Astep(feas,:);
    maxviol_feas = maxviol_Astep(feas);
    [~,ind] = max(sgn_q*lambda_feas);
    lambda_hash = lambda_feas(ind,:).';
    maxviol_hash = maxviol_feas(ind);
    
    % Linear constraints:
    % We require that lambda >= lambda_#
    % Constraints are in the form D*lambda <= d.  So set d=-lambda_# and
    %   D = -1.
    % If the projection vector, q, is a basis vector we can embed these
    % constraints into box constraints.  Otherwise, we embed them as a
    % polytope constraints Ax <= b.
    
    % Update lower/upper bounds
    LB_EI = LB_lambda;
    UB_EI = UB_lambda;
    if sgn_q == 1
        LB_EI = lambda_hash;
        UB_EI = lambda_hash + (opt_bound-lambda_hash)/(h_rate^contraction_counter); % Shrink parameter space by h_rate
    else
        LB_EI = lambda_hash - (lambda_hash - opt_bound)/(h_rate^contraction_counter);
        UB_EI = lambda_hash;
    end
    
    % Due to numerical error, it is possible that the LB or UB violates
    % the UB and LB imposed by user.  We correct for this by
    % overwriting LB_EI and UB_EI if either violates LB or UB.
    LB_EI = max(CI_lo,LB_EI);
    UB_EI = min(CI_hi,UB_EI);
    

    % Update opt_dagger
    % We have contracted the parameter space, so we need to update the
    % maximum value of lambda s.t. lambda in parameter space.
    if sgn_q == 1
        opt_dagger   = UB_EI;
    else
        opt_dagger   = LB_EI;
    end
    
    % Draw initial points between evaluation points.
    % The points are drawn in a particular way so that the search algorithm
    % is more likely to converge.
    % r_max is the distance from lambda_hash to the boundary.
    r_max = abs(opt_dagger - lambda_hash);
    r_max = max(r_max, r_min);
    [lambda_keep,EI_keep]  = BCS_36_drawpoints(lambda_hash,sgn_q,r_max,r_min,dmodel,LB_EI,UB_EI,KMSoptions);
    
    if ~isempty(lambda_keep)
        % Draw initial points between evaluation points.
        % The points are drawn in a particular way so that the search algorithm
        % is more likely to converge.
        % (See Matthias Schonlau; William J Welch; Donald R Jones, 1998)
        lambda_0_fminimax = KMS_AUX4_MSpoints([lambda_keep;lambda_hash]);
        lambda_0_fminimax = unique(lambda_0_fminimax,'rows');
        
        % Find lambdas that have positive EI and drop those with EI = 0
        Eimprovement = @(lambda)BCS_37_EI_value(lambda,sgn_q,lambda_hash,dmodel,KMSoptions);
        EI_fminimax = zeros(size(lambda_0_fminimax,1),1);
        if parallel
            parfor jj = 1:size(lambda_0_fminimax,1)
                try
                    EI_fminimax(jj,1) = Eimprovement( lambda_0_fminimax(jj,:).');
                catch
                    EI_fminimax(jj,1) = -1;
                end
            end
        else
            for jj = 1:size(lambda_0_fminimax,1)
                try
                    EI_fminimax(jj,1) = Eimprovement( lambda_0_fminimax(jj,:).');
                catch
                    EI_fminimax(jj,1) = -1;
                end
            end
        end
        % Keep solutions with positive expected improvement
        ind = find(EI_fminimax <= 0);
        lambda_0_fminimax(ind,:) = [];
        EI_fminimax(ind,:) = [];
        
        % Sort by EI
        [EI_fminimax,I] = sort(EI_fminimax,'descend');
        lambda_0_fminimax = lambda_0_fminimax(I,:);
        
        % Keep top EI_multi_num
        lambda_0_fminimax(EI_multi_num+1:end,:) = [];
    else
        lambda_0_fminimax = [];
    end
    % Include lambda_hash and lambda_eps
    lambda_eps = lambda_hash + sgn_q*(1e-4);
    lambda_0_fminimax = [lambda_0_fminimax;lambda_hash;lambda_eps];
    
    % Number of initial points:
    multistart_num = size(lambda_0_fminimax,1);
    
    % Run fmincon with multistart
    lambda_Mstep      = zeros(multistart_num,1);
    EI_Mstep         = zeros(multistart_num,1);
    flag_conv        = zeros(multistart_num,1);
    
    % Objective and constraint
    objective_Eimprovement = @(lambda)BCS_34_EIobj(lambda,sgn_q,lambda_hash,dmodel,KMSoptions);
 %   constraint_Eimprovement = @(lambda)BCS_35_EI_constraint(lambda,sgn_q,lambda_hash,dmodel,KMSoptions);
    
    % Solve using fmincon from each initial point lambda_0_fminimax.
    if parallel
        parfor ii = 1:multistart_num
            try
                lambda = lambda_0_fminimax(ii);
                [x,fval,exitflag] = fmincon(objective_Eimprovement,lambda,[],[],[],[],...
                    LB_EI,UB_EI,[],options_fmincon);
                lambda_Mstep(ii) = x;
                EI_Mstep(ii,1) =  -fval;
                flag_conv(ii,1) = exitflag;
            catch
                lambda_Mstep(ii) = lambda_0_fminimax(ii);
                EI_Mstep(ii,1)    = 0;
                flag_conv(ii,1)   = -1;
            end
        end
    else
        for ii = 1:multistart_num
            try
                lambda_aug = [lambda_0_fminimax(ii);0];
                
                [x,fval,exitflag] = fmincon(objective_Eimprovement,lambda_aug,[],[],[],[],...
                    LB_EI,UB_EI,[],options_fmincon);
                lambda_Mstep(ii) = x;
                EI_Mstep(ii,1) =  -fval;
                flag_conv(ii,1) = exitflag;
            catch
                lambda_Mstep(ii) = lambda_0_fminimax(ii);
                EI_Mstep(ii,1)    = 0;
                flag_conv(ii,1)   = -1;
            end
        end
    end
    % Keep soltuions that are feasible
    ind = find(flag_conv<= 0);
    lambda_Mstep(ind) = [];
    EI_Mstep(ind) = [];
    
    % Check solutions are inside the parameter space
    A_aug = [1; -1];
    b_aug = [UB_EI;-LB_EI];
    size_opt = size(lambda_Mstep,1);
    ind = find(max(A_aug*(lambda_Mstep.') - repmat(b_aug,[1,size_opt])) > 0).';
    lambda_Mstep(ind,:) = [];
    EI_Mstep(ind,:) = [];
    
    % Percent of runs that converged to lambda with positive EI.
    percent_conv = 100*size(find(EI_Mstep>1e-15),1)/multistart_num;
    
    % Drop solutions with expected improvement = 0
    ind = find(EI_Mstep ~= 0);
    lambda_Mstep = lambda_Mstep(ind,:);
    EI_Mstep    = EI_Mstep(ind);
    
    % Sort by expected improvement.
    % NB: we include both initial points and those that were found from the
    % maximization problem
    EI_Mstep = [EI_Mstep;EI_keep];
    lambda_Mstep = [lambda_Mstep;lambda_keep];
    
    [EI_Mstep,I] = sort(EI_Mstep,'descend');
    lambda_Mstep = lambda_Mstep(I,:);
    
    [lambda_Mstep,I2] = uniquetol(lambda_Mstep,1e-8,'ByRows',true);
    EI_Mstep = EI_Mstep(I2);
    
    % Resort (problem with shuffling after uniquetol)
    [EI_Mstep,I] = sort(EI_Mstep,'descend');
    lambda_Mstep = lambda_Mstep(I,:);
    
    % Keep top EI_num points
    lambda_Mstep(EI_num+1:end,:) = [];
    EI_Mstep(EI_num+1:end,:) = [];
    
    % Plus draw unif_num from {lambda : p'lambda >= p'lambda#}
    lambda_draw = KMS_AUX2_drawpoints(unif_num,1,LB_EI,UB_EI,KMSoptions);
    lambda_Estep = [lambda_Mstep;lambda_draw];
    if isempty(I) ==0
        EI = EI_Mstep(1);
    else
        EI = nan;
    end
    
    % Also add a small distortion of lambda# to lambda_Estep
    delta1 = abs(maxviol_hash)/(h_rate2^contraction_counter);
    delta2 = EAM_lambdadistort;
    delta3 = 10*EAM_lambdadistort;
    if sgn_q == 1
        lambda_eps1 = min(lambda_hash + sgn_q*delta1,UB_lambda);
        lambda_eps2 = min(lambda_hash + sgn_q*delta2,UB_lambda);
        lambda_eps3 = min(lambda_hash + sgn_q*delta3,UB_lambda);
    else
        lambda_eps1 = max(lambda_hash + sgn_q*delta1,LB_lambda);
        lambda_eps2 = max(lambda_hash + sgn_q*delta2,LB_lambda);
        lambda_eps3 = max(lambda_hash + sgn_q*delta3,LB_lambda);
    end
    % lambda_eps = [lambda_eps1;lambda_eps2;lambda_eps3];
    lambda_eps = lambda_eps2;
    % lambda_eps = [];
    
    % Check lambda_eps1,lambda_eps2 are inside the parameter space
    if ~isempty(lambda_eps)
    A_aug = [1; -1];
    b_aug = [UB_EI;-LB_EI];
    size_opt = size(lambda_eps,1);
    ind = find(max(A_aug*(lambda_eps.') - repmat(b_aug,[1,size_opt])) > 0).';
    lambda_eps(ind,:) = [];
    lambda_Estep = [lambda_Estep;lambda_eps];
    end
    
    % temp_EI = ['EI points:', num2str(lambda_Mstep)];
    % disp(temp_EI)
    % temp_add = ['Additional points:', num2str(lambda_eps)];
    % disp(temp_add)

    % Step 4) Print Results and Convergence
    % Program converges when expected improvement is less than
    % "best" current value of objective function divided by 100.
    opt_val = lambda_hash;
    if isempty(I) ==0
        opt_EI_proj = lambda_Mstep(1,:);
    else
        opt_EI_proj = nan;
    end
    change_EI_proj = abs(opt_EI_proj  - opt_val);
    change_proj =abs(opt_val - opt_val_old);
    feas_points = sum(maxviol_Astep <= CVtol);
    Output = [iter, opt_val, change_EI_proj, change_proj,maxviol_hash,feas_points,multistart_num , percent_conv,contraction_counter];
    fprintf('%9.4f     |   %9.4f      | %9.4e               | %9.4f      | %9.4f    | %9.4f          | %9.4f          | %9.4f           | %9.4f            \n',Output)
    
    % Check for convergence
    % If the best feasible point are too close to the parameter boundary,
    % conclude that we have converged but output warning -- the KMS theory
    % does not hold if the parameter is on the boundary, so we may not get
    % correct covereage
    if abs(opt_val - opt_bound) < 1e-4
        lambda_hat     = lambda_hash;
        lambda_optbound= opt_val;
        theta_hash = zeros(1,dim_p);
        theta_hash(:,component) = lambda_hash;
        [c,CV] = KMS_31_Estep(theta_hash,f_ineq,f_eq,f_ineq_keep,f_eq_keep,f_stdev_ineq,f_stdev_eq,G_ineq,G_eq,KMSoptions);
        EI =  EI(1);
        flag_opt =1;
        warning('Parameter is on the boundary.  The confidence set might not deliver the correct coverage.  Consider expanding the parameter space.')
        feas = find(maxviol_Astep <= CVtol);
        lambda_feas_out = lambda_Astep(feas,:);
        return;
    end
    if (iter >= EAM_minit &&  change_EI_proj < EAM_obj_tol && change_proj < EAM_tol && feas_points>num_feas && abs(opt_dagger - lambda_hash) > 1e-4 && abs(maxviol_hash) <EAM_maxviol_tol)
        lambda_hat     = lambda_hash;
        lambda_optbound= opt_val;
        theta_hash = zeros(1,dim_p);
        theta_hash(:,component) = lambda_hash;
        [c,CV] = KMS_31_Estep(theta_hash,f_ineq,f_eq,f_ineq_keep,f_eq_keep,f_stdev_ineq,f_stdev_eq,G_ineq,G_eq,KMSoptions);
        EI =  EI(1);
        flag_opt =1;
        feas = find(maxviol_Astep <= CVtol);
        lambda_feas_out = lambda_Astep(feas,:);
        return;
    end
    
    
    % Step 5) Update contraction counter
    if abs(change_proj) < 1e-6 || isnan(opt_EI_proj)
        % If change_proj = 0, contract parameter space
        contraction_counter = contraction_counter+1;
    elseif abs(opt_dagger - lambda_hash) < 1e-4 && contraction_counter ~=0
        % If lambda# is close to the boundary and we updated lambda (change_proj > 1e-5), then expand the parameter space.
        contraction_counter = contraction_counter-1;
    end
    
    % Step 6) Update optimal value
    opt_val_old = opt_val;
end

% If failed to converge, output failure flag
lambda_hat = lambda_hash;
lambda_optbound = opt_val;
theta_hash = zeros(1,dim_p);
theta_hash(:,component) = lambda_hash;
[c,CV] = KMS_31_Estep(theta_hash,f_ineq,f_eq,f_ineq_keep,f_eq_keep,f_stdev_ineq,f_stdev_eq,G_ineq,G_eq,KMSoptions);
EI =  EI(1);
flag_opt = 0;
feas = find(maxviol_Astep <= CVtol);
lambda_feas_out = lambda_Astep(feas,:);

end








