function [gamma,dgamma] = BCS_34_EI_objective(lambda_aug)
%% Code description: Expected Improvement with fmincon
% This function computes the objective of the fminimax program using
% fmincon.  The objective function is simply gamma, a constant.  
%
% The objective function is max_{lambda,gamma) gamma, and the constraints
% are F_j(lambda) <= gamma, where F_j(lambda) is the expected improvement of
% the ith moment.
%
% INPUT:
%
% lambda_aug     (1+dim_lambda)-by-1 vector, which includes as its dim_lambda+1
%               element the parameter gamma.
%  
% OUTPUT:
%   gamma       1-by-1 constant

%   dgamma      2-by-1 gradient

dim_lambda       = 1;

%% Compute objective and gradient
gamma = lambda_aug(end,1);

if nargout > 1
    dgamma = zeros(dim_lambda+1,1);
    dgamma(end,1) = 1;
end


end