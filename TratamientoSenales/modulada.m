%P1_6
clear all;clc      %borrando variables en memoria y pantalla
disp(' ')			 %dejando un espacio
disp('                      AMPLITUDE MODULATE SEQUENCY (fH=0.5)') 
disp(' ')
fL=input(' Asigne valor a fL: ');  %entrada de fL
n=input(' Intervalo n [N1:N2]: '); %intervalo n desde N1 hasta N2	
m = 0.4;fH = 0.5;				
xH = cos(2*pi*fH*n);
xL = cos(2*pi*fL*n);
y = (1+m*xL).*xH;
x1=min(n);x2=max(n);					%valor minimo de n y maximo
y1=min(y)-0.5;y2=max(y)+0.5; %sumando -1 al valor minimo de variable y al maximo 1 
stem(n,y);grid on;
axis([x1 x2 y1 y2])		%definiendo ejes (para ampliar el eje y)
xlabel('Tiempo índice n');
ylabel('Amplitud');
title('A.M Sequency')