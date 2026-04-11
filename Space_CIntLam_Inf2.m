function [LL2]=Space_CIntLam_Inf2( params )
global time mag Mmin 
% =========================================================================
%                           Calculate Integral
% <Schoenberg.2013> using infinite <time & space> region
% In <Kolev and Ross.2019>, it was shown that the inﬁnite <time> assumption 
% can be inaccurate
% =========================================================================
n=length(time);

mu=params(1); 
A=params(2);
alpha=params(3);
kapam = A * exp(alpha * (mag - Mmin));

Sumtrig=sum(kapam(1:n-1));
Sumbkgd=mu*(time(n)-time(1));
LL2=Sumbkgd+Sumtrig;

end