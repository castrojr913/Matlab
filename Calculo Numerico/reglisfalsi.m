%METODO REGULA FALSI (REGLA FALSA)
%By: Jes�s A. Castro R. Date: 26-10-08  
%basado en: Numerical_Methods_using_MATLAB__3rd_Ed. John Mattews.
% La ra�z se obtiene al hallar la intersecci�n de la recta que pasa por 
% los puntos (a,f(ak)) y (b,f(bk)) con el eje de abscisas (igual al
% m�todo de la secante). Esta se halla con la expresion:
% ck=(ak*f(bk)-bk*f(ak))/(f(bk)-f(ak))
function c=reglisfalsi(y,ab,tol)
if nargin>3
    error('excedido numero de argumentos de entrada');
elseif nargin<1
    error('pocos argumentos de entrada');
elseif nargin==2 
    tol=10^-4;
end
%y=sym(input('Funci�n: ','s'));
%ab=input('Intervalo [a,b]: ');
%iter=input('Iteraciones: ');
%tol=input('Tolerancia: ');
iter=50;%tol=10^-4;
a=ab(1);b=ab(2);
fa=subs(y,a);fb=subs(y,b);
if fa*fb>0 %teorema de bolzano (usado tambien en biseccion)
   error('Fallo de convergencia: f(a)*f(b)>0')
else
    %disp(' Iter        a              b                c            f(c)         |b-a|/2')
    for k=1:iter %regula falsi
        c=b-fb*(a-b)/(fa-fb);     
        fc=subs(y,c);
        e=abs(b-a)/2; 
        %fprintf('%3i   %13.9f   %13.9f   %13.9f   %13.9f   %13.9f\n',k,a,b,c,fc,e)
        if e>tol %&& fc>tol 
           %if fa*fc>0,a=c;fa=fc;
           %else b=c;fb=fc;
           %end
           if fb*fc<0
               a=b;fa=fb;
           end
           b=c;fb=fc;
        else
         %fprintf('Soluci�n con %i iteraciones: %13.9f\n',k,c)
         break
        end
    end
end
if e>tol && fc>tol
   error('Insuficiente n�mero de iteraciones')
end
