
% ----  Calculadora de series de Fourier Trigonometricas -----

clear all;
var=sym('t');
intervalo=zeros(1,2);
% ingreso de datos
fun=sym(input('Funcion Modelo Vibracion Tramo De Tuberia: ','s'));
intervalo(2)=input('Intervalo de tiempo (s): ');
sw=input('Tipo Serie 1-3: ');
smax=input('Numero Maximo de Sumas Parciales: ');
selected=input('Seleccione las que desea graficar: ');
%%%%
cantidad=length(fun); %Número de ecuaciones de la función ingresadas
integral=struct('cn',sym(zeros(1,cantidad)),'a0',sym(zeros(1,cantidad)),...
                'an',sym(zeros(1,cantidad)),'bn',sym(zeros(1,cantidad)));
long=(intervalo(end)-intervalo(1))/2;
n=sym('n');
for c=1:cantidad
     integral.a0(c)=int(fun(c),var,intervalo(1,c),intervalo(1,c+1));
     integral.an(c)=int(fun(c).*cos((n*pi*var)/long),var,intervalo(1,c),intervalo(1,c+1));
     integral.bn(c)=int(fun(c).*sin((n*pi*var)/long),var,intervalo(1,c),intervalo(1,c+1));
end
a0=sum(integral.a0)/(2*long);
an=sum(integral.an)/long;
bn=sum(integral.bn)/long;
 %1:sin , 2:cos, 3:Fourier
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
           %dn=simple(an*cos(n*pi*var/long)+bn*sin(n*pi*var/long));
           dn=an*cos(n*pi*var/long)+bn*sin(n*pi*var/long);
           graph2=2;
       end
       disp('a0:')
       disp(a0)
       disp('sumatoria from n = 1 ... Inf:')
   end
disp(dn); %print symbolic expression 
flag=1;n1=1;n2=1;
test_n1=zeros(1,50);
test_v=sym(zeros(1,50));
for c=n1:50 %Serie trigonometrica n=0:50 
    [num,den]=numden(dn);
    test_dn=subs(den,{n,var},{c,1});
       % Subs aveces no obtiene 0/0 sino (e/0), donde e es un valor muy
       % tendiendo a cero (<10^-14), por limitaciones de MATLAB con el uso
       % de la clase double. Esto genera un Inf en vez de un NaN.
    if test_dn==0%¿indeterminacion? 
        test_n1(flag)=c;%guardando valores n donde existan esos casos
        flag=flag+1;
    end
end
test_n2=flag-1; %Totales de n de los 50 donde existen indeterminaciones
test_n=zeros(1,test_n2);
for c=1:test_n2
    test_n(c)=test_n1(c);
end
disp('**')
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
        den_test=subs(den,n,test_n(c));
        test_v1=subs(den_test,{var},{1});
        if test_v1==0
            flag=0;% seguir derivando
            
        else
            flag=1;% continuar con otro valor de n
            test_v(c)=subs(num,{n},{test_n(c)})/subs(den,{n},{test_n(c)});
        end
    end
end
   % --- mostrar funciones a la cuales tiende la serie en casos de 0/0 ---
if test_n2>0
    for c=1:test_n2
        fprintf('For n=%i\n',test_n(c))
        disp(test_v(c))
    end
end
%  *** [PLOT SECTION AND/OR OUTPUT ARGUMENT VALUE] ***
%if nargin>5 % esto sólo se ejecuta si va a graficar
   
   chart=intervalo(1):0.01:intervalo(end); %valores para intervalo
   % matriz de ceros para almacenar los valores de cada suma parcial
   % al ser evaluados con el intervalo.
   vector=zeros(smax,length(chart)); 
   alfa=zeros(1,length(chart)); %creamos un vector zeros para acelerar
                                %velocidad de ejecución al momento de
                                %guardar datos en vector(v,:)
%end
% --- graficar las series y/o retornar valor de argumento de salida ---
if graph2<2
    beta=0; %senos y complejo
else
    beta=a0; %coseno y Fourier ordinario
end
disp('****')
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
     %if nargin>5 %esto es para graficar
         alfa=subs(beta,{var},{chart}); 
         vector(v,:)=alfa;
     %end
end
%if nargin>5
    plot(chart,vector(selected,:));
    xlabel(char(var));
    ylabel(strcat('F',char(var)))
    title('sumas parciales Fourier')
    for c=1:length(selected)
        v2(c)=cellstr(char(sym(selected(c))));
    end
    legend(v2,'Location','BestOutside')
    disp('Listo!');
%end
