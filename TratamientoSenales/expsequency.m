%**********programa para graficar secuencias exponenciales complejas *******
clear all; clc  %borrando variables en la memoria y borrando pantalla
n=sym('n');     %convirtiendo n en una variable simbólica
disp(' ')       
disp(' 			COMPLEX EXPONENTIAL SEQUENCES x[n]=A*(alpha^n)')
disp(' ')       %dejando un espacio en pantalla 
disp(' Nota: si la secuencia es compleja: A=|A|*exp(j*phi); alpha=exp(sigma+j*omega)')
disp(' ')       
A=input(' Digite el valor de A: ');			  %valor real o complejo de A
sigma=input(' Digite el valor de sigma: '); %valor de sigma 
omega=input(' Digite el valor de omega: '); %valor de omega
inter=input(' Digite el intervalo para n [N1:N2]: ');%definiendo el intervalo de n 
freq=sigma + i*omega;%valor frecuencia compleja
if isreal(freq)== 1%| Determinando si las variables freq y A son reales o no  
   s=1;				% | para llevarlos a un switch y aplicar las fórmulas respectivas, 
else					% | de acuerdo a 4 casos. Cada caso corresponde a una combinación
   s=3;           % | de valores de la variable s y c, dependiendo de las 
end               % | condiciones dadas por los dos if. El resultado de las
if isreal(A)== 1  % | combinaciones se da en la variable sw: 1 2 3 4. De aquí,
   c=1;           % | se obtiene el caso 1,2,3 y 4 respectivamente y por lo tanto
else              % | sus correspondientes expresiones de x[n] 
   c=0;           % | 
end               % |
sw=s+c;           % |
x1=min(inter);x2=max(inter); %valor minimo de n y maximo
switch lower(sw)  % Aplicando el switch a sw
case 1	%freq real y A complejo -> x[n]=A*(alpha)^n =|A|exp(sigma*n)(cos(phi)+j*sin(phi))
   mag=sqrt((real(A))^2+(imag(A))^2);%hallando la magnitud de A -> |A|
   phi=atan((imag(A))/(real(A)));    %hallando la fase de A -> phi
   x=mag*(exp(sigma*n)).*cos(phi);   %parte real de x[n] 
   y=mag*(exp(sigma*n)).*sin(phi);   %parte imaginaria de x[n]
   z=subs(x,n,inter);%evaluando la parte real de la sucesión con el intervalo n
   u=subs(y,n,inter);%evaluando la parte imaginaria de la sucesión con el intervalo n
   xy=factor(x+i*y); %expresión de x[n] expresada en factores
   disp(' ')		   %dejando un espacio en pantalla 
   disp(' x[n]:')    %mostrar en pantalla
   pretty(xy)        %imprimiendo x[n] en pantalla
   y1=min(z)-0.5;y2=max(z)+0.5; %valor maximo + 1 de variable z y min -1
   figure(2);stem(inter,z) %graficando secuencia discreta en ventana 
   axis([x1 x2 y1 y2]);grid on %definir ejes y grid
   xlabel('Índice n');ylabel('Amplitud');title('parte real de x[n]')
   y1=min(u)-0.5;y2=max(u)+0.5; %valor maximo + 1 de variable u y min -1
   figure(3);stem(inter,u)%graficando secuencia discreta en ventana 
   axis([x1 x2 y1 y2]);grid on
   xlabel('Índice n');ylabel('Amplitud');title('parte imaginaria de x[n]')%Aplicar cuadricula,etiquetas eje x y eje y, y título de la gráfica
case 2	%freq real y A real
   disp(' ')%dejar espacio
   disp(' **Este programa sólo grafica sucesiones complejas**')%mostrar en pantalla
case 3	%freq complejo y A complejo -> x[n]=A*(alpha)^n =|A|exp(sigma*n)(cos(omega*n+phi)+j*sin(omega*n+phi))
   mag=sqrt((real(A))^2+(imag(A))^2);%hallando la magnitud de A
   phi=atan((imag(A))/(real(A)));%hallando la fase de A
   x=mag*(exp(sigma*n)).*cos((omega)*n+phi);%parte real de x[n] 
   y=mag*(exp(sigma*n)).*sin((omega)*n+phi);%parte imaginaria de x[n]
   z=subs(x,n,inter);%evaluando la parte real de la sucesión con el intervalo de valores de n
   u=subs(y,n,inter);%evaluando la parte imaginaria de la sucesión con el intervalo de valores de n
   xy=factor(x+i*y);%expresión de x[n] en factores
   disp(' ')%dejar espacio
   disp(' x[n]:')%mostrar en pantalla
   pretty(xy)%imprimiendo x[n]
   y1=min(z)-0.5;y2=max(z)+0.5;
   figure(2);stem(inter,z)%graficando secuencia discreta real 
   axis([x1 x2 y1 y2]);grid on
   xlabel('Índice n');ylabel('Amplitud');title('parte real de x[n]')
   y1=min(u)-0.5;y2=max(u)+0.5;
   figure(3);stem(inter,u)%graficando secuencia discreta imaginaria 
   axis([x1 x2 y1 y2]);grid on
   xlabel('Índice n');ylabel('Amplitud');title('parte imaginaria de x[n]')
case 4	%freq complejo y A real -> x[n]=A*(alpha)^n =A*exp(sigma*n)(cos(omega*n)+j*sin(omega*n))
   x=A*(exp(sigma*n)).*cos((omega)*n);%parte real de x[n] 
   y=A*(exp(sigma*n)).*sin((omega)*n);%parte imaginaria de x[n]
   z=subs(x,n,inter);%evaluando la parte real de la sucesión con el intervalo de valores de n
   u=subs(y,n,inter);%evaluando la parte imaginaria de la sucesión con el intervalo de valores de n
   xy=factor(x+i*y);%expresión de x[n]en factores
   disp(' ')
   disp(' x[n]:')
   pretty(xy)%imprimiendo x[n]
   y1=min(z)-0.5;y2=max(z)+0.5;
   figure(2);stem(inter,z)%graficando secuencia discreta real 
   axis([x1 x2 y1 y2]);grid on
   xlabel('Índice n');ylabel('Amplitud');title('parte real de x[n]')
   y1=min(u)-0.5;y2=max(u)+0.5;
   figure(3);stem(inter,u)%graficando secuencia discreta imaginaria 
   axis([x1 x2 y1 y2]);grid on
   xlabel('Índice n');ylabel('Amplitud');title('parte imaginaria de x[n]')
end

   

	
   
   

   
   

   
   
   
   
   


   
