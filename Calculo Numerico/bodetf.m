clear  %borrar valores de variables en memoria
syms s %declarando 's' como simbolica
hs=input('Escriba funcion de transferencia: ');%entrada de f.transferencia
[n,d]=numden(hs);%obtener numerador y denominador: 'n' y 'd'
n1=sym2poly(n);%numerador a forma de vector 
d1=sym2poly(d);%denominador a forma de vector
hs1=tf(n1,d1)%conviertiendo a formato de f.transferencia
bode(hs1)%grafica de magnitud y de fase de bode
grid on%activar cuadricula de cada grafica

%nombre del archivo: bodetf