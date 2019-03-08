function [EI] = BCS_37_EI_value(lambda,sgn_q,lambda_hash,dmodel,KMSoptions)
%% Code description: Expected Improvement with fmincon
% This function computes the expected improvement at theta.
%
% INPUT:
% lambda        scalar
%
% sgn_q         This is either  1 or -1.
%
% dmodel        DACE kriging model (computed using theta_A)
%
% KMSoptions    This is a structure of additional inputs held 
%               constant over the program.  In the 2x2 entry game, 
%               KMSoptions includes the support for the covariates
%               and the probability of support point occuring. 
%  
% OUTPUT:
%   Ei          J-by-1 vector of expected improvements for each moment 
%               inequality minus gamma.  


%% Extract relevant information for BCS_EAM from KMSoptions
BCS_EAM = KMSoptions.BCS_EAM;
component = KMSoptions.component;

%% Expected Improvement
% We compute expected improvement for each moment inequality j=1...J:
%   EI_j = (sgn_q*lambda - sgn_q*lambda_#)_{+}*(1-Phi( g(lambda)/s(lambdaa)))

% Step 2) c(theta) and s(theta)
% Approximated value of c(theta) using DACE
g_lambda    = predictor(lambda,dmodel);
[~,~,mse,~]= predictor(lambda,dmodel);
% Compute s(theta) 
s = sqrt(mse);

% Step 3) Compute expected improvement minus gamma
EI = sgn_q*(lambda - lambda_hash)*(1-normcdf(g_lambda/s));

end
