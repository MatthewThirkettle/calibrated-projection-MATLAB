%function BCS_EAMSimulation(ncores,taskid)
%% Code description
% This code runs simulations of EAM procedure applied to BCS's profiling method using the KMS_0_Main code.
%
% Key Parameters to set below:
%   Component       The component of the paramter vector that we build
%                   projected confidence sets for.
%
%   DGP             Equal to 8 (BCS's DGP)
%
%   alpha           Significance level
%
%   method          Equal to 'KMS' (EAM is used)
%
%   n               Sample size
%
%   name            Name of file to save to results folder
%
%   KMSoptions      Structure of options set by user.
disp('BCS_test started')

% myCluster = parcluster('local'); % cores on compute node to be "local"
% if getenv('ENVIRONMENT')    % true if this is a batch job
%   myCluster.JobStorageLocation = getenv('TMPDIR')  % points to TMPDIR
% end
% myCluster.NumWorkers=ncores;
% parpool(myCluster,ncores)        % MATLAB 2014a or newer

% For Table 1: assign tasks to multiple servers
switch task_id
case 1
    component = 1;
    alpha = 0.05;
case 2
    component = 1;
    alpha = 0.1;
case 3
    component = 1;
    alpha = 0.15;
case 4 
    component = 2;
    alpha = 0.05;
case 5
    component = 2;
    alpha = 0.1;
case 6
    component = 2;
    alpha = 0.15;
end

parpool(ncores)
disp('Finished launching workers')

%% Key Parameters:
method      = 'KMS';    % Method - either AS or KMS
DGP         = 8;        % DGP=8 is the BCS example.  
KMS         = 0;        % Set equal to 0 to run BCS_EAM simulations.
%alpha       = 0.05;     % Significance level
%component   = 1;        % Component of theta to build confidence interval around
n           = 4000;     % Sample size
Nmc         = 300;      % Number of Monte Carlos
sim_lo      = 1;        % BCScode is very slow.  We split the job between many computers.
sim_hi      = Nmc;      % We run simulations mm = sim_lo ... sim_hi.
% Default is sim_lo = 1 and sim_hi= Nmc
name        = strcat(method,'_DGP=',num2str(DGP),'_coverage=',num2str(100*(1-alpha)),'_component=',num2str(component),'_samplesize',num2str(n),'_numMC',num2str(Nmc),'_simnums=',num2str(sim_lo),'to',num2str(sim_hi),'_');
KMSoptions  = KMSoptions();

%% Extract/Save Information to KMSoptions, and set seed
KMSoptions.DGP = DGP;
KMSoptions.n = n;
KMSoptions.component = component;
seed = KMSoptions.seed;
B    = KMSoptions.B;                                                        % Bootstraps
stream = RandStream('mlfg6331_64','Seed',seed);
RandStream.setGlobalStream(stream)

%% Parameters
type = 'two-sided';         % Two-sided or one sided test?  Set to 'one-sided-UB' or 'one-sided-LB' or 'two-sided'
kappa =NaN;                 % Default kappa function
phi   = NaN;                % Default GMS function

%% Parameters that depend on DGP
if  DGP == 8
    theta_true  = [0.4 ; 0.6 ;0.1  ;0.2  ;0.3];                            % True parameter vector
    dim_p       = size(theta_true,1);
    p = zeros(size(theta_true,1),1);                                       % Projection direction
    p(component) = 1;
    KMSoptions.S =  13;                                                    % Rho Polytope Constraints
    % Param space is theta_1,theta_2 in [0,1], theta_k in
    % [0,min(theta_1,theta_2)] for k = 1,2,3.
    LB_theta    = zeros(dim_p,1);
    UB_theta    = ones(dim_p,1);
    A_theta     = [-1 0 1 0 0 ; 0 -1 1 0 0  ; -1 0 0 1 0 ; 0 -1 0 1 0  ;  -1 0 0 0 1 ; 0 -1 0 0 1 ];
    b_theta     = zeros(6,1);
    % We randomly select theta_0 from the parameter space
    theta_0     =0.5*LB_theta + 0.5*UB_theta;
    dX = size(theta_true,1)-1;                                             % dimension of X.
    psuppX = ones(dX,1)/dX;                                                % P(X=x), X is discrete uniform.
    KMSoptions.dX = dX;
    KMSoptions.psuppX = psuppX;
    selp = 0.6;                                                            % prob of P(A_1=0,A_2=1) when there is multiplicity.
    KMSoptions.selp = selp;                                                % NOTE: THIS IS THE OPPOSITE of DGP6,DGP5.
    CVXGEN_name = 'csolve_DGP8';                                           % CVXGEN file name
end

%% Generate data
if DGP == 8
    % DATA FOR BCS SIMULATION
    % Draw random variable
    data_BCS = zeros(n,2*dX,Nmc);
    Z = zeros(n,2*dX,Nmc);
    baseDatas = rand(n,4,Nmc);
    for mm = 1:Nmc
        epsilons = baseDatas(:,1:2,mm);    % epsilon in the model in section 5;
        multiple = baseDatas(:,3,mm);      % determines how multiplicity is resolved;
        
        % X denotes the market type indicator;
        X = zeros(n,1);
        for j=1:dX
            X = X + (j-1)*(baseDatas(:,4,mm)>=(j-1)/dX).*(baseDatas(:,4,mm)<j/dX) ;
        end
        betas_true = [0;theta_true(3:end)]; % vector indicates beta_q for q=1,...,d_X
        
        % Initialize matrices that will contain both entry decision and market type
        dataP11 = zeros(n,dX);
        dataP10 = zeros(n,dX);
        
        dataP11_KMS = zeros(n,dX);
        dataP10_KMS = zeros(n,dX);
        
        for j=1:dX
            % Entry decision that indices {A_1=1,A_2=1}
            Entry11_aux = (epsilons(:,1) > theta_true(1)-betas_true(j)).*(epsilons(:,2) >  theta_true(2)-betas_true(j)) ;
            
            % Entry decision that indices {A_1=1,A_2=0}
            Entry10_aux = (epsilons(:,1) > theta_true(1)-betas_true(j)).*(epsilons(:,2) <= theta_true(2)-betas_true(j)) + (epsilons(:,1) <= theta_true(1)-betas_true(j)).*(epsilons(:,2) <= theta_true(2)-betas_true(j)).*(multiple>selp);
            
            % Data for BCS
            dataP11(:,j) = Entry11_aux.*(X == j-1)/psuppX(j);               % indicates {A_1=1,A_2=1} and {X=j-1}
            dataP10(:,j) = Entry10_aux.*(X == j-1)/psuppX(j);               % indicates {A_1=1,A_2=0} and {X=j-1}
            
            % KMS can work with unconditional moments
            dataP11_KMS(:,j) = Entry11_aux.*(X == j-1);
            dataP10_KMS(:,j) = Entry10_aux.*(X == j-1);
        end
        data_BCS(:,:,mm)    = [dataP11, dataP10];
        Z(:,:,mm)           = [dataP11_KMS, dataP10_KMS];                  % Save Z to pass to KMS algorithm
    end
end

% Compute population identification region
if DGP == 8
    stream = RandStream('mlfg6331_64','Seed',seed);
    RandStream.setGlobalStream(stream)
    stream.Substream = B + B*10^3 + 2;
    addpath ./MVNorm
    Identification_region = KMS_5_identification_region(theta_true,theta_0,LB_theta,UB_theta,A_theta,b_theta,KMSoptions);
    KMSoptions.Identification_region = Identification_region;
    stream = RandStream('mlfg6331_64','Seed',seed);
    RandStream.setGlobalStream(stream)
    stream.Substream = B + B*10^3 + 3;
end

% Run BCS_EAM
if DGP == 8 && (component == 1 || component == 2) && ~KMS
    addpath ./BCS
    warning('OFF')
    disp('MC started')
    t1 = tic;
    KMSoptions.BCS_EAM = 1;
    KMSoptions.theta_true = theta_true;
    KMSoptions.alpha = alpha;
    KMSoptions.seed = seed;
    for mm = sim_lo:sim_hi
        disp(['MC iteration:' num2str(mm)])
        t2 = tic;
        KMSoptions.W = data_BCS(:,:,mm);
        W = Z(:,:,mm);
        [BCS_confidence_interval{mm},BCS_output{mm}] = KMS_0_Main(W,theta_0,...
            p,[],LB_theta,UB_theta,A_theta,b_theta,alpha,type,method,kappa,phi,CVXGEN_name,KMSoptions);
        BCS_output{mm}.totaltime = toc(t2);
    end
    totaltime_KMS = toc(t1);
    %% Cell to vector
    BCS_CI = nan(Nmc,2);
    for mm =  sim_lo:sim_hi
        BCS_CI(mm,:) = BCS_confidence_interval{mm};
    end
    
    
    %% Save  BCS
    date = datestr(now, 'yyyy_mm_dd_HH_MM_SS');
    filename = strcat('Results/BCSresults_',name,date,'.mat');
    save(filename)
end

%end


