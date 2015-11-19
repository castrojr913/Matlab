clear all;clc
R =[0:51] ;
normal=(exp(-(R^2)/2))/sqrt(2*pi);
plot(R,normal)
