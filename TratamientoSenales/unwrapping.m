% Program 3_1
clear all %borrando memoria 
clc		 %borrando la pantalla
close all %cierra todas ventanas tipo figure
f = input('Número de puntos de frecuencia = ');% Lee la longitud de la DFT
num = input('Coeficientes numerador = ');  %|Lee los coeficientes de la DFT en el numerador y denominador
den = input('coeficientes denominador = ');%|
w = 0:pi/f:pi;         %|calcula la respuesta en frecuencia
df = freqz(num, den, w);%|nota: freqz vector de respuesta de frecuencia compleja
subplot(2,2,1)         %posicionando grafica 1 en ventana de figura
plot(w/pi,real(df));grid%graficando parte real de la respuesta en frecuencia
title('Parte Real')
xlabel('\omega/\pi'); ylabel('Amplitud')
subplot(2,2,2)			  %posicionando grafica 2 en ventana de figura
plot(w/pi,imag(df));grid%graficando parte imaginaria de la respuesta en frecuencia
title('Parte Imaginaria')
xlabel('\omega/\pi'); ylabel('Amplitud')
subplot(2,2,3)         %posicionando grafica 3 en ventana de figura
plot(w/pi,abs(df));grid %graficando el espectro de magnitud de la respuesta en frecuencia
title('Espectro De Magnitud')
xlabel('\omega/\pi'); ylabel('Magnitud')
subplot(2,2,4)          %posicionando grafica 4 en ventana de figura
plot(w/pi,angle(df));grid%graficando el espectro de fase de la respuesta en frecuencia
title('Espectro De Fase')
xlabel('\omega/\pi'); ylabel('Fase(radián)')
unw=unwrap(angle(df)); %proceso de unwrapping al espectro de fase por presentar saltos o discontinuidades
figure(2)	%ventana figura 2		
plot(w/pi,unw);grid  %graficando el espectro de fase con unwrap
lim1=min(unw)-1;lim2=max(unw)+4;  %|definiendo el eje de la gráfica
x1=w(1)/pi;x2=w(f+1)/pi;          %|
axis([x1 x2 lim1 lim2])  			 %|
title('Espectro De Fase Con Unwrap') 
xlabel('\omega/\pi');ylabel('Fase(radián)')

%student: Jesús A. Castro Code:0410403031

