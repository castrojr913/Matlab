%METODO DE HALLEY
%By: Jes�s A. Castro R. Date: 07-12-08
%Es un algoritmo n�merico que acelera la convergencia del m�todo de Newton
%Raphson aplicado a ecuaciones no lineales. Su orden de convergencia
%es 3 (raices simples) y se puede demostrar que �sta resulta al aplicar
%Newton-Raphson a una funci�n: f(x)/sqrt(f'(x)). Su expresi�n es:
%xk+1=xk-(f(xk)/f'(xk))*(1-f(xk)*f''(xk)/(2*f'(xk)^2))^-1
function xk1=halley(f,xk)
if nargin>2
    error('excedido numero de argumentos de entrada');
elseif nargin<2
    error('pocos argumentos de entrada');
end
%f=sym(input('Funci�n: ','s'));
%xk=input('Aprox. inicial: ');
%iter=input('Iteraciones: ');
%tol=input('Tolerancia: ');
iter=50;tol=10^-4;
%disp('  k         xk            f(xk)           df(xk)          d2f(xk)          xk+1         |xk+1-xk|')
f1=diff(f);f2=diff(f1);
%e=0;
for k=1:iter
    f0=subs(f,xk);fx=subs(f1,xk);fxx=subs(f2,xk);
    xk1=xk-(f0/fx)*(1-f0*fxx/(2*fx^2))^-1;
    e=abs(xk1-xk);
    %fprintf('%3i   %13.9f   %13.9f   %13.9f   %13.9f   %13.9f   %13.9f\n',k,xk,f0,fx,fxx,xk1,e)
    if isinf(xk1)==1 || isnan(xk1)==1
       error('Falla de convergencia: existen indeterminaciones al usar metodo.');
       e=0;
       break;
    elseif e<=tol
         %fprintf('Soluci�n con %i iteraciones: %13.9f\n',k,xk1) 
        break;
    elseif e>tol
        xk=xk1;
    end
end
if e>tol
   error('Insuficiente n�mero de iteraciones');
end
