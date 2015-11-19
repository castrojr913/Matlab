%By: jesus castro. Esto es solo un prototipo hay que mejorar mucho el
%script y optimizar el codigo
function [R1,R2,C]=timer555(t,num_ans,answer,num_r2,num_c,f_r2,f_c) %astable normal sin mirar ciclo util
flag_exp=0;
if nargin<1
   error('indique el periodo a calcular!'); 
elseif nargin<2
   cnt_c=1; 
   cnt_r2=1;
   answer=1;
   num_ans=1;
   cnt_r2_exp=3;
   cnt_c_exp=-3;
elseif nargin<3
    cnt_c=1;
    cnt_r2=1;
    answer=1;
    cnt_r2_exp=3;
   cnt_c_exp=-3;
elseif nargin<4
    cnt_c=1;
    cnt_r2=1;
    cnt_r2_exp=3;
   cnt_c_exp=-3;
elseif nargin<5
   cnt_c=1; 
   cnt_r2=num_r2;
   cnt_r2_exp=3;
   cnt_c_exp=-3;
elseif nargin<6
   cnt_r2=num_r2;
   cnt_c=num_c;
   cnt_r2_exp=3;
   cnt_c_exp=-3;
elseif nargin<7
   if f_r2>6 && f_r2<2 
       error('No se aceptan >10Mohm ni <100ohm');
   else
       cnt_r2=num_r2;
       cnt_c=num_c;
       cnt_r2_exp=f_r2;
       cnt_c_exp=-3;
       flag_exp=1;
   end
elseif nargin<8
   if f_r2>6 && f_r2<2 
       error('No se aceptan >=10Mohm ni <100ohm');
   else
      cnt_r2_exp=f_r2;
   end 
   if f_c<-12 && f_r2>-3 
       error('No se aceptan >=10000uF ni <1pF');
   else
      cnt_c_exp=f_c;
   end 
   cnt_r2=num_r2;
   cnt_c=num_c;
   flag_exp=1;
end

cnt_op=1;
r2=[1 1.2 1.5 1.8 2 2.2 2.4 3 3.3 3.9 4.7 5.6 6.8 8.2];
c=[1 2.2 3.3 4.7];% valores comerciales base 4: 1 2.2 3.3 4.7
iter=0;
R1_aux=zeros(1,num_ans);
R2_aux=zeros(1,num_ans);
C_aux=zeros(1,num_ans);
while 1
    c_aux=c(cnt_c).*10^cnt_c_exp;
    r2_aux=r2(cnt_r2).*10^cnt_r2_exp;
    r1_aux=t/(0.693*c_aux)-2*r2_aux; %ecuacion para astable
    if r1_aux<10^6 && r1_aux>10^2
        R1_aux(cnt_op)=r1_aux;
        R2_aux(cnt_op)=r2_aux;
        C_aux(cnt_op)=c_aux;
        if cnt_op<num_ans
           cnt_op=cnt_op+1;
        else
            fprintf('iteraciones: %i\n',iter);
            R1=R1_aux(answer);
            R2=R2_aux(answer);
            C=C_aux(answer);
            break;
        end
    end
    if flag_exp~=1
       
       cnt_c=cnt_c+1;
       if cnt_c>4
           cnt_c=1;
           cnt_c_exp=cnt_c_exp-1;
           if cnt_c_exp<-12
               cnt_c_exp=-3;
               cnt_r2=cnt_r2+1;
               if cnt_r2>14
                   cnt_r2=1; 
                   cnt_r2_exp=cnt_r2_exp+1;
               end
           end
       end
    end
    if cnt_r2_exp>6 || ceil(log10(r1_aux))>6
        disp('Falló cálculo: R2 o R1 >=10Mohm');
        fprintf('Total iteraciones: %i\n',iter);
        R1=NaN;
        R2=NaN;
        C=NaN;
        break;
    elseif iter>600
        disp('Excedido numero de iteraciones');
        R1=NaN;
        R2=NaN;
        C=NaN;
        break;
    else
        iter=iter+1;
    end
end