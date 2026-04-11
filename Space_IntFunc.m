% Spatial kernel function f(x-xi,y-yi|mi)
function Fxy = Space_IntFunc(r,params,mag,Mmin)
d=params(6); q=params(7); gama=params(8);
ssig=d*exp(gama*(mag-Mmin));

% fxy=(q-1)./(pi*ssig).*(1+r.^2 ./ ssig).^(-q);
% integrate f >>
Fxy=(1-(1+r^2/ssig)^(1-q))/pi/2;
end