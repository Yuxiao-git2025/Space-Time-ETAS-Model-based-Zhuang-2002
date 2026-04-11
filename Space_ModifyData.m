% Input initial data and Output the rectified data for the next 
%===========================================
function [RNew,R0New,lonNew,latNew]=Space_ModifyData(R,R0,lon,lat,np)
format short
Rnew=R;
R0New=R0;
if size(R,1) > np
    error('Check the dimension of <R> ');
end
if size(R,1) == np
    % The beginning and the end should be connected
    R(np+1,1)=R(1,1);   R(np+1,2)=R(1,2);
end

% Start Renewal
if size(R,1) == np+1
    Gridx=R(:,1);
    Gridy=R(:,2);
    % ========================
    % Cal Center value of Region 
    Center=Space_Center(Gridx,Gridy,np);
    Ratio=cosd(Center);
    % Renew the longitude
    % ========================    
    lonNew=lon*Ratio; 
    latNew=lat;          % <1>
    % ========================
    Gridx=Gridx*Ratio;
    RNew(:,1)=Gridx;     
    RNew(:,2)=Gridy;     % <2>
    % ========================
    lon1=R0(1)*Ratio;     
    lon2=R0(2)*Ratio;
    R0New(1)=lon1;      
    R0New(2)=lon2;       % <3>

end