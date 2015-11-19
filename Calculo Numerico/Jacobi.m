%programa jacobi
%entradas: n, a,b xo, n, tol
%salida x aprox sist ax=b
n=input('numero de ecuaciones');
a=input('matriz de coeficientes');
b=input('terminos independientes');
N=input('numero max de interacciones');
tol=input('tolerancia');
xo=input('aprox inicial xo');
k=1;
while k<=N
    for i=1:n
        s=0;
        for j=1:n
            if i~=j
                s=s+a(i,j)*xo(j);
            end
        end
            x(i)=(b(i)-s)/a(i,i);
    end
    if norm(x-xo)<tol
        disp(x)
        break
    else
        k=k+1;
        xo=x;
    end
end
if k>N
    disp('agotadas interacciones')
end
