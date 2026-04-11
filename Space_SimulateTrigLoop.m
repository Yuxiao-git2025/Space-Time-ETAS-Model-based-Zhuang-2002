%===========================================
% Loop the Randomoffs function get the <n> generations
% Called it Branching Process
%===========================================
function [Loopcata]=Space_SimulateTrigLoop(Foretime,paramNew,Incat,Region,Disp)
global mag Mmin
if nargin < 5
    Disp=true;
end
count=0;
toff=[]; xoff=[]; yoff=[]; magoff=[];
% Loopout=[];
while ~isempty(Incat)
    % Sum the historical mag-data and obtain b-value
    % Notice beta-value is very critical to the simulation ! a low b-value can
    % trigger more events than larger one
    % Here we ues a way that calculate each b-value in generations,
    % (Every time a new offspring is obtained, by fitting the previous data
    % with the data of this offspring, a new b value is calculated, this process
    % is repeated, and the b value is calculated each time)
    % so that b-value is always changing and it may be better fitting the
    % simulating procedure
    dM=0.1;
    bvalue=cal_bvalue([mag ; magoff], Mmin, dM);
    if Disp
        fprintf('b-value is %.2f\n',bvalue);
    end
    [Incat_off] =  Space_SimulateTrig(bvalue,Foretime,paramNew,Incat,Region,Disp);
    if max(Incat(:,3)) < max(Incat_off(:,3))
        disp(['There exist Offspring-events which Mags larger than Parent-events ,' ...
            'please Notice that it may just a occasion for Random Calculation']);
    end
    Incat=[];

    Incat(:,1)=Incat_off(:,1);
    Incat(:,2)=Incat_off(:,2);
    Incat(:,3)=Incat_off(:,3);
    Incat(:,4)=Incat_off(:,4);

    if ~isempty(Incat)
        count=count+1;
        xoff=[xoff; Incat(:,1)];
        yoff=[yoff; Incat(:,2)];
        magoff=[magoff; Incat(:,3)];
        toff=[toff; Incat(:,4)];
    end
end
if ~isempty(magoff)
    Loopcata=[xoff,yoff,magoff,toff];
    Loopcata=sortrows(Loopcata,4);
else
    Loopcata=[];
end
if Disp
    fprintf('Both loop %d generations \n',count);
    fprintf('And Create %d events \n',length(toff));
    disp('=========    Loading is finished =========')
end
end