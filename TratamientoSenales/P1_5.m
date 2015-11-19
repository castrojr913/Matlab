%****EJERCICIO P1_5*****
% Signal Smoothing by Averaging
clear all;clc	%borrando variables en la memoria y la pantalla			
R = 60;
randn('state',0);		%|usado para generar ruido gaussiano
d = 0.3*randn(R,1);  %|Profesor, Matlab 5.3 no tiene la función wgn.m (White Gaussian Noise)
m = 0:R-1;				%definir intervalo para variable m
s = 2*m.*(0.9.^m); % Generate uncorrupted signal
x = s + d'; % Generate noise corrupted signal
subplot(2,1,1);%abriendo ventana para graficar posicionadas verticalmente. Esta grafica va en la primera posicion
plot(m,d','r-',m,s,'m--',m,x,'b-.');
xlabel('Index n');ylabel('Amplitude');
legend('d[n] ','s[n] ','x[n] ');
x1 = [0 0 x];x2 = [0 x 0];x3 = [x 0 0];  %| definiendo filtro
y = (x1 + x2 + x3)/3;		       			%|Moving Average para filtrar el ruido
subplot(2,1,2);%graficar en la ventana en la posición 2
plot(m,y(2:R+1),'r-',m,s,'m--');
legend( 'y[n] ','s[n] ');
xlabel('Index n');ylabel('Amplitude')

