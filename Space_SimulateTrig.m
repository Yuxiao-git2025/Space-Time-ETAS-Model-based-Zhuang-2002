function [Incat_off] = Space_SimulateTrig(bvalue,Foretime,paramNew,Incat,Region,Disp)
global R Mmin np lon lat
if isempty(bvalue)
    bvalue=0.9+0.2*rand();
end
if nargin < 6
    Disp=true;
end

xn=Incat(:,1);
yn=Incat(:,2);
magn=Incat(:,3);
tn=Incat(:,4);

beta=bvalue*log(10);
% beta=2.3 when b=1

A=paramNew(2);
alpha=paramNew(3);
c=paramNew(4);
p=paramNew(5);
d=paramNew(6);
q=paramNew(7);
gamma=paramNew(8);
%===========================================
Nevent=length(xn);
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
%                            Debate on the G-R Law
% To avoid generating so large a magnitude, we can use other distributions
% to replace the exponential one (Kagan & Schoenberg.2001)
% An <exponential-law> in terms of earthquake magnitudes which transforms into 
% a <Pareto> distribution (Pareto.1897) in terms of scalar seismic moments 
% Empirically observe that the G-R law appears to overpredict the frequencies
% of large seismic moments so you can try other prob-density function
%===========================================
Mmax=Mmin+(log(length(magn))+0.5772)/beta;
 if Mmax>max(magn)
     Mmax=max(magn);
 end
coef=exp(-beta*Mmin)-exp(-beta*Mmax);

%===========================================
x=zeros(3e4,1);
y=zeros(3e4,1);
z=zeros(3e4,1);
t=zeros(3e4,1);
m=zeros(3e4,1);

mark=0;
%===========================================
% Based on the triggering capability K(m), the expected triggering number 
% is generated, and it follows a Poisson distribution
kapam=A*exp(alpha.*(magn-Mmin));
n=poissrnd(kapam,Nevent,1);

for i=1:Nevent

    if (n(i) >= 1)   % Only when n>1 an event can be triggered
        %===========================================
        %                          \\  Time  //
        Ran_time=c*(nthroot( 1-rand(n(i),1),1-p ) -1)+tn(i);
        % nthroot is used to avoid complex number
        Intime=(Ran_time <= 0.0+Foretime  &  Ran_time > tn(i));
        Ran_time=Ran_time(Intime);
        N_Intime=sum(Intime);   nnc(i)=N_Intime;
        % Count the number of sub-events that meet the event window,
        % and accumulate it 


        %===========================================
        if(N_Intime>0)  % Only an event in time-region can be used for next
            %===========================================
            %                          \\  Magnitude  //
            Ran_dep=zeros(N_Intime,1);
            Ran_mag=-log(exp(-beta*Mmin)-rand(N_Intime,1)*coef)/beta;
            %===========================================
            %                          \\  Location  //
            % theta:2*pi*rand;
            % r=rand;  
            % Integral of f(x,y|m):
            % F(x,y,m)=(1-( 1+r^2/(d*exp(gamma*(magn-Mc))) )^(1-q) )/(2*pi)
            Ran_theta=2*pi*rand(N_Intime,1);
            scale=d*exp(gamma* (magn(i)-Mmin) );
            Ran_radii=sqrt(scale*(nthroot(1-rand(N_Intime,1),1-q)-1));
            % Obtained Coordinates：cos(theta)*r 
            Ran_lon=Ran_radii.*cos(Ran_theta)/cosd(Centro)+xn(i);
            Ran_lat=Ran_radii.*sin(Ran_theta)+yn(i);

            % ===========================================
            [in,~]=inpolygon(Ran_lon,Ran_lat,RA(:,1),RA(:,2));
            temp=sum(in);
            if (temp>0)  % Only an event in space-region can be recorded
                m(mark+1:mark+temp)=Ran_mag(in);
                t(mark+1:mark+temp)=Ran_time(in);
                x(mark+1:mark+temp)=Ran_lon(in);
                y(mark+1:mark+temp)=Ran_lat(in);
                z(mark+1:mark+temp)=Ran_dep(in);
                mark=mark+temp;
                nncc(i)=temp;
            end
            % ===========================================
        end
    end
end
m(mark+1:end)=[];
t(mark+1:end)=[];
x(mark+1:end)=[];
y(mark+1:end)=[];
% z(mark+1:end)=[];

%===========================================
Incat_off=[x, y, m, t];
Incat_off=sortrows(Incat_off,4);

if Disp
    if ~isempty(Incat_off)
        fprintf('The Group Maxmag= %.2f \n',Mmax);
        fprintf('Triggering Ability is= %.2f \n',sum(n)/Nevent);
        disp('After triggered in the catalog :')
        fprintf('There is %d number of triggering events \n',sum(n))
        disp('Further : ');
        fprintf('While there are %d events in the time spans\n',sum(nnc))
        disp('Further : ');
        fprintf('While there are %d events in the Area strictly\n\n\n',sum(nncc));
    else
        disp('========= Triggered events is finished =========')

    end
end
end


