function Rate=Space_CalBackRate(params,lon0,lat0,fai)
global time lonNew latNew BWD
NT=length(time);
Nlon=length(lon0);
Nlat=length(lat0);

Rate=zeros(Nlat, Nlon);
T=time(end)-time(1);
mu=params(1);

% k(r) = 1/(2πd^2) * exp(-r^2/(2d^2))
GUASS = @(R2,d) (1 ./ (2*pi*d.^2)) .* exp(-R2./(2*d.^2));

% For each point, we should calculate it solely and it takes some time
tic;
for i=1:Nlon
    loni=lon0(i);
    %     fprintf('Now is %d Gridx\n',i);
    for j=1:Nlat
        lati=lat0(j);
        R2=(loni-lonNew).^2+(lati-latNew).^2;
        % Loop for every event
        GuassValue=GUASS(R2,BWD);
        Guasum=sum(fai.*GuassValue);

        Rate(j,i)=mu*Guasum/T;
        if Rate(j,i) < 1e-10
            Rate(j,i) = 1e-10;
        end
    end
end
toc;
end