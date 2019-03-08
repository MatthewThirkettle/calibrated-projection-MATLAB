
clear
clc
%alpha = [0.05;0.1;0.15];
alpha = [0.05];
J = size(alpha,1);
for jj = 1:J
    for ii = 1:9
        KMS_Application(ii,alpha(jj))
    end
end
