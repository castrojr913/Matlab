function impar(varargin,inter) %ej: [-pi 0 pi] -> -pi<t<0, 0<t<pi
%IMPAR determina si una funcion es par o impar
d=0;e=1;cnt=0;d_1=0;
c0=max(size(varargin));
varargin=sym(varargin);
if nargin==1
   error('Insuficientes argumentos de entrada') 
end   
for c=1:c0
    if varargin(c)==0
       d_1=d_1+1; 
    end
    if d_1==c0
       disp('La funci�n no es par ni es impar') 
       cnt=1;
    end   
end
if cnt==0
    if inter==0 %si no hay l�mites (es una funcion sencilla solamente)
        if c0>1 
            error('Debe ser una sola funci�n')
        else
            c_1=int(varargin(1),-1,1);
            c_2=2*int(varargin(1),0,1);
            cnt=1;
            if c_1==c_2 
                disp('La funci�n es par')
            elseif c_1==0 %mirar si es impar <-> int(g(x),-L,L)=0
                disp('La funci�n es impar')
            else %funciones que tienen parte par e impar
                  disp('La funci�n no es par ni es impar')
            end
        end
    end
end
if cnt==0 %algoritmo funci�n par (con limites)
    for c=1:c0 %aplicando: int(g(x),-L,L)
        c1(c)=int(varargin(c),inter(c),inter(c+1));
    end
    c2=sum(c1)
    inter1(1)=0;
    %calcular limites de la exp: 2*int(g(x),0,L)
    while c==c0 
        d=d+1;
        if inter(d)>0
            e=e+1; 
            inter1(e)=inter(d);
            if d==max(size(inter))
                c=0; %salir del while
            end    
        end
    end
    c3=max(size(inter1))-1; %n�mero de fun usados al int (las �ltimas) 
    c4=c0-c3+1;d=1;%(total_fun - c3)+1
    for c=c4:c0
        c5(d)=int(varargin(c),inter1(d),inter1(d+1));
        d=d+1;
    end
    c6=2*sum(c5)
    if c2==c6 
       disp('La funci�n es par')
    elseif c2==0 %mirar si es impar <-> int(g(x),-L,L)=0
       disp('La funci�n es impar')
    else %funciones que tienen parte par e impar
       disp('La funci�n no es par ni es impar')
    end   
end

%Hecho por: Jesus A. Castro R. julio 2008    
%corregir si se cumplen teoremas 1 y 2 en la misma funcion

    

    

   
