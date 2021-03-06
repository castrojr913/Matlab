%Calculo de ANOVA para DCA Balanceado y no balanceado
%
%NOTA: cada fila debe tener igual tama�o, lo mismo cada columna.
%si es desbalanceado, colocar NaN a aqu�llas unidades que no est�n. 
%El NaN le dice al programa que esa unidad est� ausente en la tabla.
%gr�ficas: escribir s�->'s' no->cualquier letra excepto s
clear 
close all 
cTt=0;cnan=0;
format('short');format('compact')%formato para command window
s0=input('Matriz repeticiones vs tratamientos: ');
alpha=input('Nivel de confianza: ');
graph=input('Gr�fica de la distribuci�n F (s/n): ','s');
if graph=='s'
    f=input('Intervalo para F: ');
end
[s1,s2]=size(s0);%# filas y columnas de la tabla
Tt=zeros(1,s2);
Tt2=Tt;Tt3=Tt2;mTt=Tt3;Tt4=mTt;Tt5=Tt4;
for j=1:s2
    if cTt~=0 %�realiz� conteo de unidades por tto? 
       mTt(j-1)=Tt(j-1)/cTt;%medias de cada tratamiento (hasta j-1 tto)
       Tt3(j-1)=(Tt(j-1))^2/cTt;%total al cuadrado/# de unidades por tto
                                %hasta el j-1 tto
       Tt4(j-1)=(Tt2(j-1)-cTt*mTt(j-1)^2)/(cTt-1);%varianza (hasta j-1 tto)
       Tt5(j-1)=sqrt(Tt4(j-1));%desv.�standar (hasta j-1 tto)
    end                          
    cTt=0;%reseteo del contador
    for i=1:s1
        if isnan(s0(i,j))==0 %�existen unidades? 
            Tt(j)=Tt(j)+s0(i,j); %suma total por tratamiento
            Tt2(j)=Tt2(j)+(s0(i,j))^2;%sumas unidades al cuadrado por tto
            cTt=cTt+1;%unidades contadas
        else %casos NaN
            cnan=cnan+1;
        end
    end
end %N: total unidades del dise�o
N=s1*s2-cnan;Tt3(j)=(Tt(j))^2/cTt;%suma total al cuadrado para tto j 
mTt(j)=Tt(j)/cTt;fc=(sum(Tt))^2/N;%factor de correcci�n
Tt4(j)=(Tt2(j)-cTt*mTt(j)^2)/(cTt-1);Tt5(j)=sqrt(Tt4(j));
sc=[sum(Tt2)-fc,sum(Tt3)-fc,sum(Tt2)-sum(Tt3)];%suma cuadrado total,tto y error exp
gl=[j-1 N-j];cm=[sc(2)/gl(1),sc(3)/gl(2)];%grados libertad y cuadrados medios 
fc=cm(1)/cm(2);total=[sc(2)+sc(3),gl(1)+gl(2),cm(1)+cm(2)];%totales anova
ft=finv(alpha,gl(1),gl(2));%f tabulada <=> fc: F calculada
%---- TABLA INICIAL-----
disp(' ');disp(' filas:repeticiones  columnas:tratamientos');
disp(' ');disp(s0)
disp(' ');disp(' Medias/tto:')
disp(mTt);disp(' Varianzas/tto:')
disp(Tt4);disp(' Desviaci�n Est�ndar/tto:')
disp(Tt5);disp(' ')
%-------ANOVA--------
disp('Fuente de variaci�n   Suma de cuadrados  Grados de libertad  Cuadrados medios       F       Valor cr�tico F') 
fprintf('Intergrupo (tto)          %5.4f              %i                 %5.4f         %5.4f      %5.6f\n',sc(2),gl(1),cm(1),fc,ft)
fprintf('Intragrupo (error)        %5.4f              %i                 %5.4f\n',sc(3),gl(2),cm(2))
fprintf('Total                     %5.4f              %i                %5.4f\n',total(1),total(2),total(3))
%-------GRAFICA DISTRIBUCION F Y F TABULADA-----      
if graph=='s' %fpdf->f. densidad de prob. F
    ff=fpdf(f,gl(1),gl(2));
    gr1=plot(f,ff);%graficar
    set(gr1,'linewidth',2);grid on %aumentar grosor de la l�nea 
    title('Distribuci�n F con F tabulada')
    xlabel('F');ylabel('f(F)');hold on %labels y sostener gr�fica
    plot(ones(1,length(ff))*ft,ff,'--r')%indicar Ft y �rea en f(F) al alpha 
end
%----Hipotesis----
disp(' ')
if fc>ft
   fprintf('Conclusi�n: rechazar hip�tesis nula pues F=%5.4f>%5.4f\n',fc,ft) 
else
   fprintf('Conclusi�n: no rechazar hip�tesis nula pues F=%5.4f<=%5.4f\n',fc,ft) 
end
%---- opcional: calcular la media y varianza de la distribuci�n F ----
%[m,v]=fstat(gl(1),gl(2))
%Por mejorar: aplicar pruebas

%Realizado por: Jesus A. Castro R.