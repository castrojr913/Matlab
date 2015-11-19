function [x,A,b]=circuitmodel
clear
fid=fopen('c:\sistema.txt');
nnz=0;%contador de todos los valores no nulos en la matriz
k=1;%contador para las posiciones del termino indep.
while ~feof(fid)%ciclo que leer líneaa lnea a lnea hasta el final del archivo
    tline=fgetl(fid);%lee cada linea del archivo individualmente
    elemento=str2num(tline);%pasar datos a formato numérico
    if nnz==0 % va a leer la primera fila
       N=elemento; %lee el rango de la matriz
       nnz=nnz+1;
       mf=zeros(N,N);%creando matriz NxN de ceros (coeficientes)
       b=zeros(N,1);%vector de ceros de termino independiente
    elseif max(size(elemento))>1 %si la línea leída es un vector (mirar que
                                 %en block de notas está en forma sparce)
           for i=1:elemento(1) %para filas
               for j=1:elemento(2) %para columnas
                   if i==elemento(1) && j==elemento(2)
                         mf(i,j)=elemento(3); %reemplazar por el valor de la
                                             %coordenada (i,j) en el block de notas
                   end   
               end              
           end                       
    else %sino capturar elementos del termino independiente
        b(k)=elemento;%reemplazar valores en cada fila
        k=k+1;
    end
end
fclose(fid);
A=sparse(mf);%crea la matriz sparse
x=A\b;%resuelve el sistema de ecs.
% returns