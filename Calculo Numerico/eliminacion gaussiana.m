syms a n b
n=input('numero de ecuaciones :');
a=input('matriz de coeficientes a:');
b=input('terminos independientes:');
for i=1:n-1
    p=i;
    while a(p,i)==0& p<=n
        p=p+1;
    end
        if p==n+1
            disp('no existe solucion unica');
            break
        else
            if p~=i
                r=a(i,:);
                a(i,:)=a(p,:);
                a(p,:)=r;
                d=b(i);
                b(i)=b(p);
                b(p)=d;
            end
        end
        for j=i+1:n
            m=a(j,i)/a(i,i);
            a(j,:)=a(j,:)-m*a(i,:);
            b(j)=b(j)-m*b(i);
        end
end
if a(n,n)==0
    disp('no existe solucion unica');
    break
else
    x(n)=b(n)/a(n,n);
    for i=n-1:-1:1
        
        s=0;
        for j=i+1:n
            s=s+(a(i,j)*x(j));
        end
        x(i)=(b(i)-s)/a(i,i);
    end
    disp (x)
end