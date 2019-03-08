function [minQn,theta_prof] = BCS_profiling(lambda,KMSoptions)

% This code runs BCS profiling based on the Matlab code written by Bugni, Canay, and Shi (2017)
% and returns the minimum value and minimizer of the profiled statistic.

% Extract information
theta_true  = KMSoptions.theta_true;
W           = KMSoptions.W;
alpha       = KMSoptions.alpha;
n = size(W,1);

% Primitives of DGP
theta0 = theta_true.';
dimSX = size(theta0,2)-1; % dimension of X.
coordinate = KMSoptions.component;

% options for minimization.
options = optimset('Display','off','Algorithm','interior-point'); % (this is slower).
% options = optimset('Display','off','Algorithm','active-set'); % (this is faster).

% collect entry data in a single matrix;
data =  W; %data = [dataP11,dataP10];
dataP11 = W(:,1:dimSX);
dataP10 = W(:,dimSX+1:end);

% set # of inequalities
p = 2*dimSX; % total inequalities;
k = 3*dimSX; % total (in)equalties


% determine the value of theta of interest according to H0;
theta_H0 = lambda;

% determines the value of the other thetas;
if coordinate==1
    theta_other0 = theta0(2:end);
else % coordinate = 2
    theta_other0 = [theta0(1),theta0(3:end)];
end

% indicates if H0 is true or not;
%theta_in_IS = trueH0(theta_index);

%% Compute test statistic for all tests, profile test statistic.

% Choose starting values for minimization;
starting_values = NaN(2,size(theta_other0,2)); % initialize;

% first starting value: true parameter value (unfeasible in practice)
starting_values(1,:) = theta_other0';

% second starting value: good guess based on the theory (feasible in practice)
starting_values(2,1) = 1 - mean(dataP11(:,1))/(1-theta_H0);
% the remaining starting values are randomly chosen;
for a=2:size(starting_values,2)
    if theta_other0(a)>0
        starting_values(2,a) = -(1/2)*(2-theta_H0-starting_values(2,1))+(1/2)*sqrt( (starting_values(2,1) - theta_H0)^2 + 4*mean(dataP11(:,a)) );
    else
        starting_values(2,a)=0;
    end
end

% Pick a large value as initial function value for the minimization
min_value = 10^10;

% for minimization we need the following constrains: Aineq*theta0?Bineq and (0,...,0)<=theta0<=(1,...1)
Aineq = zeros(2*(size(theta0,2)-2),size(theta0,2)-1);
Aineq(1:size(theta0,2)-2,2:size(theta0,2)-1) = eye(size(Aineq(1:size(theta0,2)-2,2:size(theta0,2)-1)));
Aineq(size(theta0,2)-1:end,2:size(theta0,2)-1) = eye(size(Aineq(size(theta0,2)-1:end,2:size(theta0,2)-1)));
Aineq(size(theta0,2)-1:end,1) = -1*ones(size(Aineq(size(theta0,2)-1:end,1)));
Bineq = zeros(2*(size(theta0,2)-2),1);
Bineq(1:(size(theta0,2)-2)) = theta_H0 * ones(size(Bineq(1:(size(theta0,2)-2))));

min_outcomes = []; % This matrix will collect results of minimization;

% solve numerical minimization for all starting values;
Qn_minimizer = [];
for s=1:size(starting_values,1)
    [theta_aux,Qn_aux,bandera] =  fmincon(@(x) Qn_function(x,theta_H0,coordinate,data,p),starting_values(s,:),Aineq,Bineq,[],[],zeros(size(theta_other0)),ones(size(theta_other0)),[],options);
    % check whether minimization is successful and reduced value
    if Qn_aux  < min_value && bandera >= 1
        Qn_minimizer = theta_aux;
        min_value = Qn_aux;
    end
    % if minimization is successful, collect minimizer and its value;
    if bandera >= 1
        min_outcomes = [min_outcomes;[min_value,Qn_minimizer]];
    end
end
% at the end of the minimizations, we should have a minimizer
if ~isempty(Qn_minimizer)
minQn = min_value;
if coordinate == 1
    theta_prof = [lambda; Qn_minimizer'];
else
    theta_prof = [Qn_minimizer(1);lambda;Qn_minimizer(2:end)'];
end
else
    theta_prof = [];
    minQn = [];
end
end