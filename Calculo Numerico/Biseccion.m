t='^';
while t=='^'
  clear 
  disp('<< M�todo De Bisecci�n >>')
  syms x
  y=input(' Digite una expresi�n de f(x): ');
  hi=100;
  while hi==100 %permitiendo al usuario si desea graficar la funci�n que ha digitado
    graph=input(' �Desea graficar la funci�n f(x)? (S/N): ','s');
    if graph=='S' 
       chart=input(' Escriba un rango de valores [A:B:C] para la variable x: ');
       value=subs(y,chart);
       plot(chart,value);
       grid on
       title('Gr�fica de la funci�n f(x)')
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
  while hi==100 %validando que s�lo sea n�meros enteros
     N=input(' Introduzca el n�mero m�ximo de iteraciones: ');
     if isreal(N)==1 %mirando si esta variable es real 
        if mod(N,1)==0
           hi=101;
        end
     end   
  end
  TOL='*';     %validando que la tolerancia est� entre el intervalo establecido
  while TOL=='*' | TOL<10.^(-9) | TOL>0.2
      TOL=input(' Introduzca la tolerancia (MIN=10^-9;MAX=0.2): ');
  end
  eval1=subs(y,a);
  eval2=subs(y,b);
  ab=(eval1)*(eval2);
  if ab>0 | isinf(double(eval1))==1 | isinf(double(eval2))==1 | isnan(double(eval1))==1  | isnan(double(eval2))==1 
    disp(' ') %mirando si se cumple el teorema del valor intermedio
    disp(' ')
    disp(' Error. No existe una ra�z de f(x) en [a,b] pues no se cumple f(a)f(b)<0 (teorema de valor intermedio)')
    disp('        o existe una indeterminaci�n al evaluar con a y b') 
  else   
    i=1;
    FA = eval1;
    if i>N %validando que el n�mero de iteraciones minimo debe ser 1
      disp(' ')
      disp(' ')
      disp(' Error. Iteraci�n no v�lida: m�nimo una iteraci�n.') 
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
          if infin==1 | nan==1 %mirando si existe inf o NaN al aplicar el m�todo
             disp(' ')
             disp(' ')
             disp(' Error. Existen indeterminaciones al momento de hallar p. No se puede encontrar la ra�z de la funci�n.')
             sw=1;
             break;
          end   
          if FP==0 | Error<TOL
             disp('  ')
             disp('  ')
             fprintf(' La soluci�n con una tolerancia de %10.9f es: %10.9f \n',TOL,p)
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
       if FP~=0 & Error>=TOL & sw==0 %mirando si se termin� el c�lculo con el n�mero m�ximo de iteraciones que se estableci�
          disp(' ')
          disp(' ')
          disp(' Error. Excedido n�mero de iteraciones.')
       end   
    end
 end
 disp(' ')
 hi=100;
 while hi==100 
    disp('  ')
    t=input(' �Desea continuar? (S/N): ','s');
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

%Realizado por: Ing. Electr�nico Jes�s A. Castro R.
