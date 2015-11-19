function p=hopital(varargin)
%HOPITAL    calcula el límite de una función f cuya variable independiente
%           tiende a n en caso de indeterminación 0/0.
%   P = HOPITAL(f) determina el límite de la función f cuando su variable
%   independiente tiende a cero.
%
%   P = HOPITAL(f,n) determina el límite de la función f cuando su variable
%   independiente tiende a n.
%
%   By: Jesús A. Castro R., July 2008. Revision: 01/01/2010 

if nargin<1
   error('Very few input arguments')
else
   var=findsym(varargin{1});
   fun=varargin{1};
   if nargin<2 %default is 0
       lim=0;
   elseif nargin<3
       lim=varargin{2};
   else
       error('Too many input arguments')
   end
end
[num,den]=numden(fun);
while 1
      num=diff(num,var); %derivada num
      den=diff(den,var); %derivada den
      p=subs(num,{var},{lim})/subs(den,{var},{lim}); %valor deseado
      if isnan(p)==1 % 0/0?
          continue; 
      else
          break; 
      end     
end
 

