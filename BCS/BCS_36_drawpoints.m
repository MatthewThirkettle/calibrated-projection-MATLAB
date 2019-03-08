function [lambda_keep,EI_keep]  = BCS_36_drawpoints(lambda_hash,sgn_q,r_max,r_min,dmodel,LB,UB,KMSoptions)
%% Code description
% This code draws initial points lambda near lambda_hash.  It checks that at
% these draws satisfy EI>0.
%
% Method 1: Draw points from a box:
% A  = { lambda : sgn_q*lambda >= sgn_q*lambda_hash, d(lambda,lambda_hash) < r}
% for some tuning parameter r, where the distance metric in the infinity
% norm.  We start with r = r_max and add, say, 2 points and check expected
% improvement of these two points.  If EI > 0 we add them, otherwise
% we continue.  We reduce the size of the box: r = r/2, and add more
% points. We continue until we have either, say, 10 points or r<r_min.
%
% Method 3: Draw some points uniformly from the parameter space

%% Extract Parameters
component       = KMSoptions.component;
unif_points     = KMSoptions.unif_points;
EI_points       = KMSoptions.EI_points;
EI_points_start = KMSoptions.EI_points_start;
parallel        = KMSoptions.parallel;
sample_method   = KMSoptions.sample_method;
options_linprog = KMSoptions.options_linprog;

% Check to make sure r_max is biggest
r_max = max(r_max, r_min);

% Initiate:
r = r_max;
lambda_keep = [];
EI_keep    = [];

LB2 = LB;
UB2 = UB;

%% Draw points
flag_while = true;
while flag_while
    % Method 1: Draw points from a box around lambda#
    if sgn_q > 0
        LB1 = LB;
        UB1 = min(lambda_hash + r,UB);
    else
        LB1 = max(lambda_hash - r,LB);
        UB1 = UB;
    end
    
    lambda_draw = KMS_AUX2_drawpoints(EI_points_start,1,LB1,UB1,KMSoptions);
    size_draw = size(lambda_draw,1);
    
    % Find lambda's that have positive EI
    Eimprovement = @(lambda)BCS_37_EI_value(lambda,sgn_q,lambda_hash,dmodel,KMSoptions);
    EI = zeros(size_draw,1);
    if parallel
        parfor jj = 1:size_draw
            try
                EI(jj,1) = -(max(Eimprovement( lambda_draw(jj,:).')));
            catch
                EI(jj,1) = -1;
            end
        end
    else
        for jj = 1:size_draw
            try
                EI(jj,1) = -(max(Eimprovement( lambda_draw(jj,:).')));
            catch
                EI(jj,1) = -1;
            end
        end
    end
    
    % Sort lambda from best, and pick those that have positive EI.
    [EI,I] = sort(EI,'descend');
    lambda_draw = lambda_draw(I,:);
    ind = find(EI>1e-10);
    
    % Keep those with positive EI
    lambda_keep = [lambda_keep ; lambda_draw(ind,:)];
    EI_keep    = [EI_keep  ;EI(ind)];
    
    % Update r
    r = r/2;
    
    % If r < r_min or if we have sufficient number of points, break.
    if r < r_min || size(lambda_keep,1)  > EI_points
        flag_while = false;
    end
end

% We also draw some points uniformly from
% {lambda : sgn_q*lambda >= sqn_q*lambda#}
    lambda_draw = KMS_AUX2_drawpoints(unif_points,1,LB,UB,KMSoptions);

% Set uniformly drawn EI to zero (this might not be true, but we do not
% require EI to be positive for these points so there is no need to
% calculate it.
EI = zeros(size(lambda_draw,1),1);

% Concatenate
lambda_keep = [lambda_keep;lambda_draw];
EI_keep  =[EI_keep ; EI];

end
