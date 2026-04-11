function [LL2]=Space_CIntLam(params,fai)
global time mag  Mmin RNew  lonNew latNew BWD np
% The sum of log-lamda is easy to accomplish but this is hard
n=length(time);
xp=RNew(:,1);
yp=RNew(:,2);

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
Int_time_terms=(1-(1+dtend/c).^(1-p));
Int_triger_terms=kapam(1:n-1);
% =========================================================================
%                             Cal Intergral of Lamda
% >>> <Ogata 1998> Method  & <Daley and Vere-Jones.2003> concept
Int_space_terms = zeros(n-1,1);
for j=1:n-1
    Int_space_terms(j) = Space_Int( ...
        @Space_IntFunc, params,mag(j),Mmin, xp, yp, np, lonNew(j),latNew(j));
end
% >>> Numerical Integral Method
% for j=1:n-1
%     Int_space_terms(j)=...
%         Space_Int_int2(params, mag(j), Mmin, xp, yp,np, lonNew(j), latNew(j));
% end

% >>> Guass-Legendre Integral Method
% for j=1:n-1
%     Int_space_terms(j)=...
%         Space_Int_Legenre(params, mag(j), Mmin, xp, yp,np, lonNew(j), latNew(j));
% end



Int_time_terms=Int_time_terms(:);
Int_triger_terms=Int_triger_terms(:);
Int_space_terms=Int_space_terms(:);
% Make sure that all terms are vertical !!
TermInt=Int_triger_terms.* Int_time_terms.* (Int_space_terms) ;
Sumtrig=sum(TermInt);

% =========================================================================
% Similarly the background integral can be estimated as follows:
Int0=Space_GuassEstimate0(time,xp, yp, np, lonNew, latNew, BWD,fai);
Sumbkgd=Int0*mu;
% The background occurrence Int-rate and trigger Int-rate of the point process
% can be calculated separately and are provided by other functions
% (see Space_Tirg_bkgd.m for more details)
LL2=Sumbkgd+Sumtrig;


end
