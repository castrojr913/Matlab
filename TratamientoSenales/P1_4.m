%***EJERCICIO P1_4***
clear all;clc
n = 0:32;      %Desde el índice 0 al 32	
f = 1/16;     %Frecuencia de 1/16 --> T = 16 			
A = 1.5;	     %amplitud de 1.5  		
x = A*cos(2*pi*f*n);
stem(n,x);		% grafica la secuencia 
axis([0 32 -2 2]);%definiendo intervalo en los ejes x y y
grid on; title('Sequence x[n]=A*cos(2*pi*(1/16)*n)');
xlabel('Index n');ylabel('Amplitude');

