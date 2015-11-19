%PUNTO 4 TALLER DE CONTROL 1
clear
syms s
disp('Funcion Transferencia Ecuaci�n 3.a)')
g1=(5/s+2*s-6)/(2*s^2+4*s+1)
[num,den]=numden(g1);
v1=sym2poly(num);
v2=sym2poly(den);
[z,p,k]=tf2zp(v1,v2) %polos,ceros y ganancia
figure(1)
pzmap(v1,v2)%grafica polos y ceros
disp('Funcion Transferencia Ecuaci�n 3.b)')
g2=(10*s-8/s+1)/(5*s^3+3*s^2+s-2)
[num,den]=numden(g2);
v1=sym2poly(num);
v2=sym2poly(den);
[z,p,k]=tf2zp(v1,v2) %polos,ceros y ganancia
figure(2)
pzmap(v1,v2)%grafica polos y ceros
disp('Funcion Transferencia Ecuaci�n 3.c)')
g3=(6-6*s-2/s)/(6*s^2-12*s+1)
[num,den]=numden(g3);
v1=sym2poly(num);
v2=sym2poly(den);
[z,p,k]=tf2zp(v1,v2) %polos,ceros y ganancia
figure(3)
pzmap(v1,v2)%grafica polos y ceros
disp('Funcion Transferencia Ecuaci�n 3.d)')
g4=(7/s+28*s-32)/(4*s^2+1)
[num,den]=numden(g4);
v1=sym2poly(num);
v2=sym2poly(den);
[z,p,k]=tf2zp(v1,v2) %polos,ceros y ganancia
figure(4)
pzmap(v1,v2)%grafica polos y ceros

%%%%punto 5 y 6%%%%%
G1=1/(s*(s+2)*(s+3))
[num,den]=numden(G1);
v1=sym2poly(num);
v2=sym2poly(den);
[r,p,k]=residue(v1,v2) %fracciones parciales
ilaplace(G1) %transformada inversa de Laplace
G2=(2*s+2)/(s*(s^2+s+2))
[num,den]=numden(G2);
v1=sym2poly(num);
v2=sym2poly(den);
[r,p,k]=residue(v1,v2) %fracciones parciales
ilaplace(G2) %transformada inversa de Laplace
G3=10/((s+1)^2*(s+3))
[num,den]=numden(G3);
v1=sym2poly(num);
v2=sym2poly(den);
[r,p,k]=residue(v1,v2) %fracciones parciales
ilaplace(G3) %transformada inversa de Laplace


