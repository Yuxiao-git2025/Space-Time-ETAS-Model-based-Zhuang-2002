% =========================================================================
% Ogata (1998) mentioned:The border of Σ is sampled with a ﬁnite number of 
% points and each earthquake epicenter is radially connected with these points
% Then, the area of Σ between two successive radii is approximated with a
% circular sector, but eventually leading to a high CPU time
% =========================================================================
% xp,yp is integral region and xc,yc is location of current event
function Int = Space_Int(func, param, mag,Mmin,xp, yp, np, xc, yc)

ndiv = 50;  % such like 500~1000 it determined the accuracy of integral
Int = 0;
if xp(1) ~= xp(end) || yp(1) ~= yp(end)
    fprintf('Check the dimension of R\n');
    xp = [xp; xp(1)];
    yp = [yp; yp(1)];
end

for j = 1:np

    x1_np = xp(j);  y1_np = yp(j);
    x2_npd = xp(j+1);  y2_npd = yp(j+1);
    
    dx = (x2_npd - x1_np)/ndiv;
    dy = (y2_npd - y1_np)/ndiv;
    
    for i = 1:ndiv
        x1 = x1_np + dx*(i-1);
        y1 = y1_np + dy*(i-1);
        x2 = x1_np + dx*i;
        y2 = y1_np + dy*i;
        % Sum
        Int = Int+Space_IntMethod(func, param,mag,Mmin, x1, y1, x2, y2, xc, yc);
    end
end
end
