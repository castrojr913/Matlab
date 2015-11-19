%Multiple Echo

function f1 = multi();

%Multi Echo Reveberator 
[d,r,nbits]=wavread('C:\Filtro Multi Eco2\clackson.wav');

% y1=wavread('Foca.wav');
num=[0,zeros(1,2900),1];
den=[1,zeros(1,2900),-0.8];
tf1=tf(num,den,0.1)
figure(5)
pzmap(tf1)
d1=filter(num,den,d);
wavwrite(d1,r,nbits,'clackson2.wav');
 
%Typical impulse response 
I =[1,zeros(1,60)];
numi=[0,zeros(1,10),1];
deni=[1,zeros(1,10),-0.8];
d2= filter(numi,deni,I);
figure(1)
stem(d2);grid;
xlabel('Ejemplo de muestra');
ylabel('Amplitud');
title(['Typical impulse response ']);

%Magnitud de Respuesta
figure(2)
[h1,w] = freqz(numi,deni,512);
plot(w/pi,20*log10(abs(h1)));grid;
% xlabel('Frecuencia Normalizada');
% ylabel('Magnitud');
% title(['Magnitud de respuesta']);
xlabel('Frecuencia Normalizada');
ylabel('Magnitud');
title(['Magnitud de respuesta']);
[x,y]=wavread('clackson2.wav');
sound(x,y)

%*** Grafica de la se�al ***
figure(3)
subplot(3,1,1),plot(x),title('foca.wav'),grid on, zoom on
subplot(3,1,2),plot(d),title('Eco.wav'),grid on, zoom on 


