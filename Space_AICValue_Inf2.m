% =========================================================================
% This version is to calculate the AIC value considering infinite spatial
% region in a polygion (with <np> Crossing-dots)
% The approximation is close provided the observed region contains most of 
% the aftershock activity caused by earthquakes within the observation region

function AIC=Space_AICValue_Inf2(u,params)

[LL1]=Space_CLogLam(u, params);
[LL2]=Space_CIntLam_Inf2(params);
LenParam=length(params)-1;
% AIC Value
AIC=-2*(LL1-LL2)+2*LenParam;

end
