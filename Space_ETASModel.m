% =========================================================================
%                              Basic Loops
%                               2025/7/30
%                                 Xiao.Yu
% First, prepare the initial parameters and set all events as background
% events (fai=1). Then, based on the known bandwidth and fai values, easily
% calculate the initial background rate.
% =========================================================================
% Once the data is ready, new parameters will be obtained through <MLE>
% These parameters are based on the initial background rate <u0> and the
% initial parameter <param0>
% =========================================================================
% After obtaining the likelihood result under the initial parameters, the
% value of <fai> will be updated
% =========================================================================
% Within the new <fai>, the background rate <u1> is obtained through kernel
% estimation, This process is repeated continuously until the parameters
% become relatively stable.
function [paramNew,RateNew,Fai,AICNew]=Space_ETASModel(param0,HandelName)
% =========================================================================
global time 
% Tips: Here offer initial fai and u0, thus you can not give them ouside
fai0=ones(length(time),1);
u0=Space_GuassEstimate(fai0);
% To accelate the process, <AC0> can be more larger than you expected
AC0=1e-4;
MaxIter=7;
k=1;
AC=1e2;
iter=true;
tic;
while AC>AC0 && k<=MaxIter
    fprintf('>>     Now is %d / %d times     >>\n\n',k,MaxIter);
    % cal params using MLE first
    [param1,AIC1]=Space_MLE(u0,param0,fai0,HandelName,iter);
    % cal new fai and u1 then
    fai1=Space_FaiValue(u0, param1);
    u1=Space_GuassEstimate(fai1);
    % Output params if want
    paramNew=param1; RateNew=u1; Fai=fai1; AICNew=AIC1;

    % selcet (Here we don't suggest to use <global>)
    AC=abs(norm(u1-u0));
    u0=u1;
    param0=param1;
    fai0=fai1;
    k=k+1;
    fprintf('----------------------------------- \n');
end
fprintf('>>     Loading End     >>\n');
fid1=fopen('ParamIter.txt','w');
fid2=fopen('BkgdIter.txt','w');
fprintf(fid1,['Params= %.4f\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f\t%.4f' ...
    ' \n'],paramNew);
fprintf(fid2,'Background Intensity u(x,y)= \n');
fprintf(fid2,'%.4f \n',RateNew);
fclose(fid1);
fclose(fid2);
% =========================================================================
toc;
end
