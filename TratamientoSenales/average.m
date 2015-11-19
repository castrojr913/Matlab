clear all                            %borrar variables de la memoria
clf %cerrar figuras
clc                                  %borrar pantalla       	
%***  CAPTURA DE SE�AL DE AUDIO ***
disp(' ')
disp('                    FILTRO DE MOVIMIENTO PROMEDIO PARA AUDIO DE 16KHz')
disp(' ')
[audio,Fs,cbits]= wavread('muestra.wav'); %capturando la se�al de audio muestra.wav
disp(' ')
fprintf('Frecuencia Archivo De Audio Original: %i\n',Fs)%imprimiendo frecuencia de se�al
wavplay(audio,Fs)%reproduciendo se�al
%*** Grafica de la se�al ***
t=1:size(audio); %definiendo intervalo
subplot(2,2,1)   %ubicar en la posicion 1 de la ventana
plot(t,audio,'r')
xlabel('Indice n');ylabel('Amplitud');
title(' Se�al Original')
% *** REMUESTREANDO LA SE�AL DE AUDIO A 16KHZ ***
wavwrite(audio,16000,'muestra_1') %escribe archivo de audio.wav con base en la
                                  %variable audio a una Fs=16KHz                              
[audio_1,Fs,cbits]= wavread('muestra_1.wav'); %captura la se�al remuestreada
fprintf('Frecuencia Archivo De Audio Remuestreado: %i\n',Fs)%imprimiendo frecuencia de se�al
wavplay(audio_1,Fs)%reproduciendo se�al
%*** Grafica de la se�al ***
t1=1:size(audio_1);
subplot(2,2,2)  %ubicar en la posicion 2 de la ventana
plot(t1,audio_1,'r')
xlabel('Indice n');ylabel('Amplitud');
title(' Se�al Remuestrada')
%*** DISTORSI�N DE LA SE�AL CON RUIDO BLANCO ***
d = awgn(audio_1,20,'measured','linear');%Corrompiendo la se�al de audio con ruido blanco gaussiano a una SNR = 20, 
                                         %es decir la amplitud de la se�al de ruido equivale es 1/20 de la amplitud de
                                         %la se�al de auido por cada
                                         %muestra (5%). La SNR es lineal
sound(d,Fs)%reproducir sonido de la se�al
subplot(2,2,3)  %ubicar en la posicion 3 de la ventana
plot(t1,d,'r') %graficar
xlabel('Indice n');ylabel('Amplitud');
title(' Se�al Corrompida Por Ruido blanco Gaussiano')
disp(' ')
disp('            1->2 muestras  2->5 muestras 3->10 muestras ')
disp(' ')
sw=input('Defina N� de muestras del filtro: ');
disp(' ')

switch lower(sw)  %swicth para escoger casos anteriores
 
    case 1          %filtro de 2 muestras o puntos
      M=2;
      B = ones(1,M)/M; %|definimos filtro de movimiento promedio
      y=filter(B,1,d); %|
      sound(y,Fs)%reproducir se�al audio post-filtrado
      subplot(2,2,4)%ubicar en la posicion 4 de la ventana
      plot(t1,y,'r')%graficar se�al
      xlabel('Indice n');ylabel('Amplitud');
      title(' Se�al Filtrada')

    case 2           %filtro de 5 muestras o puntos
      M=5;
      B = ones(1,M)/M; %|definimos filtro de movimiento promedio
      y=filter(B,1,d); %|
      sound(y,Fs) %reproducir se�al audio post-filtrado
      subplot(2,2,4)%ubicar en la posicion 4 de la ventana
      plot(t1,y,'r')%graficar se�al
      xlabel('Indice n');ylabel('Amplitud');
      title(' Se�al Filtrada')
    case 3          %filtro de 10 muestras o puntos
      M=10;         
      B = ones(1,M)/M;%|definimos filtro de movimiento promedio
      y=filter(B,1,d);%|
      sound(y,Fs)%reproducir se�al audio post-filtrado
      subplot(2,2,4)%ubicar en la posicion 4 de la ventana
      plot(t1,y,'r')%graficar se�al
      xlabel('Indice n');ylabel('Amplitud');
      title(' Se�al Filtrada')
    otherwise %validacion del swicth sino es ninguno de los casos anteriores
        disp(' ')
        disp(' Error: Opci�n Incorrecta')
end %end del swicth     
