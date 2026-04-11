% =========================================================================
%                               2025/7/30
%                                 Xiao.Yu
% This version is to calculate the AIC value considering spatial region
% in a polygion (with <np> Crossing-dots), there are also some versions 
% such like spatial region is infinite and in the case of polar coordinate 
% calculation
% Note Intetral-Background-Rate <Int0> is obtained from Guass-like Estimating
% with <mu> is relax parameter and <u> is activity parameter, both of them 
% consist of background rate that: <Rate>=<mu>*<u>
% =========================================================================
function AIC= Space_AICValue(u,params,fai)

[LL1]=Space_CLogLam(u, params);
[LL2]=Space_CIntLam(params,fai);
LenParam=length(params);
% =========================================================================
% AIC Value
AIC=-2*(LL1-LL2)+2*LenParam;

end
