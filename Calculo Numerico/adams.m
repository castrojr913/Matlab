t='^';
while t=='^'
   clear 
   clc
   disp(' ')
   disp(' ')
   disp('				  Método De Adams-Bashforth/Adams-Moulton De Cuarto Orden') 
   disp(' ')
   disp(' ')
   disp(' ')
   disp(' Nota: tenga en cuenta lo siguiente:')
   disp(' ')
   disp(' 1. Escriba la función de la forma f(t,y).')   
   disp(' 2. Agregue los valores extremos del intervalo [a,b] donde a<=t<=b y la condición inicial.') 
   disp(' 3. Agregue el número de subintervalos (puede ser par o impar).') 
   disp(' ')
   disp(' ')
   t=sym('t');
   y=sym('y');
   fun=input(' Digite la función f(t,y) de la ecuación diferencial: ');
   hi=100;
   while hi==100
      a=input(' Digite el extremo a del intervalo [a,b]: ');
      if isreal(a)==1
         hi=101;
      end
   end
   hi=100;
   while hi==100
      b=input(' Digite el extremo b del intervalo [a,b]: ');
      if isreal(b)==1
         hi=101;
      end
   end
   hi=100;
   while hi==100%validando n para que sea entero, no cero y positivo
      n=input(' Digite el número de subintervalos (n): ');
      if isreal(n)==1
         if mod(n,1)==0 & sign(n)==1
            hi=101;
         end
      end
   end
   hi=100;
   while hi==100
      w=input(' Digite la condicion inicial [y(a)=k]: ');
      if isreal(w)==1
         hi=101;
      end
   end
   h=(b-a)/n;
   j=a;
   I=0; 
   result(1,1)=w;
   resultado(1,1)=j;
   derive0=subs(fun,{y,t},{w,a});%evaluando f(t,y) con t=a y y=y(a)=wo "ómega subcero"
   disp(' ')
   disp(' ')
   disp(' ')
   disp('	                 i	 			   ti				        yi')					   
   disp(' ')
   disp(' ')
   fprintf('                       %3i          	             %12.8f	 	          %12.8f\n',I,resultado(1,1),result(1,1))
   for i=1:n-1%hallando y1,y2,...,y(n-1) (implementando el método de Runge-Kutta de cuarto orden)
      I=I+1;
      %Hallando k1
      disp(' ')
      h1=subs(fun,{y,t},{w,j});
      k1=h.*h1;
      %k2
      h1=subs(fun,{y,t},{w+(k1/2),j+h/2});
      k2=h.*h1;
      %k3
      h1=subs(fun,{y,t},{w+(k2/2),j+h/2});
      k3=h.*h1;
      %k4
      h1=subs(fun,{y,t},{w+k3,j+h});
      k4=h.*h1;
      %w
      w=w+(k1+(2*k2)+(2*k3)+k4)/6;
      j=a+((i)*h);
      derive(i)=subs(fun,{y,t},{w,j});%evaluando y', es decir f(t,y), con ti=t1,t2,...t(n-1) y yi=y1,y2,...,y(n-1)
      if i==n-1%realizando la PREDICCIÓN de y*n (Adams-Bashforth) y evaluando en f(t,y) con y*(n) para aplicar la CORRECCIÓN
         predictor= w +(h/24)*(55*derive(i)-59*derive(i-1)+37*derive(i-2)-9*derive0);
         derive2=subs(fun,{y,t},{predictor,b});
      end   
      result((i+1),1)= w;
      resultado((i+1),1)=j;
      disp(' ')
      fprintf('                       %3i           	             %12.8f	 	          %12.8f\n',I,resultado(i+1,1),result(i+1,1))
   end
   %aplicando la CORRECCIÓN (Adams-Moulton)
   I=I+1;
   corrector = w + (h/24)*(9*derive2+19*derive(n-1)-5*derive(n-2)+derive(n-3));  
   disp(' ')
   disp(' ')
   fprintf('                       %3i           	             %12.8f	 	          %12.8f\n',I,b,corrector)
   disp(' ')
   disp(' ')
   disp(' ')
   fprintf(' Predicción Adams-Bashforth: y%i* = %9.8f\n',I,predictor)
   fprintf(' Corrección Adams-Moulton:   y%i  = %9.8f\n',I,corrector)
   disp(' ')
   hi=100;
   while hi==100
      disp(' ')
      t=input(' ¿Desea continuar? (S/N): ','s');
      if t=='S'
         t='^';
         hi=101;
      else
         if t=='N'
            hi=101;
         end
      end
   end
end
clc

%Done by: Eng. Jesús Castro. Date: 03-07-2006

