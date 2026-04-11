function Space_SimulateForecastMapping(Nsmp,Sample,Foretime,binwidth,bw)
% ===================================================================
% Obtain every sample's Catalog events
figure;
subplot(1,2,1)
Fun_SlanMapping(1:Nsmp,Sample,2.2,Sample,'Events','batlow');

bin1=min(Sample);
bin2=max(Sample);
Fun_defaultAxes;
box on;
yline(mean(Sample),'LineWidth',2.5,'Color',[0.55 0.55 0.65], ...
    'LineStyle','--', ...
    'DisplayName',['Mean Value= ' num2str(mean(Sample))]);
xlabel('No.Sample'); ylabel('Num.Events'); 
% ylim([bin1 bin2+1]);
% legend;
fprintf('In %.2f Time-span with %d Samples, obtained: \n',Foretime,Nsmp);
strMean=[sprintf('%.1f',mean(Sample))];
strStd=[sprintf('%.1f',std(Sample))];
fprintf(['Mean= ' strMean '\n']);
fprintf(['std= ' strStd '\n']);
fprintf('\n');


% ===================================================================
% Histgram the number of events in each bin
subplot(1,2,2)
yyaxis left
if nargin < 4
    binwidth=2;
end
binEdges = bin1:binwidth:bin2;
Nbin=length(binEdges);
[couts, edges] = histcounts(Sample, binEdges, 'Normalization', 'pdf');
% pdf = (number in each bin) / (number of Sample × binwidth)
% [couts, edges] = histcounts(SampleBack, binEdges);
binCenters = edges(1:end-1) + diff(edges)/2;
b1=bar(binCenters,couts,'LineWidth',0.9,'EdgeColor',[0 0.9 0.9], ...
    'FaceColor',[0.3020    0.7451    0.9333],'HandleVisibility','off');
hold on 
maxind=couts==max(couts);

xline(binCenters(maxind),'LineWidth',1.5,'Color','b', ...
    'LineStyle','--', ...
    'DisplayName',['Estimated Value= ' num2str(binCenters(maxind))]);
ylabel('pdf');
hold on
% ===================================================================
% Gaussian kernel function estimate (KDE)
if nargin < 5
    bw=0.5;
end
[f, xi] = ksdensity(Sample, 'NumPoints', 1.5*Nbin, 'Bandwidth', bw, ...
    'Function', 'pdf');
[~, maxIND] = max(f);


% CI plot 99% or 95%
SortSmp=sort(Sample);
xline(SortSmp(round(0.05*Nsmp)),'LineStyle',':','Color',[0.55 0.55 0.65],'LineWidth',2.5);
xline(SortSmp(round(0.95*Nsmp)),'LineStyle',':','Color',[0.55 0.55 0.65],'LineWidth',2.5);



% Normal Fitting 
yyaxis right
plot(edges, normpdf(edges, mean(Sample), std(Sample)),'r','LineWidth',1.5)
Fun_defaultAxes;
% legend;
box on;


xlabel(' Num.Events '); ylabel('Normal Fitting');
xlim('tight');
ax=gca;
ax.YAxis(1).Color=[0.3020    0.7451    0.9333];
ax.YAxis(2).Color='r';
str2=[sprintf('%.0f',binCenters(maxind))];
str3=[sprintf('%.0f',xi(maxIND))];
fprintf(['By using Histcouts Events= ' str2 '\n']);
fprintf(['By using kernel estimation Events= ' str3 '\n'] );
fprintf('Finally the Number Expectation=%.2f \n',sum(Sample)/Nsmp);
fprintf('Finally the Occurrence Expectation=%.2f %%\n',sum(Sample>0)/Nsmp*100);

fprintf('=================================================\n');



% Normal distribution Checking 
% QQ plot
figure;
[h] = qqplot(Sample);
h(1).LineWidth=1;
h(1).MarkerSize=8;
h(1).Marker="o";
h(1).MarkerEdgeColor='k';
h(3).LineWidth=1.5;
xlabel('Quantile'); ylabel('Num.Events'); title('QQ Plot');
Fun_defaultAxes; box on

end