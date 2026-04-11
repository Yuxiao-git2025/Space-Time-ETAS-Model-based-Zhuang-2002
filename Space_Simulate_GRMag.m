function newmag=Space_Simulate_GRMag(bvalue)
global Mmin time mag
bta=bvalue*log(10);
Econst=0.5772;
% Euler constant = lim[ ∑1/i-log(n) ] with n=+inf =0.5772 (Zhuang.2004)
Mmax=Mmin+(log(length(time))+Econst)/bta;
if Mmax>max(mag)
    Mmax=max(mag);
end
coef=exp(-bta*Mmin) - exp(-bta*Mmax);
newmag=-log(exp(-bta*Mmin) - rand()*coef) / bta;

end