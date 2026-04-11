% Declustering version cause calculations are compressive
function [ind,rij]= Space_Decluster(u, params)
global time mag Mmin lonNew latNew

n = numel(time);
lam = zeros(n, 1);
fai = zeros(n, 1);
mu=params(1); A=params(2);
alpha=params(3);c=params(4); p=params(5);
d=params(6); q=params(7); gama=params(8);
% Calculate the probability of each event triggering subsequent earthquakes
% including the probability of the background term.
% Their index should be:
rij = zeros((1+n)*n/2,1);
% =========================================================================
kapam = A * exp(alpha * (mag - Mmin));
ssig = d*exp(gama*(mag-Mmin));
for k = 1:n
    preK = find(time(1:k-1) < time(k));
    if isempty(preK)
        lam(k) = mu*u(k);
        rij(k) = 1;
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

        % Refer to Stochastic Classification/Declustering
        dex=1+k*(k-1)/2;
        rij(dex:dex+k-2)=Term /(lam(k));     % Trig
        rij(dex+k-1)=1-(sum(Term)/(lam(k))); % Back
        % =============================================================
    end
    fai(k) = (mu*u(k) / lam(k));
end




U=rand(n,1);
ind=zeros(n,1);
for j=1:n
    if j>1
        dex=1+j*(j-1)/2;
        fai=rij(dex+j-1);
        rho=rij(dex:dex+j-2);
        % =================================================================
        if U(j)<fai
            ind(j)=0;
        else
            % Find the Parent of Earthquake.j
            for i = 1:j-1
                if U(j) < fai+sum(rho(1:i))
                    ind(j) = i;  % Record the Index of Parent.i
                    break; % Find the smallest.i
                end
            end
        end
        % =================================================================
    else
        ind(j)=0; % The first one is must be Backevent
    end
end
ind=ind(:);

fprintf('There are %d events in Background \n',sum(ind==0));
fprintf('There are %d events Triggered \n',sum(ind~=0));
fprintf(' \n');
end


