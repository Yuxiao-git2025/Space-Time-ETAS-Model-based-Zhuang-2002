function Space_RPP(TransN)
global time
N=1:length(time);
figure;
subplot(1,2,2)
plot(TransN,N,'LineWidth',2,'Color',[ 0.3294    0.6588    0.1137], ...
    'DisplayName','Predicted Events', ...
    'LineStyle','-');
% Theoretically,it should be a line with k=1 if model is fitted with data
hold on
plot(TransN,TransN,'LineWidth',2,'Color',[0.502 0.5020 0.502],'DisplayName','Poisson Process', ...
    'LineStyle','-.')
% plot CI
alpha=5e-2;
Fun_defaultAxes; xlabel('Transformed Time'); ylabel('Cumulative Events');
% legend('Location','northwest'); 
xlim('tight');  box on;

% time-events Analysis
subplot(1,2,1)
plot(time,(N),'LineWidth',2,'Color','k');
Fun_defaultAxes; box on
hold on
plot(time,TransN,'LineWidth',2,'Color','r');
xlabel('Time (days)'); ylabel('Cumulative Events');
end