function cmap=Space_MappingColor(Num)

cmap = zeros(Num, 3);
Mid = round(Num*2/4);
for i = 1:Mid
    r = (i-1)/(Mid-1) * 0.4;
    g = 1;                       
    b = 1;                         
    cmap(i, :) = [r, g, b];
end

for i = (Mid+1):Num
    j = i - Mid; 
    r = 0.45 + (j-1)/(Num-Mid-1)*0.55; 
    g = .9 - (j-1)/(Num-Mid-1)*0.55;   
    b = 1;                                 
    cmap(i, :) = [r, g, b];
end

cmap(Mid, :) = [0.5, 1, 1]; 
n=size(cmap,1);
% cmap(n+1,:)=[ 1.0000    0.0745    0.6510]; % pink
end
