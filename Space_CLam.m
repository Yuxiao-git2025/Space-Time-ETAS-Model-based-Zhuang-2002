function [lam]=Space_CLam(u, params)
global time mag  Mmin lonNew latNew 
n=length(time);
lam=zeros(n, 1);   

mu=params(1); 
A=params(2);
alpha=params(3);
c=params(4); 
p=params(5);
d=params(6);
q=params(7); 
gama=params(8);
% =========================================================================
%                          Calculate the lamda
kapam = A * exp(alpha * (mag - Mmin));
ssig = d * exp(gama * (mag - Mmin));
for k = 1:n
%     preK = find(time(1:k-1) < time(k));
    preK=1:k-1;
    if isempty(preK)
        lam(k) = mu*u(k);  
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
        lam(k) = mu*u(k) + sum(Term);
    end
end


end