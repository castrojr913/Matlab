%program biseccion
%entradas:f(x),a,b,tol,N
%salida:p talque f(p)=0
%autor
syms x
f=input('tecle la funcion f(x)=');
a=input('valor de a:');
b=input('valor de b:');
tol=input('tolerancia:');
N=input('numero max iteraciones:');
k=1;
while k<=N
    p=(a+b)/2;
    x=a;
    fa=eval(f);
    x=p;
    fp=eval(f);
    if fp==0|abs(b-a)/2<tol
        disp(p)
        break
    end
    if fa*fp<0
        b=p;
    else
        a=p;
    end
    k=k+1;
end
if k>N
    disp('agotado numero de iteraciones');
end
