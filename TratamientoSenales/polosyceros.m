%programa para calcular polos y ceros

%NOTA_1: La funcion de transferencia H(z) se define como
%H(z)=(bn*z^n + bn-1*z^(n-1)+...+b1)/(an*z^n + an-1*z^(n-1)+...+a1)

clear all
clc
disp(' ')
disp('    CALCULO Y DIAGRAMA DE POLOS Y CEROS DE H(Z)' )
disp(' ')
num=input(' Escriba numerador [bn bn-1 ... b1]: ');
den=input(' Escriba denominador [an an-1 ... a1]: ');
num_1=poly2sym(num,'z');%convierte el vector en un polinomio
den_1=poly2sym(den,'z');
hz=num_1/den_1; %funcion de transferencia requerida
disp(' ')
disp('H(z)=')
pretty(hz)%imprime con formato
polos=roots(den)%calculando las raices del denominador de H(z) (polos)
ceros=roots(num)%calculando las raices del numerador de H(z) (ceros)
hz_1=tf(num,den);%crea la función de transferencia nuevamente en este caso
                %para la grafica de polos y ceros con pzmap
pzmap(hz_1)%realiza la gráfica de polos y ceros