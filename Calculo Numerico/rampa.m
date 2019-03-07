%programa punto 8 (practica 5 parte2)
syms s
h1=4/(s*(s+1)+4); %funcion g1 lazo cerrado
h2=4/(s*(s-1)+4); %funcion g2 lazo cerrado
%como la rampa en funcion de s es 1/s^2 equivale
%al producto (1/s)*step en funcion de s
%por ende, multiplicamos por 1/s a la f. de transferencia y luego
%aplicamos step
hr1=4/(s*(s*(s+1)+4));
hr2=4/(s*(s*(s-1)+4));
[n1,d1]=numden(hr1);
[n2,d2]=numden(hr2);
nn1=sym2poly(n1);nn2=sym2poly(n2);
dd1=sym2poly(d1);dd2=sym2poly(d2);
r1=tf(nn1,dd1);
r2=tf(nn2,dd2);
figure(1);step(r1) %respuesta en rampa de h1
title('Respuesta rampa')
figure(2);step(r2) %respuesta en rampa de h2
title('Respuesta rampa')




