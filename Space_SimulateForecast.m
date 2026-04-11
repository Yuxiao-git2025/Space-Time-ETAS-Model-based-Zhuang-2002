function Sample=Space_SimulateForecast(Nsmp,Foretime,Fai,paramNew,Region)
Sample=zeros(Nsmp,3);
fprintf('Forecasting Procedure is starting, wait a moment \n\n');
tic
for i=1:Nsmp
    if mod(i, 100) == 0
        fprintf(' >>> %d / %d  \n',i,Nsmp);
    end
    Backcat=Space_SimulateBkgd(Foretime,Fai,paramNew,Region,false);
    Trigcat=Space_SimulateTrigLoop(Foretime,paramNew,Backcat,Region,false);
    Cumcat=[Backcat;Trigcat];
    Sample(i,1)=size(Backcat,1);
    Sample(i,2)=size(Trigcat,1);
    Sample(i,3)=size(Cumcat,1);
end
toc
fprintf('================ Ending =================\n')
end