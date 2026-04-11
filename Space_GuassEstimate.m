% =========================================================================
%                   Variable Weighted Kernel Estimates
% Notice: The Background intensity u(x,y) deﬁnes the long term distribution 
% of seismicity over the spatial region being considered; Many assume that 
% seismicity is constant with u=1, but it is unrealistic obviously
% =========================================================================
% Actually, this is a effictive way to estimate the activity rate
% But it is difficult to captures all underlying uncertainty and allows for 
% a fully <probabilistic> estimate of the level of background seismicity in
% a geographical region, so <Bayesian> method arises up to fill the vacuum

function u1=Space_GuassEstimate(fai)
global time lonNew latNew BWD
N=length(lonNew);
u1=zeros(N, 1);
T=time(end)-time(1);

% Creat a matrix (NxN) to save distance therefore making loops faster
lonNew=lonNew(:);  latNew=latNew(:);
dx=lonNew-lonNew'; dy=latNew-latNew';
R2=dx.^2+dy.^2; 

% k(r) = 1/(2πd^2) * exp(-r^2/(2d^2))
GUASS = @(r,d) (1 ./ (2*pi*d.^2)) .* exp(-r./(2*d.^2));

for i=1:N
    % Loop for event i
    GuassValue=GUASS(R2(:,i),BWD);
    Guasum=sum(fai.*GuassValue);

    u1(i)=Guasum/T;
    if u1(i) < 1e-10
        u1(i) = 1e-10;
    end
end

end