% METODO DE STEFFENSEN (Ref: Bunsen, Richard. Numerical Analysis)
% By: Jesús A. Castro R. Date: 07-12-08
% El método de Steffensen presenta una convergencia rápida y no requiere,
% como en el caso del método de la secante, la evaluación de derivada.  
% Presenta además, la ventaja adicional de que el proceso de iteración sólo
% necesita un punto inicial. Este método calcula el siguiente punto de 
% iteración a partir de la expresión: 
%       p=p2-(p2-p1)^2/(p2-2*p1+p0) where p1=g(p0) & p2=g(p1)   
% Nota: p.e, si la función es respecto a x, no escribir f(x) sino x=g(x)
clear
disp('<< Método De Steffensen >>')
g=sym(input('Función: ','s'));
p0=input('Aprox. inicial: ');
iter=input('Iteraciones: ');
tol=input('Tolerancia: '); 
disp('  n         p0              p1             p2               p           |p-p0|')
for k=1:iter
 p1=subs(g,p0);p2=subs(g,p1);
 p=p2-(p2-p1)^2/(p2-2*p1+p0); %ecuación steffensen
 e=abs(p-p0); %error abs
 fprintf('%3i   %13.9f   %13.9f   %13.9f   %13.9f   %13.9f\n',k,p0,p1,p2,p,e)
 if e<=tol
    fprintf('Solución con %i iteraciones: %13.9f\n',k,p)
    break 
 else p0=p;
 end
end
if e>tol
   error('Insuficiente número de iteraciones')
end
