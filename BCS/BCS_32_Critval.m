function c_val = BCS_32_Critval(lambda,component,KMSoptions)

% Extract information needed for BCS profiling
B           = KMSoptions.B;
seed        = KMSoptions.seed;
theta_true  = KMSoptions.theta_true;
W           = KMSoptions.W;
alpha       = KMSoptions.alpha;
n = size(W,1);

% Primitives of DGP
theta0 = theta_true.';
dimSX = size(theta0,2)-1; % dimension of X.
coordinate = component;

% Set parameters
R = B;       % # of bootstrap draws
p = 2*dimSX; % total inequalities;
k = 3*dimSX; % total (in)equalties;
tolerance = 0.0001; % define what we mean by "close enough".
options = optimset('Display','off','Algorithm','interior-point'); % (this is slower).
C_list = 1; %C_list = [0.8;1]; % constant in the paper;
kappa_list = C_list*sqrt(log(n));  % GMS Thresholding parameter, preferred choice Eq. 4.4 in Andrews and Soares (2010).

% Initialization of simulator %
stream=RandStream('mlfg6331_64','Seed',seed);
RandStream.setGlobalStream(stream);
W2_AA = norminv(rand(R,n)); % Random draws for RC, RS, and MR tests

% collect entry data in a single matrix;
data =  W; %data = [dataP11,dataP10];
dataP11 = W(:,1:dimSX);
dataP10 = W(:,dimSX+1:end);

% BCS's starting values
theta_H0 = lambda;
if coordinate==1
    theta_other0 = theta0(2:end);
else % coordinate = 2
    theta_other0 = [theta0(1),theta0(3:end)];
end
starting_values = NaN(2,size(theta_other0,2)); % initialize;
starting_values(1,:) = theta_other0';
starting_values(2,1) = 1 - mean(dataP11(:,1))/(1-theta_H0);
for a=2:size(starting_values,2)
    if theta_other0(a)>0
        starting_values(2,a) = -(1/2)*(2-theta_H0-starting_values(2,1))+(1/2)*sqrt( (starting_values(2,1) - theta_H0)^2 + 4*mean(dataP11(:,a)) );
    else
        starting_values(2,a)=0;
    end
end

% Initial set estimation
% Pick a large value as initial function value for the minimization
min_value = 10^10;
Aineq = zeros(2*(size(theta0,2)-2),size(theta0,2)-1);
Aineq(1:size(theta0,2)-2,2:size(theta0,2)-1) = eye(size(Aineq(1:size(theta0,2)-2,2:size(theta0,2)-1)));
Aineq(size(theta0,2)-1:end,2:size(theta0,2)-1) = eye(size(Aineq(size(theta0,2)-1:end,2:size(theta0,2)-1)));
Aineq(size(theta0,2)-1:end,1) = -1*ones(size(Aineq(size(theta0,2)-1:end,1)));
Bineq = zeros(2*(size(theta0,2)-2),1);
Bineq(1:(size(theta0,2)-2)) = theta_H0 * ones(size(Bineq(1:(size(theta0,2)-2))));
min_outcomes = []; % This matrix will collect results of minimization;
% solve numerical minimization for all starting values;
for s=1:size(starting_values,1)
    [theta_aux,Qn_aux,bandera] =  fmincon(@(x) Qn_function(x,theta_H0,coordinate,data,p),starting_values(s,:),Aineq,Bineq,[],[],zeros(size(theta_other0)),ones(size(theta_other0)),[],options);
    % check whether minimization is successful and reduced value
    if Qn_aux  < min_value && bandera >= 1
        Qn_minimizer = theta_aux;
        min_value = Qn_aux;
    end
    % if minimization is successful, collect minimizer and its value;
    if bandera >= 1
        min_outcomes = [min_outcomes;[min_value,Qn_minimizer]]; %#ok<AGROW>
    end
end
% at the end of the minimizations, we should have a minimizer
minQn = min_value;
% Collect minimizers to estimate the indetified set (used for DR)
min_outcomes = uniquetol2(min_outcomes,tolerance,'rows'); % set of minimizers;
In_identified_set_hat = min_outcomes(min_outcomes(:,1)<=min(min_outcomes(:,1)) + tolerance , 2:end); % estimator of id set


% Update the starting values for PR
starting_values =  uniquetol2([starting_values;Qn_minimizer],tolerance,'rows');


% CV calculation
for kappa_type =1:size(kappa_list,1)
    parfor r=1:R
        warning('OFF')
        %- Step 1: Discard resampling method
        
        % Pick a large value as initial function value for the minimization;
        min_value_DR = 10^10;
        
        % Minimize but restricted to points of the estimated indentified set;
        for IDsetHat_index = 1:size(In_identified_set_hat,1)
            minQn_DR_aux = min(min_value_DR,Qn_MR_function(In_identified_set_hat(IDsetHat_index,:),theta_H0,coordinate,data,kappa_list(kappa_type),p,k,W2_AA(r,:),1));
        end
        
        % compute simulated DR criterion function
        minQn_DR(kappa_type,r) = minQn_DR_aux;
        
        %- Step 2: Penalized resampling method;
        
        % Pick a large value as initial function value for the minimization;
        min_value_PR = 10^10;
        % check whether minimization is successful and reduced value
        for s=1:size(starting_values,1)
            [theta_aux,Qn_aux,bandera] =  fmincon(@(x) Qn_MR_function(x,theta_H0,coordinate,data,kappa_list(kappa_type),p,k,W2_AA(r,:),2),starting_values(s,:),Aineq,Bineq,[],[],zeros(size(theta_other0)),ones(size(theta_other0)),[],options);
            if Qn_aux  < min_value_PR && bandera >= 1
                minimizer = theta_aux;
                min_value_PR = Qn_aux;
            end
        end
        
        % compute simulated PR criterion function
        minQn_PR(kappa_type,r) = min_value_PR ;
        
        %- Step 3: combine PR and DR to get MR
        minQn_MR(kappa_type,r) = min(minQn_DR(kappa_type,r),minQn_PR(kappa_type,r));
    end
    % Compute critical values
    cn_DR(kappa_type) = quantile(minQn_DR(kappa_type,:),1-alpha);
    cn_PR(kappa_type) = quantile(minQn_PR(kappa_type,:),1-alpha);
    cn_MR(kappa_type) = quantile(minQn_MR(kappa_type,:),1-alpha);
end
c_val = cn_MR;
end