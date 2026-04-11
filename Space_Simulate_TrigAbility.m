% given a catalog and params, can test its triggering ability
% here we use catalog that consists of backevents from above procedure
% =====================================================================
function Space_Simulate_TrigAbility(Foretime,paramNew,Incat,Region)
global mag Mmin
A=paramNew(2);alpha=paramNew(3);

magline=Mmin:0.02:max(mag);
% Triggering ability
Km=A*exp(alpha*(mag-Mmin));   % Poisson Random for dots
Km0=A*exp(alpha*(magline-Mmin)); % solid line
% =====================================================================
N=length(mag);
nPoi=poissrnd(Km,N,1);
fprintf('Followed Poisson Process, Triggered :%d events \n',sum(nPoi));
fprintf('Theoretical there are :%.2f events \n',(sum(Km)));

figure;
s1=scatter(nPoi,mag,2.^mag+5,'MarkerFaceColor','k','DisplayName','Poisson Random');
hold on
s2=scatter(Km,mag,2.^mag+5,'MarkerFaceColor','r','DisplayName','Theoretical');
p1=plot(Km0,magline,'LineWidth',1.82,'Color','r','HandleVisibility','off');
set(gca, 'XAxisLocation', 'top'); 
set(gca,'YDir','reverse'); 
Fun_defaultAxes; ylabel("Mag"); xlabel('Triggered Number');
box on; 
legend('FontSize',18,'FontWeight','bold');
% =====================================================================
bvalue=cal_bvalue(mag,Mmin);
[Incat_off] = Space_SimulateTrig(bvalue,Foretime,paramNew,Incat,Region,false);
magoff=Incat_off(:,3);
noff=length(magoff);
fprintf('And Finally After the selecting of Time and Area, Actually we get :%d events \n',noff);
end