%===========================================
% Params:[mu,A,alpha,c,p,D,q,gamma]
%===========================================
Foretime=60; 
% predicted timespan (Means we use T.[tstart tend] and predict more)

%%                     || Reconstruct Background Events ||
%                         
clc;
% Region='all';
Region='select';
[Incat] = Space_SimulateBkgd(Foretime,Fai,paramNew,Region);

%                   | Reconstruct the sequence of Aftershocks |
[Loopcata]=Space_SimulateTrigLoop(Foretime,paramNew,Incat,Region);


%%                       ||      Drawing      ||
%                                  
Space_SimulateMapping(Incat,Loopcata)


%%                      || Writing In Catalog ||
[T1,T2,T3]=Space_SimulateWriteIn(Incat,Loopcata);


%%                  || Forecasting Procedure loading ||
% Foretime=1;
Nsmp=2e3;
Sample=Space_SimulateForecast(Nsmp,Foretime,Fai,paramNew,Region);
%%                      | Forecasting Mapping | 
Space_SimulateForecastMapping(Nsmp,Sample(:,3),Foretime)


%%                   || Some debates (Backevents) ||

Space_Simulate_TrigAbility(Foretime,paramNew,Incat,Region)



