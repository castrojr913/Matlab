clear

%%%% VARIABLE DEPENDIENTE %%%%%
flag_continuar=1;
while flag_continuar==1
  clc
  disp('** ANALISIS GRAFICA DE DATOS MEDIANTE TRANSFORMADA DE FOURIER **');
  opc=input('Fuente de datos (1->Archivo,2->Funcion):');
  switch opc 
    
    case 1
        disp('Cargando muestra de datos de la Estructura En Analisis ... ');
        disp('Presione una tecla para continuar... ');
        pause;
        [fnm, path] = uigetfile('*.txt','Archivo? .txt'); 
        if ~isequal(fnm,0)   %si user no cancelo ventana     
            path = fullfile(path,fnm);
            flag_datos=1;
            disp('OK. Espere ...');
        else
            disp('No cargo archivo, no puede visualizar resultados.');
            flag_datos=0;
        end
        %leer datos de archivo
        if flag_datos==1
            cnt_total=0;
            id=fopen(path);
            while ~feof(id) 
                cnt_total=cnt_total+1;
                fgets(id);
            end
            fclose(id);
            id=fopen(path);
            data=zeros(1,cnt_total);
            cnt_total=0;
            while ~feof(id) 
                cnt_total=cnt_total+1;
                data(cnt_total)=double(sym(fgets(id)));
                %disp(data(cnt_total))
            end
            fclose(id);
        %%%% VARIABLE INDEPENDIENTE %%%%%
            disp('Cargando valores de tiempo de la muestra ... ');
            disp('Presione una tecla para continuar... ');
            pause;
            [fnm, path] = uigetfile('*.txt','Archivo? .txt'); 
            if ~isequal(fnm,0)   %si user no cancelo ventana     
                path = fullfile(path,fnm);
                flag_datos=1;
                disp('OK. Espere ...');
            else
                disp('No cargo archivo, no puede visualizar resultados.');
                flag_datos=0;
            end
            %leer datos de archivo
            if flag_datos==1
                cnt_total=0;
                id=fopen(path);
                while ~feof(id) 
                    cnt_total=cnt_total+1;
                    fgets(id);
                end
                fclose(id);
                id=fopen(path);
                time=zeros(1,cnt_total);
                cnt_total=0;
                while ~feof(id) 
                    cnt_total=cnt_total+1;
                    time(cnt_total)=double(sym(fgets(id)));
                end
                fclose(id);
                %%%%%%%%    
                time_L=length(time); %tiempo
                fs=time_L/(time(end)-time(1)); %muestreo
                npuntos=pow2(nextpow2(time_L));
                fscale=(fs/2)*linspace(0,1,npuntos/2);
                FFT = abs(fft(data,npuntos)); %FFT
                FFT_abs_norm=abs(FFT)./(max(abs(FFT)));
                subplot(2,1,1)
                plot(fscale(1:round(time_L/2)),FFT_abs_norm(1:round(time_L/2)),'r');
                xlabel('Hz')
                title('Respuesta en Frecuencia Via Trans. Fourier')
                subplot(2,1,2)
                plot(time,data,'r');
                xlabel('seg')
                title('Respuesta en el tiempo')
                
            end
        end
    case 2
        fun=sym(input('Función: ','s'));
        tfinal=input('Tiempo final (seg): ');
        fs=input('Numero de muestras por segundo: ');
        time=0:1/fs:tfinal;
        time_L=length(time); %tiempo
        npuntos=pow2(nextpow2(time_L));
        fscale=(fs/2)*linspace(0,1,npuntos/2);
        data=subs(fun,time);
        FFT = abs(fft(data,npuntos)); %FFT
        FFT_abs_norm=abs(FFT)./(max(abs(FFT)));
        subplot(2,1,1)
        plot(fscale(1:round(time_L/2)),FFT_abs_norm(1:round(time_L/2)),'r');
        xlabel('Hz')
        title('Respuesta en Frecuencia Via Trans. Fourier')
        subplot(2,1,2)
        plot(time,data,'r');
        xlabel('seg')
        title('Respuesta en el tiempo')
        
    otherwise
        error('Opcion invalida');
  end
  opc=input('Desear salir?s/n: ','s');
  if opc=='s'
     flag_continuar=0;
  elseif opc=='n'
      flag_continuar=1;
  end
end



