% METODO DE STEFFENSEN (Ref: Bunsen, Richard. Numerical Analysis)
% By: Jes�s A. Castro R. Date: 07-12-08
% El m�todo de Steffensen presenta una convergencia r�pida y no requiere,
% como en el caso del m�todo de la secante, la evaluaci�n de derivada.  
% Presenta adem�s, la ventaja adicional de que el proceso de iteraci�n s�lo
% necesita un punto inicial. Este m�todo calcula el siguiente punto de 
% iteraci�n a partir de la expresi�n: 
%       p=p2-(p2-p1)^2/(p2-2*p1+p0) where p1=g(p0) & p2=g(p1)   
% Nota: p.e, si la funci�n es respecto a x, no escribir f(x) sino x=g(x)
clear
disp('<< M�todo De Steffensen >>')
g=sym(input('Funci�n: ','s'));
p0=input('Aprox. inicial: ');
iter=input('Iteraciones: ');
tol=input('Tolerancia: '); 
disp('  n         p0              p1             p2               p           |p-p0|')
for k=1:iter
 p1=subs(g,p0);p2=subs(g,p1);
 p=p2-(p2-p1)^2/(p2-2*p1+p0); %ecuaci�n steffensen
 e=abs(p-p0); %error abs
 fprintf('%3i   %13.9f   %13.9f   %13.9f   %13.9f   %13.9f\n',k,p0,p1,p2,p,e)
 if e<=tol
    fprintf('Soluci�n con %i iteraciones: %13.9f\n',k,p)
    break 
 else p0=p;
 end
end
if e>tol
   error('Insuficiente n�mero de iteraciones')
end
