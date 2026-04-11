function  Space_LocationMapping(colmap)
global lon
global lat
global mag
global time
if nargin < 6
    colmap='jet';
end
if isempty(colmap)
    colmap='jet';
end
colname='Time (days)';
N=length(lat);
% Colormaps 
lc=[slanCM(colmap)];
lc2=Inter_ColorMP(lc,N);
color=colormap(lc2);
% Maker size changing 
Sizescale=4.5;
Sizescale2=1.3;
markerSize=Sizescale.^abs((mag-min(mag)+1))./Sizescale2+14;

normz=(time-min(time))./(max(time)-min(time));
coloridx=ceil(1+normz*(N-1));
markerColor=color(coloridx,:);% MarkerFaceColor

scatter(lon,lat,markerSize,markerColor,'o','filled');

set(gcf,'Color',[1 1 1])
hold on
% xlim([min(x) max(x)]);
colormap(color)
%------------------------------

clim([min(time),max(time)])
cticks=linspace(min(time),max(time),5);
ba=colorbar('Ticks',cticks,'FontSize',18);
ba.Label.String=colname;
ba.Location="southoutside";

%------------------------------
ax=gca;
ax.FontName='New Times Roman';
Fun_Decorat;
% Fun_defaultAxes;
box on;
end