function Int0=Space_GuassEstimate0(time,xp, yp, np, xc, yc, BWD,fai)

N=length(time);
Intterm0 = zeros(N, 1);
% Very similar to the Triggering term calculation
for i=1:N
    Intterm0(i) = Space_Int0(@Space_IntFunc0, BWD(i), xp, yp, np, xc(i),yc(i));
end
Intterm0=Intterm0(:);
Int0=fai.* Intterm0;
Int0=sum(Int0);

end
