%Allpass reveberator 
%Vikas Sahdev
%Rajesh Samudrala
%Rajani Sadasivam
%
function f1 = alpas();


[d,r]=wavread('clackson.wav');
figure(4);
stem(d);grid;
num=[0.8,zeros(1,2900),1];

den=[1,zeros(1,2900),0.8];

d1=filter(num,den,d);
figure(3);
stem(d1);grid;
wavwrite(d1,r,'alpas.wav');

%Typical impulse response 
I =[1,zeros(1,60)];
numi=[0.8,zeros(1,10),1];
deni=[1,zeros(1,10),0.8];
d2= filter(numi,deni,I);
figure(1);
stem(d2);grid;
xlabel('Sample index');
ylabel('Amplitude');
title(['Typical impulse response ']);



%Magnitude response with
figure(2);
[h1,w] = freqz(numi,deni,512);
plot(w/pi,20*log10(abs(h1)));grid;
xlabel('Normalized Frequency');
ylabel('Magnitude');
title(['Magnitude response']);

