%programa para  graficar la magnitud en 3d H(z)

%NOTA_1: considerando a z=s+i*w donde s=frecuencia neperiana (sigma)
%y w frecuencia angular (omega). Por lo que, z corresponde a la frecuencia
%compleja. Entonces, sigma se refiere a la parte de real de z y w a la 
%parte imaginaria de z.
%NOTA_2: la grafica en 3d parte de la funcion de transferencia H(z)
%H(z)=(bn*z^n + bn-1*z^(n-1)+...+b1)/(an*z^n + an-1*z^(n-1)+...+a1)
%para el intervalo de la grafica va desde a hasta b [a,b]

clear all
clc
disp(' ')
disp('       GRAFICA DE MAGNITUD EN 3D DE H(Z) ')
disp(' ')
s=sym('s');
w=sym('w');
num=input(' Escriba numerador [bn bn-1 ... b1]: ');
den=input(' Escriba denominador [an an-1 ... a1]: ');
num_1=poly2sym(num,'z');%convierte el vector en un polinomio
den_1=poly2sym(den,'z');
hz=num_1/den_1; %funcion de transferencia requerida
disp(' ')
disp('H(z)=')
pretty(hz)%imprimiendo con formato
hz_1=subs(hz,s+i*w); %reemplazando z por s+i*w
hz_2=real(hz_1); %parte real de H(z)
hz_3=imag(hz_1); %parte imaginaria de H(z)
hz_4=20*log10(sqrt((hz_2).^2+(hz_3).^2)); %calculando la magnitud de H(z)
                                        %|H(z)|=sqrt((real)^2+(imag)^2)
                                        %H(z)db=20*log10(|H(z)|)
disp(' ')
inter_1=input('Intervalo parte real y imaginaria de z [a,b]: ');
a=inter_1(1);
b=inter_1(2);
ezmesh(hz_4,[a,b],40) %graficar en 3D con límites para la parte real y 
                      %imaginaria desde a hasta b. El grid es de 40x40.
colormap([0 0 1])
xlabel('parte real')
ylabel('parte imaginaria')
title('gráfica Hz(dB)=20log(Hz)')
