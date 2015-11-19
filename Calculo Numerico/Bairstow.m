t='^';%This program finds the roots of any polinomial. It's similar to the function 'roots' of MATLAB, but it's more interactive with the user.
while t=='^'
   clear  
   clc	%clearing screen...!
   disp(' ')
   disp(' ')
   disp('                 				   Método De Bairstow')
   sw=0;
   disp(' ')
   disp(' ')
   disp(' Nota: sólo aplicable a funciones polinómicas. No se aplica a funciones constantes, periódicas entre otras.')%Note que son polinomios sólo en función de x
   disp(' ')
   disp(' ')
   hi=100;
   while hi==100%validando n para que sea entero
      n=input(' Digite el grado (Nºentero) de la ecuación polinómica: ');
      if isreal(n)==1 % friends complex numbers: may not to entry here. I'm sorry.
         if mod(n,1)==0
            hi=101;
         end
      end
   end
   if n<3 %Para validar el grado de la ecuación polinómica
      if n==2|n==1
         disp(' ')
         disp(' ')
         disp(' Para este grado no es necesario aplicar el método.') 
         sw=1;
      else 
        if n<=0
           disp(' ')
           disp(' ')
           disp(' Error. Grado de ecuación polinómica inválida.')
           sw=1; 
        end  
      end  
   end
   if sw==0  
      hi=100;
      x=sym('x');
      polinomio=sym('polinomio');
      TAM = zeros(1,n+1);
      MT = sum((n+1).*size(TAM));%validando el polinomio
      while hi==100 | MT~=sum((n+1).*size(TAM))
         polinomio=input(' Digite el polinomio en interés para hallar sus raíces: ');%ingreso del polinomio usando los coeficientes y en la forma indicada
         if any(isletter(char(polinomio)))==1 %para evitar errores con sym2poly el cual trabaja sólo con polinomios que contengan variable x
            a=sym2poly(polinomio);%Detecta el grado del polinomio y saca los coeficientes del mismo
            MT = sum((n+1).*size(a));
            hi = 101;
         end
      end   
      hi=100;
      while hi==100 %graficando el polinomio
         graph=input(' ¿Desea obtener la grafica de este polinomio? (S/N): ','s');
         if graph=='S'
            chart=input(' Escriba un rango de valores [A:B:C] para la variable x: ');
            value=subs(polinomio,chart);
            plot(chart,value);
            grid on
            xlabel('Eje x');ylabel('Eje y')
            title('Gráfica de la función polinómica')
            hi=101;
         else
            if graph=='N'
               hi=101;
            end
         end
      end 
      rss=zeros(1,2);
      ARG=sum(2*size(rss));
      hi=100;
      while hi==100 | ARG~=sum(2*size(rss))%validando rs para que se digite sólo 2 valores
         rs=input(' Digite las aproximaciones iniciales r y s para la ecuación cuadrática x^2-rx-s, [r,s]: ');
         ARG=sum(2*size(rs));
         hi=101;
      end   
      hi=100;
      while hi==100 %validando para que sea NO sólo entero
         NO=input(' Introduzca el número máximo de iteraciones: ');
         if isreal(NO)==1 %Please, this way isn't allowed. Bye!
            if mod(NO,1)==0
               hi=101;
            end
         end   
      end
      TOL='*';
      while TOL=='*' | TOL<10.^(-9) | TOL>0.2
         TOL=input(' Introduzca la tolerancia (MIN=10^-9;MAX=0.2): ');
      end
      i=1;
      r=rs(1);
      s=rs(2);
      if i>NO
         disp(' ')
         disp(' ')
         disp(' Error. Mínimo una iteración.')
      else
         disp(' ')
         disp(' ')
         disp(' Raíces:') 
         disp(' ')
         disp(' ')
         while i<=NO
            b=zeros(1,length(a));  
            c=zeros(1,length(a));  
            b(1)=a(1);    
            b(2)=a(2)+r.*b(1);
            c(1)=b(1);    
            c(2)=b(2)+r.*c(1);
            for j=3:n+1
               b(j)=a(j)+r.*b(j-1)+s*b(j-2);
               c(j)=b(j)+r.*c(j-1)+s*c(j-2);
            end 
            cam=[-b(n)  c(n-2);-b(n+1)  c(n-1)];
            cam2=[c(n-1)  c(n-2);c(n)  c(n-1)];
            cam3=[c(n-1)  -b(n);c(n)  -b(n+1)];
            cam4=[c(n-1)  c(n-2);c(n)  c(n-1)];
            result=det(cam);   
            result2=det(cam2);
            result3=det(cam3);
            result4=det(cam4);
            if result2==0 | result4==0
               disp(' Error. Existen indeterminaciones en el desarrollo del método. Hasta ahora, no se pueden hallar las raíces del polinomio.')% es decir: inf o NaN
               sw=1;
               break   
            end
            dr=(result)./(result2);
            ds=(result3)./(result4);
            r=r+dr;
            s=s+ds;
            if r==0 | s==0
               disp(' Error. Existen indeterminaciones en el desarrollo del método. Hasta ahora, no se pueden hallar las raíces del polinomio.')% es decir: inf o NaN
               sw=1;
               break  
            end                  
            if abs(dr/r)<TOL & abs(ds/s)<TOL
               x1=(r+sqrt(r.^2+4.*s))./2;
               x2=(r-sqrt(r.^2+4.*s))./2;
               disp(x1)
               disp(x2) 
               n=n-2;%examinando el grado del cociente Q(x) 
               if n==2
                  x3=(-b(n)+sqrt(b(n).^2-4.*b(n-1).*b(n+1)))./(2.*b(n-1));
                  x4=(-b(n)-sqrt(b(n).^2-4.*b(n-1).*b(n+1)))./(2.*b(n-1));
                  disp(x3) 
                  disp(x4)      
                  break
               else 
                  if n==1
                     x5=(-b(n+1))./(b(n));
                     disp(x5) 
                     break
                  else
                     if n~=2 & n~=1
                        i=i+1;
                        for k=1:n+1
                           a(k)=b(k);
                        end 
                     end
                  end
               end
            else
               i=i+1;
            end   
         end   
      if sw==0   
         if abs(dr/r)>=TOL | abs(ds/s)>=TOL 
            disp(' ')
            disp(' Error. Excedido número de iteraciones.')
            sw=1;
         end
      end
     end %END del if i<=NO
   end %del primer if sw==0
   if sw==0
     disp(' ')  
     fprintf(' Número total de iteraciones: %i',i) 
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
end %el end del while del comienzo
clc
 
%Realizado por: Ing. electrónico Jesús A. Castro R. Revisado: 28/06/2006.
   