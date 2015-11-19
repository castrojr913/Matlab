%gráfica del escalón
clear all; clc
n=sym('n');
disp(' ')
disp(' 			   UNIT STEP SEQUENCE x[n-k]=u[n-k]')
disp(' ')
A=input(' Argumento de la sucesión u[n-k]: '); %definiendo argumento de la función ej: n-1,n,etc.
inter=input(' Intervalo para n [N1:N2]: ');%definiendo el intervalo de n
long=length(inter);%calculando longitud del intervalo
v=sym2poly(A);%convirtiendo el n-k en un vector
v1=-(v(2))/(v(1));%hallando el valor de n donde la función = 1 desde ahí en adelante
v2=zeros(1,long);%sacando un vector de ceros de longitud = a la longitud del intervalo de n
hi=100;%----------comparando las posiciones de n dadas con la calculada en la cual comenzará
for k=1:long%     la sucesión de 1 desde ahí en adelante 
   if inter(k)==v1 | hi==101
      v2(k)=v2(k)+1;
      hi=101;
   end
end%-----------------------------------
figure(2);stem(inter,v2)%imprimiendo la figura en la ventana
grid on;xlabel('Índice n');ylabel('Amplitud');title('Unit Step Sequence')

   
