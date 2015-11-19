%***************GRÁFICA DE x[n]=A*cos(omega*n+phi)**************
clear all; clc%borrando variables de memoria y borrando pantalla 
n=sym('n');	  %convirtiendo a n como variable símbolica 	
disp(' ')	  %dejando un espacio en pantalla 	
disp(' 			   COSENOIDAL SEQUENCES x[n]=A*cos(omega*n+phi)')%mostrar en pantalla
disp(' ')     %dejando un espacio en pantalla
A=input(' Digite el valor de A: ');			           %valor real de A
omega=input(' Digite el valor de omega: ');          %valor de omega
phi=input(' Digite el valor de phi: ');	           %valor de phi
inter=input(' Digite el intervalo para n [N1:N2]: ');%definir intérvalo n desde N1 hasta N2 
sal=A*cos(omega*n+phi);										  %expresión de x[n]
disp(' ');disp(' x[n]:')                             %dejar espacio y mostrar en pantalla 
pretty(sal)                                          %imprimiendo x[n] en pantalla
sinu=subs(sal,n,inter);                              %evaluando x[n] con los valores de n
x1=min(inter);x2=max(inter);								  %valor maximo y minimo de n
y1=min(sinu)-0.5;y2=max(sinu)+0.5;  					  %valor maximo + 1 de variable sinu y min -1
stem(inter,sinu)                                     %graficando x[n] en la ventana 
axis([x1 x2 y1 y2]);grid on;                         %definir cuadrícula en la gráfica  
xlabel('Índice n');											  %Coloque etiqueta en el ejex
ylabel('Amplitud');											  %Coloque etiqueta en el ejex
title('Secuencia x[n]')										  %títule la gráfica	
