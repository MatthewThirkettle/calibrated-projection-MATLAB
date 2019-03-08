function [Dg] = KMS_AUX5_numgradient(theta0,g_theta,hh)
% This function computes the numerical centered gradient of function g(theta).
% theta    is pp-by-1
% g(theta) is a function that inputs theta and outputs q-by-1 vector

pp              = size(theta0,1);
g_theta0        = g_theta(theta0);
qq              = size(g_theta0,1);
Dg              = zeros(qq,pp);
for ii = 1:pp
    theta1     = theta0;
    theta2     = theta0;
    theta1(ii) = theta0(ii) - hh;
    theta2(ii) = theta0(ii) + hh;
    g_theta1   = g_theta(theta1);
    g_theta2   = g_theta(theta2);
    Dg(:,ii)   = (g_theta2 - g_theta1)/(2*hh);
end


end