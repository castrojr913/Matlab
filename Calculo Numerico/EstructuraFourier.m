%CALCULADORA FOURIER COMPLEJA
clear all;
var=sym('t');
intervalo=zeros(1,2);
% ingreso de datos
fun=sym(input('Funcion Modelo Estructura: ','s'));
intervalo(2)=input('Intervalo de tiempo de la funcion: ');
smax=input('Numero Maximo de Sumas Parciales: ');
selected=input('Seleccione las que desea graficar: ');
length(selected)
%%%%
disp(fun)
cantidad=length(fun); %Número de ecuaciones de la función ingresadas
integral=struct('cn',sym(zeros(1,cantidad)),'a0',sym(zeros(1,cantidad)),...
                'an',sym(zeros(1,cantidad)),'bn',sym(zeros(1,cantidad)));
long=(intervalo(end)-intervalo(1))/2;
n=sym('n');
for c=1:cantidad
     integral.cn(c)=int(fun(c).*exp(-1i*n*pi*var/long),var,intervalo(1,c),intervalo(1,c+1));
end
cn=sum(integral.cn)/(2*long);
disp('Sumatoria desde n = -Inf ... Inf:')
dn=simple(cn*exp(1i*n*pi*var/long));
disp(dn); %print symbolic expression 
flag_graficar=1;
if flag_graficar==1
    n1=0;n2=1;
    flag=1;
    flag_a0=0;
    test_n1=zeros(1,50);
    test_v=sym(zeros(1,50));
    % Graficamos parte Real de la Serie
    dn=real(dn); 
    % Determinar presencia de 0/0 (incluye incluso al c0) hasta n=50
    for c=n1:50 
        test_dn=double((subs(dn,{n,var},{c,1})));
        if isnan(test_dn)==1 || isinf(test_dn)==1%¿indeterminacion? 
            test_n1(flag)=c; %guardando valores n
            if c==0
                flag_a0=1; 
            end
            flag=flag+1;
            
        end
    end
    disp(flag);
    test_n2=flag-1; %Totales de n de los 50 donde existen indeterminaciones
    test_n=zeros(1,test_n2);
    % % -- [Regla de L'Hopital] --
    flag=1;
    for c=1:test_n2
        if flag==1
            flag=0;% (re)iniciamos el proceso 
            [num,den]=numden(dn);
        end   
        while flag==0 % ahora calculamos el valor del límite
            num=diff(num,n);%derivada num
            den=diff(den,n);%derivada den
            den_test=subs(den,{n},{test_n(c)});
            %test_v1=double(subs(test_v(c),{var},{1}));
            test_v1=subs(den_test,{var},{1}); %hay ceroes?
            %if isnan(test_v1)==1 || isinf(test_v1)==1
            if test_v1==0
                flag=0;% seguir derivando
            else
                flag=1;% continuar con otro valor de n
                test_v(c)=subs(num,{n},{test_n(c)})/subs(den,{n},{test_n(c)});
            end
            
        end
    end
%    % --- mostrar funciones a la cuales tiende la serie en casos de 0/0 ---
% if test_n2>0
%     for c=1:test_n2
%         fprintf('For n=%i\n',test_n(c))
%         disp(simple(test_v(c)))
%     end
% end
% %  *** [PLOT SECTION AND/OR OUTPUT ARGUMENT VALUE] ***
    chart=intervalo(1):0.01:intervalo(end); %valores para intervalo
   % matriz de ceros para almacenar los valores de cada suma parcial
   % al ser evaluados con el intervalo.
   vector=zeros(smax,length(chart)); 
   alfa=zeros(1,length(chart)); %creamos un vector zeros para acelerar
                                %velocidad de ejecución al momento de
                                %guardar datos en vector(v,:)

    % --- graficar las series y/o retornar valor de argumento de salida ---
    
    % si para n = 0 fue 0/0, corresponde a c0
    if flag_a0==1
        beta_complex=subs(test_v(1),0);% hacer t=0
        disp(beta_complex);
        flag_a0=flag_a0+1;
    else %valor C0 (no siempre da 0/0)
        beta_complex=subs(dn,{n,var},{0,0});
        flag_a0=1;
    end
    for v=n2:smax
        flag2=0; 
        for c=flag_a0:test_n2 
            if test_n(c)==v %¿n indeterminado es igual a n actual?
                beta_complex=beta_complex+test_v(c);
                flag2=1;
                break;
            end
        end
        if flag2==0
            beta_complex=beta_complex+subs(dn,n,v);
        end
        alfa=subs(beta_complex,{var},{chart}); 
        vector(v,:)=alfa;
    end
        plot(chart,vector(selected,:));
        set(gca,'YTickLabel',' '); 
        xlabel(char(var));
        ylabel(strcat('F',char(var)))
        title('Grafica Real De Sumas Parciales')
end

