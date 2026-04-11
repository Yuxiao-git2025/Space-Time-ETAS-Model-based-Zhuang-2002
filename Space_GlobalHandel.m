function Space_GlobalHandel()
clear global variables
% clc;
global lon lat time mag Mmin R R0 RNew R0New lonNew latNew BWD np Nx Ny
[lon,lat,time,mag,Mmin,R,R0,RNew,R0New,lonNew,latNew,BWD,np,Nx,Ny] ...
                    =Space_LoadingData();

% Mapping it 
Fun_SlanMapping(lon,lat,mag,time,'Time (days)','redshift');
hold on;
plot([R(:,1);R(1,1)],[R(:,2);R(1,2)],'LineWidth',2,'Color','r','LineStyle','--');
[in, ~] = inpolygon(lon, lat, [R(:,1);R(1,1)], [R(:,2);R(1,2)]);
xlabel('Lon');
ylabel('Lat');

fprintf('Data have been prepared and try next step \n\n');
fprintf('||  ===============================================  ||\n');
fprintf('||  Total %d events                                ||\n', length(lon));
fprintf('||  While %d events in the selected region         ||\n',sum((in)));
fprintf('||  And %d events out of region                     ||\n\n',sum((~in)));
fprintf('||  ===============================================  ||\n');

end