function Int = Space_Int_Legenre(param, mag, Mmin, xp, yp, np, xc, yc)
    if xp(1) ~= xp(end) || yp(1) ~= yp(end)
        xp = [xp; xp(1)];
        yp = [yp; yp(1)];
    end
    d = param(6);
    q = param(7);
    gama = param(8);
    ssig = d * exp(gama * (mag - Mmin));
    Int = 0;
    
    for j = 1:np
        x1_np = xp(j);
        y1_np = yp(j);
        x2_npd = xp(j+1);
        y2_npd = yp(j+1);
        
        [x_gauss, w_gauss] = lgwt(5, 0, 1); % 5点高斯-勒让德求积
        segment_int = 0;
        
        for i = 1:length(x_gauss)
            t = x_gauss(i);
            x = x1_np + t * (x2_npd - x1_np);
            y = y1_np + t * (y2_npd - y1_np);
            
            r = sqrt((x - xc)^2 + (y - yc)^2);
            f_val = (q-1)/(pi*ssig) * (1 + r^2/ssig)^(-q);
            
            segment_int = segment_int + w_gauss(i) * f_val;
        end
        
        segment_length = sqrt((x2_npd - x1_np)^2 + (y2_npd - y1_np)^2);
        Int = Int + segment_int * segment_length;
    end
end

function [x, w] = lgwt(N, a, b)
    N = N - 1;
    N1 = N + 1;
    xu = linspace(-1, 1, N1)';
    y = cos((2*(0:N)'+1)*pi/(2*N+2)) + (0.27/N1)*sin(pi*xu*N/N1);
    L = zeros(N1, N1);
    y0 = 2;
    
    while max(abs(y - y0)) > eps
        L(:, 1) = 1;
        L(:, 2) = y;
        for k = 2:N
            L(:, k+1) = ((2*k-1)*y.*L(:, k) - (k-1)*L(:, k-1))/k;
        end
        y0 = y;
        y = y0 - L(:, N1).*(y0.^2-1)./(N1*L(:, N1));
    end
    x = (a*(1-y) + b*(1+y))/2;
    
    w = (b - a)./((1 - y.^2).*(N1*L(:, N1)).^2);
end