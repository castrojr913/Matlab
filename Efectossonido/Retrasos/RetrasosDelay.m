%Delay Function
%Vikas Sahdev
%Rajesh Samudrala
%Rajani Sadasivam
%
function f2 =  delay();

[x,fs,nbits]=wavread('sonido_uno.wav');%read in wav file 
xlen=length(x);%Calc. the number of samples in the file 

a=0.5; 
R=5000;%Calculate the number of samples in the delay 
y=zeros(size(x)); 

% filter the signal 

for i=1:1:R+1
   y(i) = x(i);
end

for i=R+1:1:xlen 
  y(i)= x(i)+ a*x(i-R); 
end;


wavwrite(y,fs,nbits,'delaysonido_uno.wav')
[z,b]=wavread('delaysonido_uno.wav');
sound(z,b)
