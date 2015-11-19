clc,clear;
[sig,fm]=wavread('origen');
Mu=input('Factor de compresión: ');
Vmax = max(sig);
% cuantizamos la señal 
%[quants,distor] = quantiz(sig,0:floor(V),0:ceil(V));
% comprension de la señal 
sig1 = compand(sig,Mu,Vmax,'mu/compressor');
% Cuantizamos la señal comprimida
sig2 = quantiz(sig1,0:floor(Vmax),0:ceil(Vmax));
% ** GRAFICAS **
subplot(3,1,1)
plot(sig); 
title('Entrada')
subplot(3,1,2)
plot(sig2,'c--'); % señal cuantizada
title('Cuantizada')
subplot(3,1,3)
plot(sig,sig2) % relación señal comprimida vs señal de entrada
title('Entrada vs cuantizada')
wavwrite(sig2,fm,'out'); % archivo de audio a partir de señal cuantizada

