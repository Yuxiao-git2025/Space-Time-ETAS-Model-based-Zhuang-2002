function Int=Space_Int_int2(param, mag, Mmin, xp, yp,np, xc, yc)
% Rectangle integral 
    d = param(6);
    q = param(7);
    gama = param(8);
    ssig = d*exp(gama*(mag-Mmin));

    Handle=@ (x, y) (q-1)/(pi*ssig)*(1+((x-xc).^2+(y-yc).^2)/ssig).^(-q);
    
    x1 = min(xp);
    x2 = max(xp);
    y1 = min(yp);
    y2 = max(yp);
    
    Int = integral2(Handle, x1, x2, y1, y2);
end