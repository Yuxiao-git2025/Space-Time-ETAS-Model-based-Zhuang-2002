function Space_DeclusterMapping(ind,Fai)
global lon lat time mag 
id1=(ind==0); % ind is from Declustering function
subplot(2,2,1)
Fun_SlanMapping(lon(id1),lat(id1),mag(id1),Fai(id1),'φ','cosmic');
title('Backgound');
subplot(2,2,2)
Fun_SlanMapping(lon(~id1),lat(~id1),mag(~id1),Fai(~id1),'φ','cosmic');
title('Clustered');
subplot(2,2,3)
Fun_SlanMapping(lon(id1),time(id1),mag(id1),time(id1),'Time','cosmic');
title('Time-lon');
subplot(2,2,4)
Fun_SlanMapping(lon(~id1),time(~id1),mag(~id1),time(~id1),'Time','cosmic');
title('Time-lon');

end