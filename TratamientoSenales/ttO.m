clear all;clc
X =[-5:0.1:30];
u=10;sigma=5;
z=(X-u)/sigma;
normal=(exp(-(z.^2)/2))/(sqrt(2*pi)*sigma);
plot(X,normal)