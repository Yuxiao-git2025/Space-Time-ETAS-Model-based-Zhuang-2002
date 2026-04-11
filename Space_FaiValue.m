% This is used to calculate Background probability φ
function [fai]= Space_FaiValue(u, params)
global time mag Mmin lonNew latNew
n = numel(time);
lam = zeros(n, 1);   fai = zeros(n, 1);
loglam = zeros(n, 1);
mu=params(1); A=params(2);
alpha=params(3);c=params(4); p=params(5);
d=params(6); q=params(7); gama=params(8);

% =========================================================================
kapam = A * exp(alpha * (mag - Mmin));
ssig = d * exp(gama*(mag-Mmin));
for k = 1:n
    preK = find(time(1:k-1) < time(k));
    if isempty(preK)
        lam(k) = mu*u(k);  

    else
        dt = time(k) - time(preK);
        trig_terms1 = kapam(preK);
        time_terms1 = (p-1)/c*(1+dt/c).^(-p);
        dx=lonNew(k)-lonNew(preK);
        dy=latNew(k)-latNew(preK);
        R2=(dx.^2+dy.^2);
        space_terms1= (q-1)./( pi*ssig(preK) ) .*( (1+R2./ssig(preK)).^(-q) );
        Term=trig_terms1.* time_terms1.* space_terms1;
        lam(k) = mu*u(k) + sum(Term);

    end
    loglam(k)=log(lam(k));
    fai(k) = (mu*u(k) / lam(k));
end

end