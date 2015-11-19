%Equalizer

[x,fs]=wavread('foca.wav');
Wn = .20;
N = 62;
%These are the gains on each of the 3 bands
gLP = 0.4;
gBP = 1.5;
gHP = 1.5;

LP = fir1(N,Wn);
Wn1 = [.20, .50];
BP = fir1(N,Wn1);
Wn2 = .50;
HP = fir1(N,Wn2,'high');
figure(1)
freqz(LP);
figure(2);
freqz(BP);
figure(3);
freqz(HP);
y1 = conv(LP,x);
y2 = conv(BP,x);
y3 = conv(HP,x);
yA= gHP * y3;
wavwrite(yA,fs,'Equalizer3');
yB= gLP * y1;
wavwrite(yB,fs,'Equalizer1');
yC= gBP * y2;
wavwrite(yC,fs,'Equalizer2');
yD = yA + yB + yC;
wavwrite(yD,fs,'Equalizer4');

