function beta=fourierseries(fun,var,smax,intervalo,sw,varargin)
% FOURIERSERIES         Calculate Fourier's series of a function, its 
%                       half-range development and plot its partial sums.
% By: Jesus Castro. Date: june 2006, Revised: 03/01/2010
%  This script detects finite indeterminations until n=50 (but it may
%  modify optionally). Because of limitations with the use double class, 
%  many indeterminations 0/0 are assumed Inf because it obtains e/0 
%  where e->0 (<10^-14)
% Por mejorar: convergencia, multihilo, cumpla condiciones dirichlet

syms n
k1=eps; %valor para k y w por defecto
k2=eps;
n1=1; %valor inicio para algoritmo de indeterminacion
n2=1;
if nargin<1
    error('Very few input arguments')
elseif nargin<10 
    if nargin==1 %definir var default si nargin=1
        var=sym('t');
    end
    if isnumeric(fun) %no sym?
        k=sym('k');
        var0='';
    else
        var0=sym(findsym(fun)); % findsym busca variables clase sym y las muestra
                            % como clase char. Por ende, se pasa a clase sym.
    end
    if isempty(var0)~=1 % si fun no es constante entra sino sale
     if length(var0)>2 %mas de dos variables sym?
        error('More than two symbolic variables')                         
     elseif length(var0)==1
%     if isempty(var0)==1% no hay variables sym?
%         k=sym('k'); %valores arbitrarios para evitar errores al buscar indeter.
    %if length(var0)==1 %una sola variable sym?
        if var0~=var%diferente a var?
           k=var0;
        else
           k=sym('k');
        end    
     elseif strcmp(char(var0(1)),char(var))==0 %Comparar las dos variables
        k=var0(1); 
     else
        k=var0(2);
     end                         
    end
    if nargin>3 %casos nargin = 4 a 6
        intervalo=sym(intervalo);
        var1=sym(findsym(intervalo));%encontrar variables sym en intervalo
        if length(var1)>1
           error('Sólo es válido una variable clase sym para el intervalo')
        end
        if isempty(var1)==1 %¿no hay variables sym?
            w=sym('w'); 
        else %sí hay
            w=var1;
        end
        if nargin<5 %4
            sw=3;
        elseif nargin<10 %9-5
            if sw>4 || sw<=0
                error('Incorrect option') 
            elseif sw<3 && intervalo(1)~=0 %validar series medio rango
                error('Inferior limit of the interval must be zero')
            elseif nargin>5 && sw==4
                error('No plot for complex Fourier series')
            elseif nargin>5 %6
           %Lo siguiente detecta si asignaron los valores para las variables
           %clase sym (excepto var) en la función para la gráfica y escoge
           %la opción correspondiente
                  if length(varargin)==4
            % Como son datos comunes, creamos un struct para organizar
            % mejor los datos. 
                       graph=struct('pasos',varargin{3},'selected',varargin{4});
            % miramos cual es la variable clase sym (no var) para guardarlo
            % y posteriormente asignarle el valor para la gráfica
                       k1=varargin{1}; %valor asginado a las variables sym
                       k2=varargin{2};
                       k3=1; %usado para asignar leyendas en la gráfica
           % Suponemos que no se asignaron variables clase sym tanto a la
           %función como el intervalo (excepto var).
                  elseif length(varargin)==2
                      graph=struct('pasos',varargin{1},'selected',varargin{2});
                      k3=2;
                  elseif length(varargin)==3 %si se dio valor sólo para una variable 
                                             %sym, no a los dos como en el 1er if. 
                         graph=struct('pasos',varargin{2},'selected',varargin{3});
                         k3=3; 
                         if isempty(var0)==1 
                             k2=varargin{1};
                         else 
                             k1=varargin{1};
                         end
                  else
                      error('Excedeed input arguments')
                  end
            end
        end
    else %entre nargin = 1 a 3
        sw=3; %Fourier por defecto
        w=sym('w');%evitar errores cuando se busque indeterminaciones
        intervalo=sym([-pi pi]); %intervalo [-pi,pi] por default
        if length(fun)>1
            error('No aplica a funciones con más de una ecuación')
        elseif nargin==1 || nargin==2
            smax=10;%suma parcial para retornar en beta (default)
        end 
    end
else %mayor de 9 entradas
    error('Excedeed input arguments')
end
% --- [CALCULUS SECTION] ---
cantidad=length(fun); %Número de ecuaciones de la función ingresadas
integral=struct('cn',sym(zeros(1,cantidad)),'a0',sym(zeros(1,cantidad)),...
                'an',sym(zeros(1,cantidad)),'bn',sym(zeros(1,cantidad)));
long=(intervalo(end)-intervalo(1))/2;
for c=1:cantidad
     integral.a0(c)=int(fun(c),var,intervalo(1,c),intervalo(1,c+1));
     integral.an(c)=int(fun(c).*cos((n*pi*var)/long),var,intervalo(1,c),intervalo(1,c+1));
     integral.bn(c)=int(fun(c).*sin((n*pi*var)/long),var,intervalo(1,c),intervalo(1,c+1));
     integral.cn(c)=int(fun(c).*exp(-1i*n*pi*var/long),var,intervalo(1,c),intervalo(1,c+1));
