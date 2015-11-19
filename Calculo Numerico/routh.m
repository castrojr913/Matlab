%CRITERIO ESTABILIDAD ROUTH-HURWIRTZ. función de transferencia G(s)
%
%NOTA_1: ej: si n=5 y rou(3,:)=[0 0]->tomo rou(2,:),es decir  
%la fila s^4 que sea por ej:[2 3 1].ojo,lo hice como si fuese
%2*s^4+3*s^2+1->los coeficientes se muliplican por su exponente 
%respectivo pues de la derivada me interesan los coeficientes: [8 6 0].
%NOTA_2:para caso especial 1,los ceros se reemplazan por 0.01
function rou = routh(hs)
[N,D]=numden(hs);%obtener num y den de G(s)
Dr=D+N;%denominador retroalimentado
disp('Polinomio Característico')
disp(expand(Dr))
D_1=sym2poly(Dr);%vector fila denominador
SD=max(size(D_1));f_1=0;
%%%% VERIFICACION INICIAL DE ESTABILIDAD (OPCIONAL)%%%%
d=0;e=0;
for c=1:SD 
   if sign(D_1(c))==-1 %existen signos -
       d=d+1;
   elseif any(D_1(c))==0 % ¿coeficiente es cero? 
       e=e+1;
   end
end
if d==1 || d>1 
   disp('Cambios de signo en los coeficientes')
   disp('Routh-Hurwitz: inestable');
   f_1=1;
elseif e==1 || e>1
   disp('Coeficientes iguales a cero')
   disp('Routh-Hurwitz: inestable')
   f_1=1; 
end   
if f_1==0
    %%%% MATRIZ DE CEROS BASE PARA CALCULAR MATRIZ DE ROUTH %%%%
    d=1;
    for c=1:2:SD %OBTENCIÓN ELEMENTOS DE LA FILA s^n
        if c<SD || c==SD %¿c es menor o igual que la última columna?
            sn(d)=D_1(c);
            d=d+1;
        end
    end
    d=1;
    for c=2:2:SD %OBTENCIÓN ELEMENTOS DE LA FILA s^(n-1)
        if c<SD || c==SD %¿c es menor o igual que la última columna?
            sn1(d)=D_1(c);
            d=d+1;
        end
    end
      %---- CALCULO Nº DE COLUMNAS PARA MATRIZ DE CEROS ----
    SSN=max(size(sn));
    SSN1=max(size(sn1));
    col=SSN;
      %-------- OBTENCION DE LA MATRIZ DE CEROS-----
    rou=zeros(SD,col);
    %%%% CALCULO DE MATRIZ DE ROUTH %%%%
    for c=1:SSN
        rou(1,c)=sn(c); %pasar elementos de sn a la fila1 de la matriz
    end
    for c=1:SSN1
        rou(2,c)=sn1(c);%pasar elementos de sn1 a la fila2 de la matriz
    end
    SD1=SD-2;%exponente n-1->s^(n-1)
    SD2=SD1;dato=0;
    col=col-1;f=0;%esto pues arranca en s^(n-2) (fila3)
    for c=1:SD-2
        for d=1:col 
            rou(c+2,d)=(rou(c+1,1).*rou(c,d+1)-rou(c,1).*rou(c+1,d+1))./rou(c+1,1);
            dato=dato+1; %registra Nº de operaciones por fila
        end 
        if dato<SSN1 %¿Nªelementos actuales<Nºelementos de fila2?
           f=f+1; 
           if f==2
              col=col-1;%Nºdatos fila siguiente<Nºdatos fila actual  
              f=0;
           else
              col=dato;%Nºdatos fila actual = Nºdatos fila siguiente 
           end
        else %son iguales->¡solo pasa una vez!
            col=col-1;
        end
        if dato==1 %solo se daría caso especial 1 
            if rou(c+2,1)==0 %¿es cero?->caso especial 1 
               rou(c+2,1)=0.01;%reemplaza a cero por 0.01 
            end
        elseif any(rou(c+2,1:dato))==1%dato>1->¿datos distintos de cero?
            if rou(c+2,1)==0 %¿es cero?->caso especial 1 
               rou(c+2,1)=0.01;%reemplaza a cero por 0.01 
            end
        else    
            for e=1:dato
                rou(c+2,e)=rou(c+1,e)*SD2;%ir arriba a NOTA_1
                SD2=SD2-2;%dismiyendo en paso de 2
                if SD2<0
                    SD2=0;%exponentes n<0 no existen->n=0
                end   
            end
        end %if dato==1
        SD1=SD1-1;%resta 1 a n (usado en caso especial 2)
        SD2=SD1;dato=0;
    end 
    %%%% VERIFICACION FINAL: CAMBIO DE SIGNO %%%%
    d=0;
    for c=1:SD
        if sign(rou(c,1))==-1 %existen signos -
            d=d+1;
        end
    end
    if d==1 || d>1 
        disp('Routh-Hurwitz: inestable');
    else
        disp('Routh-Hurwitz: estable');
    end    
end
    
