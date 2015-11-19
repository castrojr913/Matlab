t='^';
while t=='^'
  clear 
  disp('<< Método De Bisección >>')
  syms x
  y=input(' Digite una expresión de f(x): ');
  hi=100;
  while hi==100 %permitiendo al usuario si desea graficar la función que ha digitado
    graph=input(' ¿Desea graficar la función f(x)? (S/N): ','s');
    if graph=='S' 
       chart=input(' Escriba un rango de valores [A:B:C] para la variable x: ');
       value=subs(y,chart);
       plot(chart,value);
       grid on
       title('Gráfica de la función f(x)')
       xlabel('Eje x');ylabel('Eje y')
       hi=101;
    else
       if graph=='N'
          hi=101;
       end
    end
  end
  a=input(' Digite valor extremo inferior (a) del intervalo [a,b]: ');
  b=input(' Digite valor extremo superior (b) del intervalo [a,b]: ');   
  hi=100;
  while hi==100 %validando que sólo sea números enteros
     N=input(' Introduzca el número máximo de iteraciones: ');
     if isreal(N)==1 %mirando si esta variable es real 
        if mod(N,1)==0
           hi=101;
        end
     end   
  end
  TOL='*';     %validando que la tolerancia esté entre el intervalo establecido
  while TOL=='*' | TOL<10.^(-9) | TOL>0.2
      TOL=input(' Introduzca la tolerancia (MIN=10^-9;MAX=0.2): ');
  end
  eval1=subs(y,a);
  eval2=subs(y,b);
  ab=(eval1)*(eval2);
  if ab>0 | isinf(double(eval1))==1 | isinf(double(eval2))==1 | isnan(double(eval1))==1  | isnan(double(eval2))==1 
    disp(' ') %mirando si se cumple el teorema del valor intermedio
    disp(' ')
    disp(' Error. No existe una raíz de f(x) en [a,b] pues no se cumple f(a)f(b)<0 (teorema de valor intermedio)')
    disp('        o existe una indeterminación al evaluar con a y b') 
  else   
    i=1;
    FA = eval1;
    if i>N %validando que el número de iteraciones minimo debe ser 1
      disp(' ')
      disp(' ')
      disp(' Error. Iteración no válida: mínimo una iteración.') 
    else 
       sw=0;
       disp(' ')
       disp(' ')
       disp('    i	          a	           f(a)	                b	           p	             f(p)	       (b-a)/2        Signo')
       while i<=N
          disp(' ') 
          p = (a + (b-a)/2); 
          FP = subs(y,p);
          Signo = sign(FA*FP);
          Error = (b-a)/2;
          fprintf('  %3i      %13.9f    %15.9f      %13.9f    %15.9f     %15.9f    %15.9f       %2i\n',i,a,FA,b,p,FP,Error,Signo)
          nan=isnan(double(FP));
          infin=isinf(double(FP));
          if infin==1 | nan==1 %mirando si existe inf o NaN al aplicar el método
             disp(' ')
             disp(' ')
             disp(' Error. Existen indeterminaciones al momento de hallar p. No se puede encontrar la raíz de la función.')
             sw=1;
             break;
          end   
          if FP==0 | Error<TOL
             disp('  ')
             disp('  ')
             fprintf(' La solución con una tolerancia de %10.9f es: %10.9f \n',TOL,p)
             break;     
          else     
             i=i+1; 
             if FA*FP>0   
                a=p; 
                FA=FP;  
             else    
                b=p; 
             end  
          end 
       end
       if FP~=0 & Error>=TOL & sw==0 %mirando si se terminó el cálculo con el número máximo de iteraciones que se estableció
          disp(' ')
          disp(' ')
          disp(' Error. Excedido número de iteraciones.')
       end   
    end
 end
 disp(' ')
 hi=100;
 while hi==100 
    disp('  ')
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

%Realizado por: Ing. Electrónico Jesús A. Castro R.
