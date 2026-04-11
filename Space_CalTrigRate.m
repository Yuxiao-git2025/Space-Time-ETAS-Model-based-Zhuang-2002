function Rate=Space_CalTrigRate(params,lon0,lat0,fai)
global time lonNew latNew BWD 
NT=length(time);
Nlon=length(lon0);
Nlat=length(lat0);

Rate=zeros(Nlat, Nlon);
Tend=time(end);
mu=params(1); 
% =========================================================================
% This version is to calculate real Rate using parameters we get
% A=params(2);
% alpha=params(3);c=params(4); p=params(5);
% d=params(6); q=params(7); gama=params(8);
% % For each point, we should calculate it solely and it takes some time
% tic;
% kapam = A * exp(alpha * (mag - Mmin));
% ssig = d * exp(gama * (mag - Mmin));
% for i=1:Nlon
%     loni=lon0(i);
% 
%     for j=1:Nlat
%         lati=lat0(j);
%         % Loop for every event
%         dt=Tend-time(1:end-1);
%         trig_terms1 = kapam(1:end-1);
%         time_terms1 = (p-1)/c*(1+dt/c).^(-p);
%         dx=loni-lon(1:end-1);
%         dy=lati-lat(1:end-1);
%         R2=(dx.^2+dy.^2);
%         space_terms1= (q-1)./( pi*ssig(1:end-1) ) .*( (1+R2./ssig(1:end-1)).^(-q) );
%         Term=trig_terms1.* time_terms1.* space_terms1;
%         % Sum up
%         TrigSum= sum(Term);
%         Rate(j,i)=TrigSum;
%         if Rate(j,i) < 1e-10
%             Rate(j,i) = 1e-10;
%         end
%     end
% end
% toc;



% =========================================================================
% This version is to calculate Rate using kernel estimate (like Zhuang.2002)
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
        Guasum=sum((1-fai).*GuassValue);

        Rate(j,i)=mu*Guasum/(Tend-time(1));
        if Rate(j,i) < 1e-10
            Rate(j,i) = 1e-10;
        end
    end
end
toc;
end