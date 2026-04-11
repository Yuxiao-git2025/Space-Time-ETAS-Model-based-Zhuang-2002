% Here prepare your data and try not to modify these data in any other 
% places except here once you have started a loop
% =========================================================================
% According to <Zhuang.2011>: For an earthquake catalog covering a long
% priod of time,the completeness and homogeneity, are always problems 
% in a statistical analysis. When seismicity in some regions or the whole
% region has an increasing trend, the ﬁtting results do not converge or 
% they converge to some unreasonable values!
% So a target space-time range was chosen in which the seismicity seems to 
% be relatively and visually complete homogeneous (here is the <R> Value)
 
function [lon,lat,time,mag,Mmin,R,R0,RNew,R0New,lonNew,latNew,BWD,np,Nx,Ny] ...
                             =Space_LoadingData()


% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
%                          \\                        //
%                           \\                      //
%                            \\                    //
%                               Data loading start
% [lon,lat,time,mag,Mmin,R,R0,BWD,np,Nx,Ny] are necessary for loading
load("timezp.mat");load("magzp.mat");load("lonzp.mat");load("latzp.mat");
[timezp,sortID]=sort(timezp);
magzp=magzp(sortID);
lonzp=lonzp(sortID);
latzp=latzp(sortID);
N1=365*0;
N2=N1+365;
sed=timezp>=N1 & timezp<=N2;
% sed=1:length(timezp);
time=timezp(sed); mag=magzp(sed); lon=lonzp(sed);lat=latzp(sed);
for j=1:20
    Loc=VaryLoc([lon,lat],4e-4);
    lon=Loc(:,1); lat=Loc(:,2);
end
% Tips: You can try larger Mc-value if your data is inhomogeneous 
% because <MAXC> method always underestimate the Mc,may rectify it to +0.1~0.2
% upMmin=0.0;
Mmin=0.6;

% !!!
% Remember that <R> here does not need to be enclosed at the beginning and the end
% And the target polygon must be input in the counter-clockwise order
% !!!

% R=[ 
%  130.0 29.0
%  132.9 30.0
%  144.1 35.2
%  143.9 38.2
%  143.8 44.3
%  138.8 41.2
%  136.4 38.2
%  135.1 37.0
%  129.6 30.4
%  ];
% (np=dimension(R))
% np=9;
% R=[min(lon) min(lat)
%     max(lon) min(lat)
%     max(lon) max(lat)
%     min(lon) max(lat)
%     ];
% np=4;

R=[103.1013 30.9341
  103.1855  30.6016
  103.5450  30.6027
  103.9000  31.0136
  103.9000  31.3973
  103.1000  31.3995];
np=6;
% B0 is minimum bandwidth and Num is used to calculate the bandwidth (5~20)
B0=0.001;
Num=5;
% Grid lines number
Nx=300;
Ny=300;






%                          \\                        //
%                           \\                      //
%                            \\                    //
%                                Data loading end
% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
% >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
idx=find(mag>=Mmin);
lon=lon(idx);
lat=lat(idx);
time=time(idx);
mag=mag(idx);
R0=[min(lon) max(lon) min(lat) max(lat)];
[RNew,R0New,lonNew,latNew]=Space_ModifyData(R,R0,lon,lat,np);
BWD=Space_BandWiDth(lonNew,latNew,Num,B0);
if isempty(Mmin)
    Mmin=min(mag);
    disp('Notice We are using Mc=min(mag) in the catalog!');
end

end
function Loc=VaryLoc(LL, EPS)
    if nargin < 2 || isempty(EPS)
        EPS = 1e-4;  
    end
    Loc = LL;
    [~, ~, ic] = unique(Loc, 'rows', 'stable');
    maxGroup = max(ic);
    for g = 1:maxGroup
        idx = find(ic == g);   
        if numel(idx) > 1
            dupIdx = idx(2:end);
            nDup  = numel(dupIdx);
            jitter = EPS * (rand(nDup, 2) - 0.5);

            Loc(dupIdx, :) = Loc(dupIdx, :) + jitter;
        end
    end
end
