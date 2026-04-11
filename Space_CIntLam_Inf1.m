function [LL2]=Space_CIntLam_Inf1(u,params)
global time mag Mmin 
% =========================================================================
%                           Calculate Integral
% <Schoenberg.2013> using infinite <time & space> region
% In <Kolev and Ross.2019>, it was shown that the inﬁnite <time> assumption 
% can be inaccurate
% =========================================================================
% Also we can work on the finite temporal region [0,T] and within infinite 
% spatial region (-∞,+∞) (Notice the integral of space equal to 1)
% This approximation is correct under the assumption that all triggered aftershocks
% occur in the spatio-temporal testing region 
n=length(time);

mu=params(1); 
A=params(2);
alpha=params(3);
c=params(4); 
p=params(5);
d=params(6);
q=params(7); 
gama=params(8);
kapam = A * exp(alpha * (mag - Mmin));
ssig = d * exp(gama * (mag - Mmin));

dtend=time(n)-time(1:n-1);
Int_time_terms=1-(1+dtend./c).^(1-p);
Int_triger_terms=kapam(1:n-1);
Int_space_terms=1; % Int=1

TermInt=Int_triger_terms.* Int_time_terms.* Int_space_terms ;
Sumtrig=sum(TermInt);
% =========================================================================

% <1> Defualt simply calculate the background rate
BKGD=zeros(n,1);
for k=1:n
    if k==1 
        BKGD(k)=0;
    else
        % Multiply every backgound rate 
        BKGD(k)=mu*u(k)*(time(k)-time(k-1));
    end
end
Sumbkgd=sum(BKGD);
% =========================================================================
LL2=Sumbkgd+Sumtrig;

end