function Intline = Space_IntMethod0(func, d, x1, y1, x2, y2, xc, yc)
r1=dDist(x1, y1, xc, yc);
r2=dDist(x2, y2, xc, yc);
r12=dDist(x1, y1, x2, y2);

Dets=(x1*y2+y1*xc+x2*yc)-(x1*yc+x2*y1+xc*y2);
idx=sign(Dets);  % (Dets<0 then idx=-1)

if abs(Dets) < 1e-10
    Intline=0;
    return;
end
xita=(r1^2 + r2^2 - r12^2)/(2*r1*r2);
if(abs(xita)>1)
    xita=1-1e-10;
end
theta=acos(xita);
if r1+r2 > 1e-15
    term=r1/(r1 + r2);
    x0=x1 + term*(x2 - x1);
    y0=y1 + term*(y2 - y1);
else
    Intline = 0;
    return;
end
r0 = dDist(x0, y0, xc, yc);
f1 = func(r1, d);
f2 = func(r0, d);
f3 = func(r2, d);

% Simpson
Intline = idx*(f1/6 + f2 * 2/3 + f3/6)*theta;
end