clear all;clc
syms x n %OJO: existe una gran problema que sin(pi)no es exactamente 0
%entonces toca coger las inf como 0/0
%%%para bn
if code==1 || code==3 || code==4 %casos de series aplicados
 d=1;N_1=0;
 [N,D]=numden(bn);
 for c=1:50%limitado hasta n=50
    N_0(c)=subs(bn,{n},{c});
    if isnan(N_0(c))==1 || isinf(N_0(c))==1%existen indeterminacion (desde n=1...50)
       N_1(d)=c;
       d=d+1;
    end
 end
 N_2=0;
 if any(N_1)==1 %mirar si los elementos del vector son cero
   d=1;e=1;
   limit_0=diff(N*sin(n*pi*x),n);
   limit_1=diff(D,n);
   for c=1:max(size(N_1))
       if any(N_1(c))==1 %mirar si hay raices enteras ~= 0 
          limit1=subs(limit_0,{n},{N_1(c)});
          limit2=subs(limit_1,{n},{N_1(c)});
            N_3(d)=limit1/limit2; 
            N_4(e)=N_1(c);%valores de n de menor a mayor desde 1 en adelante
            d=d+1;e=e+1;
        end
    end   
    N_2=max(size(N_3));%determinar Nº de funciones resultado de aplicar limite
 end
end
%%%para an
if code==2 || code==3 || code==4 %casos de series aplicados
 d=1;N1_1=0;
 [N,D]=numden(an);
 for c=1:50%limitado hasta n=50
    N1_0(c)=subs(an,{n},{c});
    if isnan(N1_0(c))==1 || isinf(N1_0(c))==1%existen indeterminacion (desde n=1...50)
       N1_1(d)=c;
       d=d+1;
    end
 end
 N1_2=0;
 if any(N1_1)==1 %mirar si los elementos del vector son cero
   d=1;e=1;
   limit_0=diff(N*cos(n*pi*x),n);
   limit_1=diff(D,n);
   for c=1:max(size(N1_1))
       if any(N1_1(c))==1 %mirar si hay raices enteras ~= 0 
          limit1=subs(limit_0,{n},{N1_1(c)});
          limit2=subs(limit_1,{n},{N1_1(c)});
            N1_3(d)=limit1/limit2; 
            N1_4(e)=N1_1(c);%valores de n de menor a mayor desde 1 en adelante
            d=d+1;e=e+1;
        end
    end   
    N1_2=max(size(N1_3));%determinar Nº de funciones resultado de aplicar limite
 end
end

    