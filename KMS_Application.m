function []     = KMS_Application(component,alpha)
%% Code description
% This code applies KMS to an empirical example using the KMS_0_Main code.
%
% Key Parameters to set below:
%   Component       The component of the paramter vector that we build
%                   projected confidence sets for.
%
%   DGP             Equal to 9
%
%   alpha           Significance level
%
%   method          Equal to 'KMS' or 'AS', depending on the method to
%                   build the confidence set.  'AS' tends to overinflate
%                   the confidence set
%
%   name            Name of file to save to results folder
%
%   KMSoptions      Structure of options set by user.
%clear
%clc

%% Key Parameters:
method      = 'KMS';    % Method - either AS or KMS
DGP         = 9;        % DGP9 is for the empirical example
%alpha       = 0.05;     % Significance level
%component   = 1;        % Component of theta to build confidence interval around
rho_UB      = 0.85;
name        = strcat(method,'_DGP=',num2str(DGP),'_coverage=',num2str(100*(1-alpha)),...
    '_component=',num2str(component),'_rhoUB=',num2str(rho_UB));

phi   = @(x)(min(x,0));

%% Load Data:
% convert data so that W=[y1,y2,x1,x2,x3) where (y1,y2) entry outcomes for firm
% 1,2 and (x1,x2,x3) binary variables for market presence and market size
M = csvread('./Data/airlinedata.dat');
LCCmedianPres = median(M(:,1));
OAmedianPres = median(M(:,2));
sizeMedian = median(M(:,3));

W = zeros(size(M,1), size(M,2));

W(:,1) = M(:,4);
W(:,2) = M(:,5);
W(:,3) = (M(:,1) >= LCCmedianPres);
W(:,4) = (M(:,2) >= OAmedianPres);
W(:,5) = (M(:,3) >= sizeMedian);
n = size(W,1);

%% Set KMSoptions
KMSoptions_app  = KMSoptions_Application();

% Calculate suppX and psuppX below
suppX = [0 0 0; 1 0 0; 0 1 0; 0 0 1;
    1 1 0; 1 0 1; 0 1 1; 1 1 1];
dim_suppX = size(suppX,1);
psuppX = zeros(dim_suppX,1);
for i=1:n
    for j = 1:dim_suppX
        if W(i,3:5)==suppX(j,:)
            psuppX(j) = psuppX(j)+1;
        end
    end
end
psuppX = psuppX./n;

KMSoptions_app.suppX = suppX;
KMSoptions_app.psuppX = psuppX;

% Set other KMSoptions_app
KMSoptions_app.DGP = DGP;
KMSoptions_app.n = n;
KMSoptions_app.component = component;
%KMSoptions_app.boundary = 1;
KMSoptions_app.boundary = 0;
seed = KMSoptions_app.seed;
B    = KMSoptions_app.B;
stream = RandStream('mlfg6331_64','Seed',seed);
RandStream.setGlobalStream(stream)

%% Parameters
type = 'two-sided';         % Two-sided or one sided test?  Set to 'one-sided-UB' or 'one-sided-LB' or 'two-sided'
kappa =NaN;                 % Default kappa function
%phi   = NaN;                % Default GMS function

%% Application specific parameters
if DGP == 9
    dim_p=9;
    LB_theta = [-8;-2;-2;-8;-2;-2;-4;-4;0];  % Lower bound on parameter space
    UB_theta = [2;3;10;2;3;10;0;0;rho_UB];
    theta_0 = 0.5*UB_theta + 0.5*LB_theta;
    p = zeros(dim_p,1);
    p(component) = 1;
    KMSoptions_app.S =  0;   % Rho Polytope Constraints
    A_theta = [];
    b_theta = [];
    CVXGEN_name = strcat('csolve_DGP',num2str(DGP));  
elseif DGP == 10
    dim_p=8;
    LB_theta = [-8;-2;-2;-8;-2;-2;-4;-4];  % Lower bound on parameter space
    UB_theta = [2;3;10;2;3;10;0;0];
    theta_0 = 0.5*UB_theta + 0.5*LB_theta;
    p = zeros(dim_p,1);
    p(component) = 1;
    KMSoptions_app.S =  0;   % Rho Polytope Constraints
    A_theta = [];
    b_theta = [];
    CVXGEN_name = strcat('csolve_DGP',num2str(DGP));  
end

%% Run KMS
t1 = tic;
[KMS_confidence_interval,KMS_output] = KMS_0_Main(W,theta_0,...
            p,[],LB_theta,UB_theta,A_theta,b_theta,alpha,type,method,kappa,phi,CVXGEN_name,KMSoptions_app);
timeKMS = toc(t1);

%% Save results
date = datestr(now, 'yyyy_mm_dd_HH_MM_SS');
filename = strcat('Results/KMS_Application_results_',name,date,'.mat');
save(filename)
end
