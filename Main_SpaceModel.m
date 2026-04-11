%%                       ||| Data loading ||| 
                          Space_GlobalHandel;


%%             || Loops for params and Background Rate ||
param0=[ 1   0.04   1.8   0.1   1.2   0.015   1.8   0.8];

[paramNew,RateNew,Fai,AICNew]=Space_ETASModel(param0,'finite');
%%                      || Basic Plotting ||
[Lamda]=Space_CLam(RateNew, paramNew);
rescale=4e-5;
Space_TimeSequenceMapping(paramNew,Fai,RateNew*rescale,Lamda*rescale);


%%                   || Declustering Procedure  ||
[ind,rij]= Space_Decluster(RateNew, paramNew);
[bkgd,trig]=Space_Trig_bkgd(RateNew, paramNew,Fai);

Space_DeclusterMapping(ind,Fai);


%%                     ||  Background Rate Grids ||

[BackRate]=Space_OutBackRate(paramNew,Fai);
[TrigRate]=Space_OutTrigRate(paramNew,Fai);


%%                         | Mapping  Rate |
close all;
Space_OutputMapping(BackRate,TrigRate,'eclipse');


%%                        || Residual Analysis ||
TransN=bkgd+trig;
Space_RPP(TransN)









%%                        ||| Simulate loading |||
%=                                                                        =
%=                                                                        =
%=                                                                        =
%=                                                                        =
% Params:[mu,A,alpha,c,p,D,q,gamma]
% paramNew=[1.1882     0.16229      1.6852    0.038814  ...
%        1.1642   0.0022916      1.8805      1.0853];
%===========================================


%%                     || Reconstruct Background Events ||
Foretime=60; 
% predicted timespan (Means we use T.[tstart tend] and predict more)
clc;
Region='all';
% Region='select';
[Incat] = Space_SimulateBkgd(Foretime,Fai,paramNew,Region);

%                   | Reconstruct the sequence of Aftershocks |
[Loopcata]=Space_SimulateTrigLoop(Foretime,paramNew,Incat,Region);


%%                       ||      Drawing      ||
Space_SimulateMapping(Incat,Loopcata)


%%                      || Writing In Catalog ||
[T1,T2,T3]=Space_SimulateWriteIn(Incat,Loopcata);


%%                  || Forecasting Procedure loading ||
Foretime=60;
Nsmp=5e3;
Sample=Space_SimulateForecast(Nsmp,Foretime,Fai,paramNew,Region);
%%                      | Forecasting Mapping | 
Space_SimulateForecastMapping(Nsmp,Sample(:,3),Foretime)


%%                   || Some debates (Backevents) ||

Space_Simulate_TrigAbility(Foretime,paramNew,Incat,Region)




