function polinomio=taylor2(sw,fun,n,xo,chart1)
%TAYLOR2 calcula y grafica polinomios de Taylor de una y dos variables. 
%
%TAYLOR2(sw,fun,n,xo)->calcula el polinomio de Taylor de grado n de la
%funci�n fun alrededor de xo. Si sw=1, calcula el polinomio de Taylor
%P(x) a la funci�n f(x) alrededor de x0. Si sw=2,  calcula el polinomio
%de Taylor P(x,y) a la funci�n f(x,y) alrededor de (x0,y0).
%
%TAYLOR2(sw,fun,n,xo,graph,chart1)->Igual que lo anterior aunque grafica 
%el polinomio de Taylor junto con la funci�n en un intervalo determinado.
%si graph=1, se habilita la gr�fica. chart1 debe ser un vector fila que
%contiene m�nimo y maximo valor de x (� x y y) para el intervalo. Si 
%sw=1, a�ada adem�s el N� de pasos as�: chart1=>[min max pasos] 
     syms x y
     polino=0;
     if nargin<3
        error('Insuficiente argumentos de entrada')
     elseif nargin<4 %serie de Mcclaurin
        graph=0;
        if sw==1
            xo=0;%x0=0
        else
            xo=[0 0];%[x0,y0]=[0,0]
        end
     elseif nargin<5 %se especifica un valor de s�lo x0 o x0 y y0    
        graph=0; %no graficar
     else
         graph=1;
     end
     switch lower(sw)
       case 1 %"POLINOMIOS DE TAYLOR DE 1 VARIABLE"
           polino1=subs(fun,xo);%derivada 0
           if isnan(polino1)==1 %indeterminaci�n 0/0
               polino1=hopital(fun,xo);%Regla de L'Hopital
           elseif isinf(polino1)==1
               error('Imposible de obtener polinomio de Taylor') 
           end    
           for i=1:n 
               evalua=subs(diff(fun,i),xo);%derivada 1 hasta n
               if isnan(evalua)==1 
                   evalua=hopital(diff(fun,i),xo);
               elseif isinf(evalua)==1
                 error('Imposible de obtener polinomio de Taylor')
               end    
               poli(i)=(evalua/factorial(i))*(x-xo)^i;
           end
           for i=1:n
               polino=polino+poli(i);
           end
           polinomio=polino1+polino;
         %******  Gr�fica entre la funci�n y el polinomio de Taylor ******
           if graph==1 
               chart=(chart1(1):chart1(3):chart1(2));
               value=subs(polinomio,chart);%por ser sym pasar a double
               valor=subs(fun,chart);
               plot(chart,value,chart,valor)
               grid on;xlabel('Eje x');ylabel('Eje f(x)')
               title('polinomio de Taylor P(x) y funci�n f(x)')
               legend('P(x)','f(x)',-1)
           end
       
       case 2 %"POLINOMIO DE TAYLOR DE 2 VARIABLES"
          
           for i=0:n%aplicando el teorema de taylor para dos variables
               derivada=diff(fun,y,i);
               evalua=subs(diff(derivada,x,n-i),{x,y},{xo(1),xo(2)});
               if isnan(double(evalua))==1 || isinf(double(evalua))==1
                   error('Indeterminaciones al desarrollar el polinomio')
               end
               combinatoria=(factorial(n))/(factorial(i)*factorial(n-i));
               poli(i+1)=combinatoria*(evalua/factorial(n))*((x-xo(1))^(n-i))*((y-xo(2))^i);
           end
           for i=1:n+1
               polino=polino+poli(i);

           end
           polinomio=subs(fun,{x,y},{xo(1),xo(2)})+polino;
        %******  Gr�fica entre la funci�n y el polinomio de Taylor ******
           if graph==1
               chart=(chart1(1):0.01:chart1(2));%para P(x,y) y f(x,y) kte
               if isreal(fun)==0%�hay variables simbolicas?
                   subplot(1,2,1)%f(x,y)
                   ezmesh(fun,[chart1(1),chart1(2)],40)
                   xlabel('Eje x');ylabel('Eje y');zlabel('Eje f(x,y)')
                   title('Funci�n f(x,y)')
               else %sino f(x,y)=kte
                   ev_1=double(fun)*(ones(1,max(size(chart))));
                   subplot(1,2,1);plot3(chart,chart,ev_1)
                   xlabel('Eje x');ylabel('Eje y');zlabel('Eje f(x,y)')
                   grid on;title('Funci�n f(x,y)')
               end
               if isreal(polinomio)==0%�hay variables simbolicas?
                   subplot(1,2,2)%p(x,y)
                   ezmesh(polinomio,[chart1(1),chart1(2)],40)
                   xlabel('Eje x');ylabel('Eje y');zlabel('Eje P(x,y)')
                   title('Polinomio de Taylor P(x,y)')
               else %sino P(x,y)=kte
                   ev_1=double(polinomio)*(ones(1,max(size(chart))));
                   subplot(1,2,2);plot3(chart,chart,ev_1)
                   xlabel('Eje x');ylabel('Eje y');zlabel('Eje f(x,y)')
                   grid on;title('Polinomio de Taylor P(x,y)')
               end
           end
   
       otherwise
           error('opci�n desconocida')
     end        

% Realizado por: Ing. Jes�s Castro   
% Fecha: junio 2006. Mejorado: julio 2008
% por mejorar: adaptar L`Hopital para P(x,y) 