end
a0=sum(integral.a0)/(2*long);
an=sum(integral.an)/long;
bn=sum(integral.bn)/long;
cn=sum(integral.cn)/(2*long);
if sw<4 %1:sin , 2:cos, 3:Fourier 4:Complex
   if sw==1
        disp('Sin Series:')
        dn=bn*sin(n*pi*var/(2*long));
        graph2=1;
   else
       if sw<3
           disp('Cosin Series:')
           dn=an*cos(n*pi*var/(2*long));
           graph2=2;
       else
           disp('Fourier Series:')
           dn=simple(an*cos(n*pi*var/long)+bn*sin(n*pi*var/long));
           graph2=2;
       end
       disp('a0:')
       disp(a0)
       disp('sumatoria from n = 1 ... Inf:')
   end
else
    disp('sumatoria from n = -Inf ... Inf:')
    dn=simple(cn*exp(1i*n*pi*var/long));
    n1=-50; %para buscar indeterminaciones desde -50 hasta 50
    n2=-smax;
    graph2=1;
end
disp(dn); %print symbolic expression 
% PROBLEMA: la función x(t) puede tener indeterminaciones finitas, es decir
% 0/0, forzando a crear un error de ejecución al graficar. Para resolverlo,
% usamos la regla de L'Hopital. Nota: las indeterminaciones infinitas, como
% también un número infinito de indeterminaciones finitas no pueden
% resolverse; x(t) tiene que cumplir las condiciones de Dirichlet.
flag=1;
test_n1=zeros(1,50);
test_v=sym(zeros(1,50));
for c=n1:50 %Serie trigonometrica n=0:50 y Compleja n=-50:50
    test_dn=double((subs(dn,{n,k,w,var},{c,k1,k2,1})));
       % Subs aveces no obtiene 0/0 sino (e/0), donde e es un valor muy
       % tendiendo a cero (<10^-14), por limitaciones de MATLAB con el uso
       % de la clase double. Esto genera un Inf en vez de un NaN.
    if isnan(test_dn)==1 || isinf(test_dn)==1%¿indeterminacion? 
        test_n1(flag)=c;%guardando valores n donde existan esos casos
        flag=flag+1;
    end
end
test_n2=flag-1; %Totales de n de los 50 donde existen indeterminaciones
test_n=zeros(1,test_n2);
for c=1:test_n2
    test_n(c)=test_n1(c);
end
disp('..')
% -- [Regla de L'Hopital] --
flag=1;
for c=1:test_n2
    if flag==1
        flag=0;% (re)iniciamos el proceso 
        [num,den]=numden(dn);
    end   
    while flag==0 % ahora calculamos el valor del límite
        num=diff(num,n);%derivada num
        den=diff(den,n);%derivada den
        test_v(c)=subs(num,{n},{test_n(c)})/subs(den,{n},{test_n(c)});
        test_v1=double(subs(test_v(c),{k,w,var},{k1,k2,1}));
        if isnan(test_v1)==1 || isinf(test_v1)==1
            flag=0;% seguir derivando
        else
            flag=1;% continuar con otro valor de n
        end
    end
end
   % --- mostrar funciones a la cuales tiende la serie en casos de 0/0 ---
if test_n2>0
    for c=1:test_n2
        fprintf('For n=%i\n',test_n(c))
        disp(simple(test_v(c)))
    end
end
%  *** [PLOT SECTION AND/OR OUTPUT ARGUMENT VALUE] ***
if nargin>5 % esto sólo se ejecuta si va a graficar
   graph1=subs(intervalo,w,k2);
   chart=graph1(1):graph.pasos:graph1(end); %valores para intervalo
   % matriz de ceros para almacenar los valores de cada suma parcial
   % al ser evaluados con el intervalo.
   vector=zeros(smax,length(chart)); 
   alfa=zeros(1,length(chart)); %creamos un vector zeros para acelerar
                                %velocidad de ejecución al momento de
                                %guardar datos en vector(v,:)
end
% --- graficar las series y/o retornar valor de argumento de salida ---
if graph2<2
    beta=0; %senos y complejo
else
    beta=a0; %coseno y Fourier ordinario
end
disp('...')
for v=n2:smax
    flag2=0; 
    for c=1:test_n2 
        if test_n(c)==v %¿n indeterminado es igual a n actual?
            beta=beta+test_v(c);
            flag2=1;
            break;
        end
     end
     if flag2==0
         beta=beta+subs(dn,n,v);
     end
     if nargin>5 %esto es para graficar
         alfa=subs(beta,{k,w,var},{k1,k2,chart}); 
         vector(v,:)=alfa;
     end
end
if nargin>5
    h2=plot(chart,vector(graph.selected,:));
    set(h2,'linewidth',2)
    grid on;
    xlabel(char(var));
    ylabel(strcat('F',char(var)))
    if k3==1 %asignando leyendas automaticamente a cada suma parcial
        v1=varargin{4}; 
    elseif k3==2
        v1=varargin{2};
    else
        v1=varargin{3};
    end
    for c=1:length(v1)
        v2(c)=cellstr(char(sym(v1(c))));
    end
    legend(v2,'Location','BestOutside')
end
