function ctr=Space_Center(Gridx,Gridy,np)

        area=0;
        ymoment=0;

        for i=1:np
          temp=Gridx(i)*Gridy(i+1)-Gridx(i+1)*Gridy(i);
          area=area+temp;
          ymoment=ymoment+(Gridy(i)+Gridy(i+1))*temp;
        end
        area=area/2;
        ctr=ymoment/6/area;
end