%fourierseries(fun,var,smax,intervalo,sw,varargin)
% --- [CALCULUS SECTION] ---
var=sym('t');
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
dn=simple(an*cos(n*pi*var/long)+bn*sin(n*pi*var/long));
disp('Fourier Series:')
disp(a0);
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
graph1=subs(intervalo,w,k2);
chart=graph1(1):graph.pasos:graph1(end); %valores para intervalo
 % matriz de ceros para almacenar los valores de cada suma parcial
 % al ser evaluados con el intervalo.
 vector=zeros(smax,length(chart)); 
 alfa=zeros(1,length(chart)); %creamos un vector zeros para acelerar
                                %velocidad de ejecución al momento de
                                %guardar datos en vector(v,:)
% --- graficar las series y/o retornar valor de argumento de salida ---
beta=a0;
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
     alfa=subs(beta,{k,w,var},{k1,k2,chart}); 
     vector(v,:)=alfa;
end
h2=plot(chart,vector(graph.selected,:));
set(h2,'linewidth',2)
grid on;
xlabel(char(var));
ylabel(strcat('F',char(var)))
