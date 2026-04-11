%===========================================
% Here, the inverse transformation method is used 
%===========================================
%
function [Incat] = Space_SimulateBkgd(Foretime,Fai,params,Region,Disp)
global time mag BWD R Mmin np lon lat
if nargin < 5
    Disp=true;
end
mu=params(1);
N=length(time);
%===========================================
RA=R;
switch Region
    case 'select'
        Centro=ycentroid([RA(:,1);RA(1,1)], [RA(:,2);RA(1,2)],np);
    case 'all'
        RA=[ min(lon) min(lat);
        max(lon) min(lat);
        max(lon) max(lat);
        min(lon) max(lat)];
        Centro=Space_Center([RA(:,1);RA(1,1)], [RA(:,2);RA(1,2)],4);
end
ratio=cosd(Centro);
randnum=rand(N,1);
%===========================================
% cal b-value
dM=0.1;
bvalue=cal_bvalue(mag,Mmin,dM);

Incat=[];
for i=1:N
    loca = [lon(i),lat(i)];
    % Stochastic decluster method:
    if randnum(i) < mu*Fai(i)*Foretime/(time(N)-time(1))
        %===========================================
        %                          \\  Magnitude  //
        % <A*> Following the G-R Ralation
        newmag=Space_Simulate_GRMag(bvalue);

        % <B*> resampled from the collection of the magnitudes of all the events
%         newmag=mag(i);

        %===========================================
        %                          \\  Time  //
        % The time of occurrence of events follows a uniform distribution,
        % so the event timespan delta_t between adjacent events is approximately
        % exponentially distributed.
        newt=0.0+rand()*Foretime; 

        %===========================================
        %                          \\  location  //
        % Adding a 2D Gaussian random variable, with a zero mean and a standard 
        % error of bandwidth.i
        sigma=[BWD(i)^2, 0; 0, BWD(i)^2];
        aver=0;
        rbk=mvnrnd([aver,aver], sigma, 1);
        newlon=rbk(1)/ratio + loca(1);
        newlat=rbk(2) + loca(2);

        % ===========================================
        % You can just consider what we interesting region R (R is not empty)
        % or use all events that choose <Region>='all'
        [in, on]=inpolygon(newlon, newlat, RA(:,1), RA(:,2));
%         MakeIn(i)=(in); % if in the selected region, return value=1
        if in && ~on
            Incat=[Incat; newlon(in), newlat(in), newmag(in), newt(in)];
        end


    end
end

%===========================================
% nnc=sum(MakeIn);
if ~isempty(Incat)
    Incat=sortrows(Incat, 4);
else
    Incat=[];
end
if Disp
    if ~isempty(Incat)
        disp('After selected in the catalog :')
        fprintf('There are %d background events\n\n', size(Incat,1));
        fprintf('======== Background events is finished ========\n');
    end
end
end