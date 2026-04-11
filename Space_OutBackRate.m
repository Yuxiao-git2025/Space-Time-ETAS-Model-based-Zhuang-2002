function [BackRate,Linesx,Linesy]=Space_OutBackRate(params,fai)
global R0New Nx Ny
% Cal Background Grid-lines, try keep range from 100 to 400 
if isempty(Nx)
    Nx=150; end
if isempty(Ny)
    Ny=150; end
if Nx~=Ny
    error('Check the dimension of Gird-Number and Reload ');
end
lon1=R0New(1); lon2=R0New(2);
lat1=R0New(3); lat2=R0New(4);

Linesx=linspace(lon1,lon2,Nx);
Linesy=linspace(lat1,lat2,Ny);
BackRate=Space_CalBackRate(params,Linesx,Linesy,fai);
end