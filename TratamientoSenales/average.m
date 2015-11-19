clear all                            %borrar variables de la memoria
clf %cerrar figuras
clc                                  %borrar pantalla       	
%***  CAPTURA DE SEÑAL DE AUDIO ***
disp(' ')
disp('                    FILTRO DE MOVIMIENTO PROMEDIO PARA AUDIO DE 16KHz')
disp(' ')
[audio,Fs,cbits]= wavread('muestra.wav'); %capturando la señal de audio muestra.wav
disp(' ')
fprintf('Frecuencia Archivo De Audio Original: %i\n',Fs)%imprimiendo frecuencia de señal
wavplay(audio,Fs)%reproduciendo señal
%*** Grafica de la señal ***
t=1:size(audio); %definiendo intervalo
subplot(2,2,1)   %ubicar en la posicion 1 de la ventana
plot(t,audio,'r')
xlabel('Indice n');ylabel('Amplitud');
title(' Señal Original')
% *** REMUESTREANDO LA SEÑAL DE AUDIO A 16KHZ ***
wavwrite(audio,16000,'muestra_1') %escribe archivo de audio.wav con base en la
                                  %variable audio a una Fs=16KHz                              
[audio_1,Fs,cbits]= wavread('muestra_1.wav'); %captura la señal remuestreada
fprintf('Frecuencia Archivo De Audio Remuestreado: %i\n',Fs)%imprimiendo frecuencia de señal
wavplay(audio_1,Fs)%reproduciendo señal
%*** Grafica de la señal ***
t1=1:size(audio_1);
subplot(2,2,2)  %ubicar en la posicion 2 de la ventana
plot(t1,audio_1,'r')
xlabel('Indice n');ylabel('Amplitud');
title(' Señal Remuestrada')
%*** DISTORSIÓN DE LA SEÑAL CON RUIDO BLANCO ***
d = awgn(audio_1,20,'measured','linear');%Corrompiendo la señal de audio con ruido blanco gaussiano a una SNR = 20, 
                                         %es decir la amplitud de la señal de ruido equivale es 1/20 de la amplitud de
                                         %la señal de auido por cada
                                         %muestra (5%). La SNR es lineal
sound(d,Fs)%reproducir sonido de la señal
subplot(2,2,3)  %ubicar en la posicion 3 de la ventana
plot(t1,d,'r') %graficar
xlabel('Indice n');ylabel('Amplitud');
title(' Señal Corrompida Por Ruido blanco Gaussiano')
disp(' ')
disp('            1->2 muestras  2->5 muestras 3->10 muestras ')
disp(' ')
sw=input('Defina Nº de muestras del filtro: ');
disp(' ')

switch lower(sw)  %swicth para escoger casos anteriores
 
    case 1          %filtro de 2 muestras o puntos
      M=2;
      B = ones(1,M)/M; %|definimos filtro de movimiento promedio
      y=filter(B,1,d); %|
      sound(y,Fs)%reproducir señal audio post-filtrado
      subplot(2,2,4)%ubicar en la posicion 4 de la ventana
      plot(t1,y,'r')%graficar señal
      xlabel('Indice n');ylabel('Amplitud');
      title(' Señal Filtrada')

    case 2           %filtro de 5 muestras o puntos
      M=5;
      B = ones(1,M)/M; %|definimos filtro de movimiento promedio
      y=filter(B,1,d); %|
      sound(y,Fs) %reproducir señal audio post-filtrado
      subplot(2,2,4)%ubicar en la posicion 4 de la ventana
      plot(t1,y,'r')%graficar señal
      xlabel('Indice n');ylabel('Amplitud');
      title(' Señal Filtrada')
    case 3          %filtro de 10 muestras o puntos
      M=10;         
      B = ones(1,M)/M;%|definimos filtro de movimiento promedio
      y=filter(B,1,d);%|
      sound(y,Fs)%reproducir señal audio post-filtrado
      subplot(2,2,4)%ubicar en la posicion 4 de la ventana
      plot(t1,y,'r')%graficar señal
      xlabel('Indice n');ylabel('Amplitud');
      title(' Señal Filtrada')
    otherwise %validacion del swicth sino es ninguno de los casos anteriores
        disp(' ')
        disp(' Error: Opción Incorrecta')
end %end del swicth     
