%M�TODO DE PUNTO FIJO O APROXIMACIONES SUCESIVAS
%By: Jesus Alberto Castro Rojas. Date: 25-10-08 
%
%No es aplicado a toda f(x) por limitaci�n en convergencia. 
%Solo a aqu�llas tal que 0<f'(x)<1
clear
syms x
disp('<< Metodo De Punto Fijo (Aproximaciones Sucesivas) >>')
y=input('Funci�n x=g(x): ');
x0=input('Aprox. inicial: ');
iter=input('Iteraciones: ');
tol=input('Tolerancia: ');
disp(' Iter             x0              xn               |xn-x0|')  
for k=1:iter
    xn=subs(y,x0); %punto fijo
    e=abs(xn-x0);
    fprintf('  %3i     %13.9f      %13.9f      %13.9f\n',k,x0,xn,e)  
    if e>tol,x0=xn;
    else
       fprintf('Soluci�n con %i iteraciones: %13.9f\n',k,xn)
       break
    end
end
if e>tol
   error('Insuficiente n�mero de iteraciones')
end
