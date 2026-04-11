function Space_TimeSequenceMapping(params,fai,u_xy,Lamda)
global time mag
figure;
Fun_SlanMapping(time,fai,mag,fai,'\phi','rainbow');
xlim('tight');

figure;
subplot(3,1,1);
plot(time,params(1)*u_xy,'LineWidth',1.2,'Color',[ 0.3020    0.7451    0.9333]);
xlabel('Time'); ylabel('Back Rate'); Fun_Decorat;xlim('tight');
ax=gca;
ax.YScale='log';
subplot(3,1,2);
plot(time,Lamda,'LineWidth',1.2,'Color',[  1.0000    0.4118    0.1608]);
xlabel('Time'); ylabel('\lambda');xlim('tight');Fun_Decorat;
ax=gca;
ax.YScale='log';
subplot(3,1,3);
MT1Plot(time,mag);
xlabel('Time'); ylabel('Magnitude');xlim('tight');Fun_Decorat;

end