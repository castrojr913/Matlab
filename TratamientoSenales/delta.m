%**************GRÁFICA DE LA SUCESIÓN DE IMPULSO UNITARIO O 'DELTA'******************** 
clear all; clc %borrando variables de memoria y borrando pantalla 
n=sym('n');    %convirtiendo a n como variable simbólica
disp(' ')      %dejando un espacio en la pantalla 
disp(' 			   UNIT SAMPLE SEQUENCE x[n-n0]=delta[n-n0]')%mostrar en pantalla
disp(' ')      %dejando un espacio en la pantalla 
A=input(' Argumento de la sucesión delta[n-n0]: '); %escribir argumento de la sucesión ej: n-1,n+5,n,etc.
inter=input(' Intervalo para n [N1:N2]: ');%definir intérvalo n: valores desde N1 de 1 en 1 hasta N2
long=length(inter);%calculando longitud del intérvalo
v=sym2poly(A);%convirtiendo el argumento n-n0 escrito en A en un vector
v1=-(v(2))/(v(1));%hallando el valor de n en el cual el delta = 1
v2=zeros(1,long);%sacando un vector de ceros de longitud = a la longitud del intervalo n
for k=1:long%--------- |comparando los valores de n, en cada posición k, del vector inter  |
   if inter(k)==v1%--- |con el valor de n calculado (v1) donde delta=1. Si es igual, se    |
      v2(k) = v2(k)+1;%|asigna el 1 a la posición k respectiva en el vector v2 sino queda  |
   end%----------------|con un 0 por ser un vector de ceros. v2 se usa para definir la data|
end%-------------------|de la sucesión delta respecto al intérvalo n                       |   
x1=min(inter);x2=max(inter); %valor minimo de n y maximo
y1=min(v2)-0.5;y2=max(v2)+0.5;   %valor maximo + 1 de variable v2 y min -1
stem(inter,v2)     %graficando la sucesión en la ventana 
axis([x1 x2 y1 y2]);			  %definir ejes	
grid on;                     %colocar cuadrícula en la gráfica
xlabel('Índice n');          %colocar etiqueta en el eje x de la gráfica  
ylabel('Amplitud');          %colocar etiqueta en el eje y de la gráfica
title('Unit Sample Sequence')%titule la gráfica
      


