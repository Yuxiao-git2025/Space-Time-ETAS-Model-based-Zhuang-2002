
function [T1,T2,T3]=Space_SimulateWriteIn(Backeve,Trigeve,w)
if nargin < 3 || isempty(w)
    w=false;
end
All_events=[Backeve; Trigeve];
All_events=sortrows(All_events,4);

nlen1=size(Backeve,1); nlen1=(1:1:nlen1)';
nlen2=size(Trigeve,1); nlen2=(1:1:nlen2)';
nlen3=size(All_events,1); nlen3=(1:1:nlen3)';

T1=[nlen1,Backeve]; T2=[nlen2,Trigeve]; T3=[nlen3,All_events];

T1 = array2table(T1, 'VariableNames', {'num','Lon', 'Lat', 'Mag', 'Time'});
T2 = array2table(T2, 'VariableNames', {'num','Lon', 'Lat', 'Mag', 'Time'});
T3 = array2table(T3, 'VariableNames', {'num','Lon', 'Lat', 'Mag', 'Time'});
if w
%     fopen('ADD_earthquakes2.xlsx');
    writetable(T1, 'Background_earthquakes516.xlsx');
    writetable(T2, 'Simulated_earthquakes516.xlsx');
    writetable(T3, 'ADD_earthquakes516.xlsx');
    
end

end