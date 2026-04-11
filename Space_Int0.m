function Int0 = Space_Int0(func, d, xp, yp, np, xc, yc)

ndiv = 50;
Int0 = 0;
if xp(1) ~= xp(end) || yp(1) ~= yp(end)
    xp = [xp; xp(1)];
    yp = [yp; yp(1)];
end

for j = 1:np

    x1_np = xp(j);
    y1_np = yp(j);
    x2_npd = xp(j+1);
    y2_npd = yp(j+1);
    
    dx = (x2_npd - x1_np)/ndiv;
    dy = (y2_npd - y1_np)/ndiv;
    
    for i = 1:ndiv
        x1 = x1_np + dx*(i-1);
        y1 = y1_np + dy*(i-1);
        x2 = x1_np + dx*i;
        y2 = y1_np + dy*i;
        % Sum
        Int0 = Int0+Space_IntMethod0(func, d, x1, y1, x2, y2, xc, yc);
    end
end
end
