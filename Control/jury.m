% JURY       Determina la estabilidad absoluta de un polinomio p(z) según 
%            el criterio de estabilidad de Jury
%
% p=JURY(v)  Determina la estabilidad del polinomio y retorna la matriz de
%            Jury. El polinomio debe ser un vector y de la forma 
%            an*z^n + an-1*z^n-1 + ... + a0 = 0.

% $ By: Jesus A Castro R. 14/05/2010

function varargout = jury(varargin)
if nargin<1 || nargin>1
    error('Insuficiente o excedido numero de argumentos de entrada');
end
if nargout>1
    error('Excedido numero de argumentos de salida');
end
disp(' ');
flag1=0;%para inidicar criticamente estable
flag2=0;%para ver si hay q calcular matriz de jury o no
poly_jury=varargin{1}; %denominador de la funcion o polinomio
grado=length(poly_jury(:))-1; %grado del polinomio
if poly_jury(1)~=0 % an ~= 0?
    %se usa roundn para evitar problemas cuando el test de cero, debido a
    %limitaciones de precision q da un extraño numero negativo -0.000...
   test_poly=roundn(subs(poly2sym(poly_jury(:)),-1),-4); % test p(-1)
   test_poly2=roundn(subs(poly2sym(poly_jury(:)),1),-4); % test p(1)
   test_poly1=mod(grado,2); % ¿par o impar?
   if test_poly2<0 
       flag2=1;
       fprintf('Inestable: p(1)=%7.4f<0',test_poly2);
       varargout{:}=0;
   elseif test_poly1==0 && test_poly<0
       flag2=1;
       fprintf('Inestable: p(-1)=%7.4f<0 siendo n par',test_poly);
       varargout{:}=0; 
   elseif test_poly1~=0 && test_poly>0
       flag2=1;
       fprintf('Inestable: p(-1)=%7.4f<0 siendo n impar',test_poly);
       varargout{:}=0;     
   elseif test_poly==0 || test_poly2==0 %criticamente estable
       flag1=1; 
   elseif grado<2 %  ** caso especial para valores de n<2
        flag2=1;
        if abs(poly_jury(1))<abs(poly_jury(end)) %|an|<=|a0|?
           disp('Inestable');
        else
           disp('Estable');
        end
        varargout{:}=0;
   end
   if flag2==0 % 2n-3 filas del arreglo => n minima: 2 -> 1 fila
       filas=2*grado-3;
       if filas>1 %n>2
           %matriz jury
           arr_jury=zeros(filas,grado+1);
           % ordenar primera fila: a0 ... an
           arr_jury(1,:)=ordenarp(poly_jury);
           % -- algoritmo de calculo de coeficientes jury --
           cnt_jury=grado; %si son n elementos tenemos n-1 calculos
           cnt_jury1=1; % indica posicion relativa a la funcion ordenap
           for i=2:2:filas
               arr_jury(i,:)=ordenarp(arr_jury(i-1,:),cnt_jury1);  
               j=cnt_jury+1;    %datos de la ultima columna hasta la 2nda
               for k=1:cnt_jury %en el calculo, se mantiene las primeras
                   arr_jury(i+1,k)=arr_jury(i-1,1).*arr_jury(i,j)-arr_jury(i,1).*arr_jury(i-1,j);        
                   j=j-1;
               end
               cnt_jury=cnt_jury-1; %decrementar por par llega hasta 2
               cnt_jury1=cnt_jury1+1;
           end
       else %n=2
           arr_jury=zeros(1,grado+1);
           arr_jury(1,:)=ordenarp(poly_jury);
       end
       % -- examinar estabilidad: usamos filas impares --
       j=grado+1;
       flag=0; %indicar tipo de mensaje (estable o inestable)
       for i=1:2:filas 
           if abs(arr_jury(i,1))>abs(arr_jury(i,j)) 
              if i==1  %solo para |an|<|a0|
                 disp('Inestable');
                 flag=1;
                 break;
              end
           elseif i~=1
               disp('Inestable');
               flag=1;
               break;
           end
           j=j-1;
       end
       if flag1==1
           disp('Criticamente Estable');
           varargout{:}=arr_jury; 
       elseif flag~=1
           disp('Estable');
           varargout{:}=arr_jury;
       end
   end
else %condicion necesaria 1 incumplida
    disp('Inestable: an = 0');
    varargout{:}=0;
end
