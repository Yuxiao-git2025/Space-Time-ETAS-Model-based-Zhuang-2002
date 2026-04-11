% R0 is the background lines that is rectangle
function Space_SimulateMapping(Backeve,Trigeve)
global R R0 Mmin lon lat mag time

maxmag0=max(mag);
disp(['If there are events which Mags larger than Initial Catalog;' ...
    ' they will be plotted'])
%==========================================
a=5;
b=1;

%==========================================
xbak=Backeve(:,1); xoff=Trigeve(:,1);
ybak=Backeve(:,2); yoff=Trigeve(:,2);
magbak=Backeve(:,3); magoff=Trigeve(:,3);
tbak=Backeve(:,4); toff=Trigeve(:,4);
%==========================================
figure;
Fun_Decorat;
AddMap(R0(1:2),R0(3:4))
% lon=cata(:,2); lat=cata(:,3); mag=cata(:,4); time=cata(:,5);
[in, ~] = inpolygon(lon, lat, R(:,1), R(:,2));
in1=m_scatter(lon(in),lat(in),4.^(mag(in)) /10,'linewidth',1);
innumber=sum(in);
hold on
in2=m_scatter(lon(~in),lat(~in),4.^(mag(~in)) /10,'linewidth',1);
in2.MarkerFaceColor=[ 0.9020    0.9020    0.9020];
in2.MarkerEdgeColor=[ 0.5020    0.5020    0.5020];
in1.MarkerFaceColor=[ 1.0000    0.6118    0.6118];
in1.MarkerEdgeColor=[ 0.6353    0.0784    0.1843];
in1.MarkerFaceAlpha=0.8;
in2.MarkerFaceAlpha=0.6;
%==========================================
Rin=m_plot([R(:,1);R(1,1)],[R(:,2);R(1,2)],'r--','LineWidth',2);

leg=legend([in1,in2,Rin],['Initial Events ' num2str(innumber) ' (in)'], ...
    ['Initial Events ' num2str(length(lon)-innumber) ' (out)'],'Grid lines');
leg.Box="on"; leg.FontWeight="bold";
leg.LineWidth=1.8; leg.Location="northeast";
leg.FontSize=13; leg.EdgeColor='k';
leg.Color='w';

hold off
%==========================================
% using the function ADDMap
figure;
AddMap(R0(1:2),R0(3:4))
Fun_Decorat;
%==========================================
bk1=m_scatter(xbak,ybak,a.^(magbak)/b, ...
    'linewidth',1);
bk1.MarkerFaceColor=[0.7098    0.9137    1];
bk1.MarkerEdgeColor=[0.3020 0.7451 0.9333];
bk1.MarkerFaceAlpha=0.6;
hold on

%==========================================
of1=m_scatter(xoff,yoff,a.^(magoff)/b, ...
    'LineWidth',1);
of1.MarkerFaceColor=[0.5020    0.5020    0.5020];
of1.MarkerEdgeColor=[ 0.1490    0.1490    0.1490];
of1.MarkerFaceAlpha=0.6;
hold on
%==========================================
R1=m_plot([R(:,1);R(1,1)],[R(:,2);R(1,2)],'r--','LineWidth',2);
hold on

%==========================================
% seartch the max-mag that over the max-mag of initial catalog
Id_off=find((magoff>maxmag0 ));
if ~isempty(Id_off)
    Id1=m_scatter(xoff(Id_off), yoff(Id_off), 90,'b','filled','LineWidth',1.5, ...
        'Marker','>');
    Id1.MarkerFaceColor=[1 0 1];
end
hold on
Id_bak=find((magbak>maxmag0 ));
if ~isempty(Id_bak)
    Id2=m_scatter(xbak(Id_bak), ybak(Id_bak), 80,'r','filled','LineWidth',1.5, ...
        'Marker','^');
end
hold off
if ~isempty(Id_off) && ~isempty(Id_bak) 
    leg_new=legend([bk1,of1,R1,Id1,Id2],'BackGround Events','Triggered Events', ...
    'Grid Lines','Triggered Maxmag','Background Maxmag');
else
    leg_new=legend([bk1,of1,R1],'BackGround Events','Triggered Events', ...
    'Grid Lines');
end
leg_new.Box="on"; leg_new.FontWeight="bold";
leg_new.LineWidth=1.8; leg_new.Location="northeast";
leg_new.FontSize=13; leg_new.EdgeColor='k';
leg_new.Color='w';

%==========================================
figure;
subplot(3,1,1)
m0=scatter(time,lat,a.^(mag)/b,'filled','MarkerFaceColor',[0.4941    0.1843    0.5569], ...
    'LineWidth',1);
Fun_defaultAxes; ylabel('lat'); title('Initial Data');
xlim('tight');

subplot(3,1,2)
m1=scatter(toff,yoff,a.^(magoff)/b,'filled','k','LineWidth',1);
Fun_defaultAxes; ylabel('lat'); title('Triggered');
xlim('tight');
subplot(3,1,3)
m2=scatter(tbak,ybak,a.^(magbak)/b,'filled','MarkerFaceColor',[0.3020    0.7451    0.9333], ...
    'linewidth',1);
Fun_defaultAxes; xlabel('Time'); ylabel('lat'); title('Background');
xlim('tight');

m0.MarkerFaceAlpha=0.6;
m1.MarkerFaceAlpha=0.6;
m2.MarkerFaceAlpha=0.6;
%==========================================
figure;

Len=length(magoff)+length(magbak);
if  Len <= 1e3 
    LWD=1.2;
elseif Len <= 5e3 
    LWD=0.9;
elseif Len <= 1e4
    LWD=0.7;
else
    LWD=0.3;
end
subplot(3,1,1)
stem(time,mag,'color',[0.4941    0.1843    0.5569],'LineWidth',LWD,'Marker', ...
    'none','BaseValue',Mmin);
Fun_defaultAxes; ylabel(['Mag']); 
xlim([min(time) max(time)]); ylim('tight');
subplot(3,1,2)
stem(toff,magoff,'k','LineWidth',LWD,'Marker','none','BaseValue',Mmin);
Fun_defaultAxes; ylabel(['Mag']);
xlim('tight'); ylim('tight');
subplot(3,1,3)
stem(tbak,magbak,'LineWidth',LWD,'Marker','none','BaseValue',Mmin);
Fun_defaultAxes; xlabel('Time (days)'); ylabel(['Mag']);
xlim('tight'); ylim('tight');
end