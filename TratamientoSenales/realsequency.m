%  *********gráfica de la secuencia exponencial real*******
clear all; clc %borrando variables en memoria y borrando pantalla
n=sym('n');    %convirtiendo n en variable simbólica
disp(' ')		%dejar un espacio en pantalla
disp('                    REAL EXPONENCIAL SEQUENCY x[n]=A*(alpha)^n')%mostrar en pantalla
disp(' ')
A=input(' Digite valor de A: ');%digitar valor a A
alpha=input(' Digite valor de alfa: ');%digitar valor de alfa
inter=input(' Intervalo n [N1:N2]: ');%definir intervalo n desde N1 hasta N2
if isreal(alpha)==1 & isreal(A)==1 %detectando si A y alpha son reales sino se termina el programa
   x=A*(alpha)^n;%expresión de x[n]
   z=subs(x,n,inter);%evaluando x[n] con los valores de n
   disp(' ')
   disp(' x[n]:')
   pretty(x)%imprimiendo x[n]
   x1=min(inter);x2=max(inter);%valor maximo y minimo de n
   y1=min(z)-0.5;y2=max(z)+0.5;%valor maximo + 1 de variable z y min -1
   stem(inter,z)%graficando secuencia discreta en ventana 2
   axis([x1 x2 y1 y2]);grid on
   xlabel('Índice n');ylabel('Amplitud');title('Sucesión x[n]')
end