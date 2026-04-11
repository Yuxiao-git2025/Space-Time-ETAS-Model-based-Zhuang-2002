function Space_OutputMapping(BackRate,TrigRate,colname)
% Here don't use the rectified longitude cause we are mapping >>
global R0 Nx Ny 
linesx=linspace(R0(1),R0(2),Nx);
linesy=linspace(R0(3),R0(4),Ny);
if Nx~=Ny
    error('Check the dimension and Roload');
end
if ~isempty(colname)
    map=slanCM(colname);
else
%     map=Space_MappingColor(22);
    col=[ 
%         0.4314    0.9804    0.9804;
         0.4314    0.9804    0.9804;
          1.0000    0.7882    0.9294;
        1.0000    0.0745    0.6510];
    map=Inter_ColorMP(col,20);
end
% [TotalRate]=BackRate+TrigRate;
% Cmax=log10( max(max(TotalRate)) );
% Cmin=log10(min( min(min(BackRate)),min(min(TrigRate))));
Cmax=2.5;
Cmin=-2;

%                              << Total >>
figure;
tiledlayout(1,2,'TileSpacing','compact','Padding','compact');
nexttile;
% imagesc(linesx,linesy,log10(TotalRate));
% % Space_GridMapping;
% colormap(map);
% clim([Cmin Cmax]);
% c=Space_Colormap_HandelSet;
% title(' Total Rate ');


%                              << Background >>
imagesc(linesx,linesy,log10(BackRate));
Fun_Decorat;
% axis('tight');
% Space_GridMapping;
colormap(map);
clim([Cmin Cmax]);
axis xy;
Fun_SetTickNumber(gca,3);
title(' Background Rate ');


%                              << Cluster >>
nexttile;
% axis('tight');
imagesc(linesx,linesy,log10(TrigRate));
Fun_Decorat;
% Space_GridMapping;
colormap(map);
clim([Cmin Cmax]);
c=Space_Colormap_HandelSet;
Fun_SetTickNumber(gca,3);
title(' Cluster Rate ');
set(gcf,'position',[100,60,1400,680])

% %                              << Ratio >>
% figure;
% ratio=TrigRate./TotalRate;
% imagesc(linesx,linesy,(ratio));
% % Space_GridMapping;
% colormap(map);
% c=Space_Colormap_HandelSet;
% title(' Cluster Ratio ');
end