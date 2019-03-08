function [EI,dEI] = BCS_34_EI_obj(lambda,sgn_q,lambda_hash,dmodel,KMSoptions)
%% Code description: Expected Improvement with fmincon
% This function computes the objective of the fminimax program using
% fmincon.  The objective function is simply gamma, a constant.  
%
% The objective function is max_{lambda,gamma) gamma, and the constraints
% are F_j(lambda) <= gamma, where F_j(lambda) is the expected improvement of
% the ith moment.
%
% INPUT:
% lambda_aug     2-by-1 parameter vector, which includes gamma in
%               its last component
%
% sgn_q          1-by-1 scalar.  This is either  1 or -1.
%
% lambda_A       S-by-dim_p matrix of parameter vectors previously explored.    
%
% dmodel        DACE kriging model (computed using lambda_A)
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
%   Ei          J-by-1 vector of expected improvements for each moment 
%               inequality minus gamma.  
%
%   dEi         J-by-dim_p matrix of gradients of expected improvement
%               inequality constraints minus 1.

%% Extract relevant information for BCS_EAM from KMSoptions
dim_lambda = 1;

%% Expected Improvement
% We compute expected improvement for each moment inequality j=1...J:
%   EI_j = (q'lambda - q'lambda_#)_{+}*Phi( (h_j(lambda) - c(lambda))/s(lambda))
% where h_j(lambda) is the standardized moment
%   h_j(lambda) = sqrt(n)*m_j(X,lambda)/sigma(X)
% and c_L(lambda), s_L(lambda) are from the DACE auxillary model.
% Note that we are searching over the space of lambda such that 
%   q'lambda >= q'lambda_#
% so the max(0,.) is not required.

% Step 1) c(lambda) and s(lambda)
% Approximated value of c(lambda) using DACE
% If gradient is required, we calcualte gradient of c.

    if nargout == 1
    g_lambda    = predictor(lambda,dmodel);
    else
    [g_lambda,dg_lambda] = predictor(lambda,dmodel);
    end


% Compute s^2(lambda) 

    if nargout == 1
        [~,~,mse,~]=predictor(lambda,dmodel);
        s = sqrt(mse);
    else
        [~,~,mse,dmse]=predictor(lambda,dmodel);
        s = sqrt(mse);
        ds = 0.5*dmse./s;
    end
 

% Step 3) Compute expected improvement minus gamma
EI = sgn_q*(lambda - lambda_hash)*(1-normcdf(g_lambda/s));
EI = -EI; % fmincon is used to minimize -EI

%% Gradient (if required)
% The gradient of expected improvement is
%
% dEI_j  = term1 + term2*term3 
%        = (q.').*(-Phi(.)) + q.'(lambda - lambda#)(-phi(.))* dArg/dlambda)
%
% where dArg/dlambda = -( (dh + dc)s - (h+s)ds)/s^2
%
if nargout > 1
    % First term: (q.').*Phi(.)
    term1 = sgn_q.*(1-normcdf(g_lambda/s));
    
    % Second term: q.'(lambda - lambda#)phi(.) 
    term2 = sgn_q*(lambda - lambda_hash)*(-normpdf(g_lambda/s));
    
    % Third term: dArg/dlambda is the derivative of the term inside the
    % argument of the normal CDF.  For this, we need the gradient of the
    % standardized moment conditions, gradient of c(lambda), and gradient 
    % MSE.
   
    % Derivative of the term inside the arguement of the CDF:
	  	term3 = (dg_lambda*s - g_lambda.*ds)/s^2;

    % Gradient of EI
    DEI = term1 + term2.*term3;
    dEI = - DEI;
end


end
