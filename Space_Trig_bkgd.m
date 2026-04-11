
function [bkgd,trig]=Space_Trig_bkgd(Rate, params,fai)
global time mag Mmin RNew lonNew latNew BWD np
n = numel(time);
Tend=time(end);
xp=RNew(:,1);
yp=RNew(:,2);
bkgd=zeros(n,1);
trig=zeros(n,1);
lam = zeros(n, 1);   
loglam = zeros(n, 1);
mu=params(1); A=params(2);
alpha=params(3);c=params(4); p=params(5);
d=params(6); q=params(7); gama=params(8);
% =========================================================================
kapam = A * exp(alpha * (mag - Mmin));
ssig = d*exp(gama*(mag-Mmin));
for k = 1:n
    preK = find(time(1:k-1) < time(k));
    if isempty(preK)
        lam(k) = mu*Rate(k);  % fai(1)=1,lam(1)=mu;

    else
        dt = time(k) - time(preK);
        % Trig terms
        trig_terms1 = kapam(preK);
        time_terms1 = (p-1)/c*(1+dt/c).^(-p);
        dx=lonNew(k)-lonNew(preK);
        dy=latNew(k)-latNew(preK);
        R2=(dx.^2+dy.^2);
        space_terms1= (q-1)./( pi*ssig(preK) ) .*( (1+R2./ssig(preK)).^(-q) );
        Term=trig_terms1.* time_terms1.* space_terms1;
        % Sum up
        lam(k) = mu*Rate(k) + sum(Term);
    end
    loglam(k)=log(lam(k));
end


% =============================================================
%                           Intergral of Trig
dtend=Tend-time(1:n-1);
Int_time_terms=(1-(1+dtend/c).^(1-p));
Int_triger_terms=kapam(1:n-1);
% <Ogata 1998> method:
Int_space_terms = zeros(n,1);
TermInt = zeros(n,1);
for j=1:n-1
    Int_space_terms(j) = Space_Int( ...
        @Space_IntFunc, params,mag(j),Mmin, xp, yp, np, lonNew(j),latNew(j));
    TermInt(j)=Int_triger_terms(j)*Int_time_terms(j)*Int_space_terms(j);
    trig(j+1)=sum(TermInt);
end
% =============================================================
Intterm0 = zeros(n-1,1);
for i=1:n-1
    Intterm0(i)=mu*fai(i)*Space_Int0(@Space_IntFunc0, BWD(i), xp, yp, np, lonNew(i),latNew(i));
    bkgd(i+1)=sum(Intterm0);
end


% =========================================================================
end
