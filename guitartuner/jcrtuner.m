%*** COMANDOS CLAVES USADOS ***
%1. clear all: limpiar memoria
%2. imread: Leer imagen a partir de un directorio
%3. pwd: mostrar directorio actual del fichero .m
%4. strcat: concatena dos strings
%5. uimenu: crear menus y submenus y sus propiedades
%6. uicontrol: crear etiquetas de texto, botones y popup-menus y sus 
%   propiedades. �ste puede usarse para crear m�s objetos.
%7. axes: crear ejes y sus propiedades
%8. figure: crear figura (ventana del GUI)
%9. Function: crear funci�n (necesario para ejecutar el GUI y los callbacks
%10. Global: definir variables globales (pueden usarse en todo el script,
%            incluyendo funciones)
%11. Set: modificar propiedades de objeto identificado por su handle.
%12. Get: consultar propiedades de objeto identificado por su handle.
%13. Continue: continuar en la siguiente iteracion
%14. Break: romper o salir del bucle.
%15. strcmp: comparar dos strings.
%16. dialog: mostrar o crear caja de dialogo personalizada.
%17. image: graficar imagen en el eje (axe) identificado por su handle.
%18. wavrecord: grabar audio del dispositivo de entrada en formato .wav a
%    una duracion y f. de muestreo deseada
%19. fft: transformada rapida de fourier de una secuencia con NFFT puntos
%20. varargin: vector de argumentos de entrada de una funcion.
%21. varargout: vector de argumentos de salida de una funcion.
%22. questdlg: caja de dialogo predefinida para preguntar al usuario.

% ESQUEMA DE AFINACI�N: E2-A2-D3-G3-B3-E4
% OCTAVAS: desde Db hasta C. La primera nota o la más grave del piano es la
% A0 con 27.5Hz Es decir:
% A0 Bb0 B0 C0 Db1 ... B1 C1 Db2 ... C2 Db3 ... C3 Db4 ... A4 ... 
%
% http://en.wikipedia.org/wiki/Guitar
                     
function jcrtuner(varargin)
    clear all       %limpiar la memoria
    %**** CODIGO DE INICIO ****
    
    % FRECUENCIA DE MUESTREO
    fs=11025;
    vrx1=round(fs/50); %fmin=50hz
    vrx2=round(fs/900);%fmax=900hz 
    % Muestreo: 44100Hz, codec 16 bits, 1 canal (mono)
    y0=audiorecorder(fs,16,1);      
    % NOTAS MUSICALES
    nota=zeros(1,88);
    nota2={'A','Bb','B','C','Db','D','Eb','E','F','Gb','G','Ab',...
           'A','Bb','B','C','Db','D','Eb','E','F','Gb','G','Ab',...
           'A','Bb','B','C','Db','D','Eb','E','F','Gb','G','Ab',...
           'A','Bb','B','C','Db','D','Eb','E','F','Gb','G','Ab',...
           'A','Bb','B','C','Db','D','Eb','E','F','Gb','G','Ab',...
           'A'};
    for i=48:-1:1 %frecuencias A440
        nota(1,49-i) = 440*2^(-i/12); %n=[-48,-1]
    end
    for i=0:39
        nota(1,i+49) = 440*2^(i/12);  %n=[0,39]
    end
    % frecuencias de notas de afinaci�n 
    nota3=[nota(1),nota(3), nota(6), nota(8), nota(11),...
          nota(13),nota(15),nota(18),nota(20),nota(23),...
          nota(25),nota(27),nota(30),nota(32),nota(35),...
          nota(37),nota(39),nota(42),nota(44),nota(47),...
          nota(49),nota(51),nota(54),nota(56),nota(59),...
          nota(61),nota(63)];

    % CARGAR IMAGENES
    if ispc
        back=imread(strcat(pwd,'\icons\guitar1'),'jpg');
    else
        back=imread(strcat(pwd,'/icons/guitar1'),'jpg');
    end
%     % STRINGS PARA EL INDICADOR INFERIOR
    str(1,:)={'','            A                    Bb'}; 
    str(2,:)={'','                     B                     C'};
    str(3,:)={'','                     Db                    D'};
    str(4,:)={'','                     Eb                    E'};
    str(5,:)={'','                     F                    Gb'};
    str(6,:)={'','                     G                    Ab'};
    str1='';
    str2(1,:)={'             |                       |'}; 
    str2(2,:)={'                       |                       |'};
    str2(3,:)={'                       |                       |'};
    str2(4,:)={'                       |                       |'};
    str2(5,:)={'                       |                       |'};
    str2(6,:)={'                       |                       |'};
    str3='';
    str4(1,:)={'         55.00              58.27',...
               '        110.00            116.54',...
               '        220.00            233.08',...
               '        440.00            466.16'}; 
    str4(2,:)={'               61.74              65.41',...
               '             123.47            130.81',...
               '             246.94            261.63',...
               '             493.88            523.25'};
    str4(3,:)={'                69.30              73.42',...
               '              138.59            146.83',...
               '              261.63            277.18',...
               '              523.25            554.37'};
    str4(4,:)={'               77.78              82.41',...
               '             155.56            164.81',...
               '             311.13            329.63',...
               '             622.25            659.26'};
    str4(5,:)={'               87.31              92.50',...
               '             174.61            185.00',...
               '             349.23            369.99',...
               '             698.46            739.99'};
    str4(6,:)={'               98.00             103.83',...
              '             196.00            207.65',...
              '             392.00            415.30',...
              '             783.99            830.61'};
    str5='';
    for i=1:2:5 % ciclo for para concatenar los strings anteriores
      d=strcat(str(i,:),str(i+1,:)); 
      str1=strcat(str1,d);
      d=strcat(str2(i,:),str2(i+1,:));
      str3=strcat(str3,d);
      d=strcat(str4(i,:),str4(i+1,:));
      str5=strcat(str5,d);
    end
  
    %**** DISE�O DE GRAPHICS USER INTERFACE (gui)*****
    
    % FIGURE
    fg = figure('name','JCRTuner','numbertitle','off',...
        'handlevisibility','callback','position',[80 80 900 530],...
        'resize','off','Toolbar','none','MenuBar','none',...
        'CloseRequestFcn',@exit_callback);
    get(fg,'children')
    % AXES
    ax=axes('parent',fg,'Position',[0 0 1 1]);
    image(back,'parent',ax) %Imagen de fondo
    axis(ax,'off') %Quitando ejes x-y
    ax_1=axes('parent',fg,'position',[0.04 0.40 0.32 0.388599],...
              'xcolor',[1 1 1],'ycolor',[1 1 1]);
     xlabel(ax_1,'Tiempo (s)','color',[1 1 1],'fontweight','bold')
    ax_2=axes('parent',fg,'position',[0.40 0.40 0.32 0.388599],...
              'xcolor',[1 1 1],'ycolor',[1 1 1]);
     xlabel(ax_2,'Frecuencia (Hz)','color',[1 1 1],'fontweight','bold')
         axes('parent',fg,'position',[0.015 0.177 0.985 0.05],...
              'ytick',[],'xtick',0:.008:1,'xgrid','off',...
              'linewidth',1,'xcolor',[0 0 0]);

    % MENUS - SUBMENUS 
    fg_mn = uimenu(fg,'Label','Archivo');
             uimenu(fg_mn,'Label','Salir','callback',@exit_callback);
    fg_mn2= uimenu(fg,'Label','?');
             uimenu(fg_mn2,'Label','Ayuda','callback',@help_callback);
   
    % BUTTONS
    fg_button=uicontrol(fg,'style','togglebutton','Units','normalized',...
                        'position',[0.75 0.35 0.12 0.055],...
                        'backgroundcolor',[0.5 0.5 0.7],...
                        'foregroundcolor',[0 1 0],...
                        'fontsize',12,'fontweight','bold',...
                        'String','Capturar','fontsize',10,...
                        'callback',@button_callback);
 
   % TEXT LABELS       
           uicontrol(fg,'Style','text','String','Funci�n f(t)',...
                     'Units','normalized','HorizontalAlignment','center',...
                     'fontsize',12,'fontweight','bold',...
                     'foregroundcolor',[0 0 1],...
                     'backgroundcolor',[0.6 0.6 0.9],...
                     'Position',[0.06 0.81 0.264659 0.035]); 
                 
           uicontrol(fg,'Style','text','String','Espectro H(f)',...
                     'Units','normalized','HorizontalAlignment','center',...
                     'fontsize',12,'fontweight','bold',...
                     'foregroundcolor',[0 0 1],...
                     'backgroundcolor',[0.6 0.6 0.9],...
                     'Position',[0.42 0.81 0.264659 0.035]);       
             
           uicontrol(fg,'Style','text','String','Frecuencia',...
                     'Units','normalized','HorizontalAlignment','center',...
                     'fontsize',12,'fontweight','bold',...
                     'foregroundcolor',[0 0 1],...
                     'backgroundcolor',[0.6 0.6 0.9],...
                     'Position',[0.74 0.82 0.134659 0.035]);
           
           uicontrol(fg,'Style','text','String','Nota',...
                     'Units','normalized','HorizontalAlignment','center',...
                     'fontsize',12,'fontweight','bold',...
                     'foregroundcolor',[0 0 1],...
                     'backgroundcolor',[0.6 0.6 0.9],...
                     'Position',[0.74 0.66 0.134659 0.035]);      
               
    fg_txt1 = uicontrol(fg,'Style','text','Units','normalized',...
                     'backgroundcolor',[1 1 1],...
                     'Position',[0.74 0.72 0.134659 0.08]);
                 
    fg_txt2 = uicontrol(fg,'Style','text','Units','normalized',...
                     'backgroundcolor',[1 1 1],...
                     'Position',[0.74 0.55 0.134659 0.08]);
                 %String de nota
    fg_txt4 = uicontrol(fg,'Style','text','Units','normalized',...
                     'backgroundcolor',[1 1 1],...
                     'Position',[0.74 0.45 0.134659 0.08]);  
     
           uicontrol(fg,'Style','text','Units','normalized',...
                     'backgroundcolor',[0.4 0.5 0.4],...
                     'HorizontalAlignment','left',...
                     'Position',[0.01 0.22 1 0.05],...
                     'string',str1); 
                 
           uicontrol(fg,'Style','text','Units','normalized',...
                     'HorizontalAlignment','left',...
                     'backgroundcolor',[0.4 0.5 0.4],...
                     'Position',[0.01 0.15 1 0.025],...
                     'string',str3); 
                 
           uicontrol(fg,'Style','text','Units','normalized',...
                     'HorizontalAlignment','left',...
                     'backgroundcolor',[0.4 0.5 0.4],...
                     'Position',[0.96 0 1 0.220]);
                 
           uicontrol(fg,'Style','text','Units','normalized',...
                     'HorizontalAlignment','left',...
                     'backgroundcolor',[0.4 0.5 0.4],...
                     'Position',[0 0 0.015 0.270]);      
                 
           uicontrol(fg,'Style','text','Units','normalized',...
                     'HorizontalAlignment','left',...
                     'backgroundcolor',[0.4 0.5 0.4],...
                     'Position',[0.01 0 1 0.150],...
                     'string',str5);
                 
    fg_txt3 = uicontrol(fg,'Style','text','Units','normalized',...
                     'HorizontalAlignment','left',...
                     'backgroundcolor',[0.4 0.5 0.4],...
                     'foregroundcolor',[1 1 1],...
                     'fontsize',10,...
                     'Position',[0.004 0.198 0.022 0.020],...
                     'string','  |');      
                 
    fg_txt5 = uipanel(fg,'units','normalized','title','<',...
                  'titleposition','centertop',...
                  'foregroundcolor',[0 0 1],...
                  'backgroundcolor',[0.8 0.8 0.8],...
                  'Position',[0.76 0.87 0.03 0.05]);   
    fg_txt6 = uipanel(fg,'units','normalized','title','|',...
                  'titleposition','centertop',...
                  'foregroundcolor',[0 0 1],...
                  'backgroundcolor',[0.8 0.8 0.8],...
                  'Position',[0.795 0.87 0.03 0.05]);             
    fg_txt7 = uipanel(fg,'units','normalized','title','>',...
                  'foregroundcolor',[0 0 1],...
                  'titleposition','centertop',...  
                  'backgroundcolor',[0.8 0.8 0.8],...
                  'Position',[0.83 0.87 0.03 0.05]); 
                    
    % ***** CALLBACK (RUTINA DE EVENTOS) ****
    function button_callback(hObject,eventdata)
           if get(fg_button,'Value')==1
              set(fg_button,'String','Parar','Units','normalized',...
                  'foregroundcolor',[1 0 0],...
                  'fontsize',12,'fontweight','bold')
              c=0; %blink
              d=0; %tiempo blink
           else
              set(fg_button,'String','Capturar','Units','normalized',...
                  'foregroundcolor',[0 1 0],...
                  'fontsize',12,'fontweight','bold')
              set(ax_1,'Color',[0.95 0.95 0.95]) 
              set(ax_2,'Color',[0.93 0.93 0.93])
           end      
           while get(fg_button,'Value') %el sensado es continuo (0.4s)
               
          %     ADQUISICI�N DE LA SE�AL
          recordblocking(y0,0.2);
    stop(y0)
    y2=getaudiodata(y0,'double');
                %y2=wavrecord(0.2*fs,fs);
                L=length(y2);   %tama�o de las muestras
                t=(0:L-1)*1/fs; %tiempo transcurrido durante la grabaci�n
                
            %   [ fft de la se�al de la cuerda de la guitarra ] 
%            % [Rango de f del espectro: Usamos fs/2 y NFFT/2 para  
%            % el espectro de una sola banda lateral]
                n = 2^(nextpow2(L));  % n puntos para la fft
                Y = fft(y2,n);          % FFT con n puntos
                f = (0:n-1)*(fs/n);     % Rango de frecuencias
             % [usamos la tecnica de autocorrelaci�n]
             % Aunque existen otros metodos como: analisis cepstral y
             % estimaci�n de frecuencias formantes.
                xr=xcorr(y2,vrx1,'coeff');    % autocorrelaci�n  
                xr1=xr((vrx1+1):1:(2*vrx1+1));% Solo banda positiva
                [xrm,txr]=max(xr1(vrx2:vrx1)); 
                resul=fs/(vrx2+txr-1);     % f. fundamental
         %  CALCULO DE FRECUENCIA DE LA SE�AL DE ENTRADA
%
                pause(0.2)% necesario para las graficas se sincronicen
                          % con los calculos sino no se muestran.
                
        % COMPARACI�N ENTRE LA FRECUENCIA CALCULADA Y LA DE REFERENCIA 
                if ~(resul<53.455) && max(abs(Y))>1 
                                     %reducir se�ales indeseadas. 
                                     %si es > f0, la diferencia de f>f0 
                                     %Conclusion: muy probablemente la 
                                     %se�al provenga de la guitarra
                   plot(ax_1,t,y2)                 %graficar f(t)  
                   set(ax_1,'xcolor',[1 1 1],'ycolor',[1 1 1])
                   xlabel(ax_1,'Tiempo (s)','color',[1 1 1],'fontweight','bold')
                   
                   plot(ax_2,f(1:1500),abs(Y(1:1500)))   %graficar H(f)
                   set(ax_2,'xcolor',[1 1 1],'ycolor',[1 1 1])
                   xlabel(ax_2,'Frecuencia (hz)','color',[1 1 1],'fontweight','bold')
                   
                   %[mostrar frecuencia actual: redondeo a 2 cifras
                   %decimales y conversi�n a string]
                   set(fg_txt1,'string',num2str(roundn(resul,-2)),...
                       'fontname','OCR A Extended','fontsize',15,...
                       'foregroundcolor',[1 0 0],'fontweight','bold')
                   c=0; 
                   d=0; %reiniciar conteo blink
                   
                   %[control del indicador y mostrar en text label]     
                   if resul>849.92 %si hay frecuencias mayores al l�mite
                                   %830.61+4*(880-830.61)/10
                      set(fg_txt2,'string','-of-',...
                         'fontname','OCR A Extended','fontsize',15,...
                         'foregroundcolor',[1 0 0],'fontweight','bold')   
                      set(fg_txt4,'string','-of-',...
                         'fontname','OCR A Extended','fontsize',15,...
                         'foregroundcolor',[1 0 0],'fontweight','bold')
                      set(fg_txt3,'position',[0.951 0.198 0.022 0.020])
                      set(ax_1,'Color',[1 1 1])
                      set(ax_2,'Color',[1 1 1])
                   else
                       for i=12:61 %++ notas A1 hasta Ab5 ++
                              set(ax_1,'Color',[1 1 1])
                              set(ax_2,'Color',[1 1 1]) 
                            %[determinar en qu� banda de f, est� nuestra f
                            %actual]
                              if resul>nota(i) 
                                   continue;
                              else
                   %[Para el indicador, se usa la ecuaci�n de
                   %la recta para  posicionar en el axe, el text label 
                   %txt3 en la banda correcta. 
                   %{Nota: frecuencia vs unidades normalizadas}
                   %            *** bandas extremas ***
                   %1 banda : 53.455   55   -  0.004   0.044   0.040
                   %13 banda: 103.86  106.93-  0.911   0.951   0.040
                   %           *** bandas intermedias *** 
                   %2 banda: 55      58.27 -  0.044   0.122     0.078
                   %3 banda: 58.27   61.74 -  0.122   0.202     0.080
                   %4 banda: 61.74   65.41 -  0.202   0.281     0.079
                   %5 banda: 65.41   69.30 -  0.281   0.359     0.078 
                   %6 banda: 69.30   73.42 -  0.359   0.438     0.079
                   %7 banda: 73.42   77.78 -  0.438   0.517     0.079
                   %8 banda: 77.78   82.41 -  0.517   0.596     0.079
                   %9 banda: 82.41   87.31 -  0.596   0.674     0.078
                   %10 banda:87.31   92.50 -  0.674   0.753     0.079
                   %11 banda:92.50   98.00 -  0.753   0.832     0.079
                   %12 banda:98.00   103.86-  0.832   0.911     0.079]
%                                 for k=1:12 %12:51.9 - 61:880
%                                   % [determinar si la frecuencia est� en
%                                   % una banda que est� una o n octavas por
%                                   % encima de la banda de base]
%                                      if mod(nota(i),nota(k+12))==0
%                                         %Nota base redondeada a 2 c.d
%                                         mult=roundn(nota(1,k+12),-2);          
%                                      end
%                                  end
%                                  %[Lo siguiente es �til
%                                  %para los calculos venideros]
%                                  dif=nota(i)-nota(i-1);
%                                  mitad=nota(i)-dif/2;
%                                  dif1=mitad-nota(i-1);
%                                  dif2=nota(i)-mitad;
%                                  switch mult
%                                      % [casos bandas Extremas]
%                                      case 55.00
%                                         if resul<mitad
%                                            pend=0.040/dif1;
%                                            u=pend*(resul-nota(i-1))+0.911; 
%                                            set(fg_txt3,'position',[u 0.198 0.022 0.020])
%                                         else    
%                                           %[Pendiente y Ec.Recta]  
%                                            pend=0.040/dif2; %pendiente
%                                            u=pend*(resul-mitad)+0.004; 
%                                           % Establecer posici�n 
%                                            set(fg_txt3,'position',[u 0.198 0.022 0.020])
%                                         end
%                                      case 58.27
%                                        % [casos bandas intermedias]
%                                         pend=0.078/dif; 
%                                         u=pend*(resul-nota(i-1))+0.044; 
%                                         set(fg_txt3,'position',[u 0.198 0.022 0.020]) 
%                                      case 61.74
%                                         pend=0.080/dif;
%                                         u=pend*(resul-nota(i-1))+0.122; 
%                                         set(fg_txt3,'position',[u 0.198 0.022 0.020])
%                                      case 65.41
%                                         pend=0.079/dif;
%                                         u=pend*(resul-nota(i-1))+0.202; 
%                                         set(fg_txt3,'position',[u 0.198 0.022 0.020])
%                                      case 69.30
%                                         pend=0.078/dif;
%                                         u=pend*(resul-nota(i-1))+0.281; 
%                                         set(fg_txt3,'position',[u 0.198 0.022 0.020])
%                                      case 73.42
%                                         pend=0.079/dif;
%                                         u=pend*(resul-nota(i-1))+0.359; 
%                                         set(fg_txt3,'position',[u 0.198 0.022 0.020])
%                                      case 77.78
%                                         pend=0.079/dif;
%                                         u=pend*(resul-nota(i-1))+0.438; 
%                                         set(fg_txt3,'position',[u 0.198 0.022 0.020]) 
%                                      case 82.41
%                                         pend=0.079/dif;
%                                         u=pend*(resul-nota(i-1))+0.517; 
%                                         set(fg_txt3,'position',[u 0.198 0.022 0.020])
%                                      case 87.31
%                                         pend=0.078/dif;
%                                         u=pend*(resul-nota(i-1))+0.596; 
%                                         set(fg_txt3,'position',[u 0.198 0.022 0.020])
%                                      case 92.50
%                                         pend=0.079/dif;
%                                         u=pend*(resul-nota(i-1))+0.674; 
%                                         set(fg_txt3,'position',[u 0.198 0.022 0.020])
%                                      case 98.00
%                                         pend=0.079/dif;
%                                         u=pend*(resul-nota(i-1))+0.753; 
%                                         set(fg_txt3,'position',[u 0.198 0.022 0.020])
%                                      case 103.86
%                                         pend=0.079/dif;
%                                         u=pend*(resul-nota(i-1))+0.832; 
%                                         set(fg_txt3,'position',[u 0.198 0.022 0.020])   
%                                  end
                               % [Determinar cu�l es la nota m�s cercana a 
                               % la f actual y mostrarla en text label]
                                 dif1=nota(i)-resul;
                                 dif2=resul-nota(i-1);
                               % calcular la nota de afinaci�n m�s cercana 
                                 [min1,min2]=min(abs(resul-nota3)); %k2
                                 
                               % [rango de tolerancia, para la nota actual
                               % respecto con la de afinaci�n: 3%]
                                
                                if  resul<1.03*nota3(min2) && resul>0.97*nota3(min2)
                                    l=1; %dentro del rango
                                else
                                    l=0; %fuera del rango
                                end

                                %[Contrastar nota afinacion con nota
                                 %actual]
                                      
                                if nota3(min2)>resul
                                       switch l    %semitono up
                                          case 0 
                                             set(fg_txt5,'backgroundcolor',[0.8 0.8 0.8]) 
                                             set(fg_txt6, 'backgroundcolor',[0.8 0.8 0.8])
                                             set(fg_txt7, 'backgroundcolor',[1 0 0])

                                          case 1
                                             set(fg_txt5,'backgroundcolor',[0.8 0.8 0.8]) 
                                             set(fg_txt6, 'backgroundcolor',[0 1 0])
                                             set(fg_txt7, 'backgroundcolor',[1 0 0])
                                       end
                                elseif nota3(min2)<resul
                                         switch l    %semitono down
                                           case 0 
                                             set(fg_txt5,'backgroundcolor',[1 0 0]) 
                                             set(fg_txt6, 'backgroundcolor',[0.8 0.8 0.8])
                                             set(fg_txt7, 'backgroundcolor',[0.8 0.8 0.8])

                                           case 1
                                             set(fg_txt5,'backgroundcolor',[1 0 0]) 
                                             set(fg_txt6, 'backgroundcolor',[0 1 0])
                                             set(fg_txt7, 'backgroundcolor',[0.8 0.8 0.8])
                                         end
                                else  %son iguales
                                        set(fg_txt5,'backgroundcolor',[0.8 0.8 0.8]) 
                                        set(fg_txt6, 'backgroundcolor',[0 1 0])
                                        set(fg_txt7, 'backgroundcolor',[0.8 0.8 0.8])
                                end
                                    
                                 if dif1>dif2
                                     % [mostrar notas en el GUI] 
                                    set(fg_txt2,'string',num2str(roundn(nota(i-1),-2)),...
                                        'fontname','OCR A Extended','fontsize',15,...
                                        'foregroundcolor',[1 0 0],'fontweight','bold')
                                    
                                    set(fg_txt4,'string',nota2(i-1),...
                                        'fontname','OCR A Extended','fontsize',15,...
                                        'foregroundcolor',[1 0 0],'fontweight','bold')
                                 else
                                    set(fg_txt2,'string',num2str(roundn(nota(i),-2)),...
                                        'fontname','OCR A Extended','fontsize',15,...
                                        'foregroundcolor',[1 0 0],'fontweight','bold') 
                                    
                                    set(fg_txt4,'string',nota2(i),...
                                        'fontname','OCR A Extended','fontsize',15,...
                                        'foregroundcolor',[1 0 0],'fontweight','bold')
                                 end
                              end
                              break;%Nota calculada con �xito. Ahora salga
                       end          %del bucle for.
                    end
                else % no se cumplieron con los requisitos m�nimos
                    
                    if c==0 && d==10 % efecto de blink: pidiendo datos ...
                         set(ax_1,'Color',[0.6 0.8 0.6])
                         set(ax_2,'Color',[0.6 0.8 0.6])
                         c=1;
                    elseif d==10
                         set(ax_1,'Color',[1 1 1])
                         set(ax_2,'Color',[1 1 1])
                         c=0;
                    end
                    if d~=10 %contador de tiempo, sino se ha recibido datos
                       d=d+1;%t_ciclo_while=0.4s =>t=4s aprox.
                    end
                    set(fg_txt5, 'backgroundcolor',[0.8 0.8 0.8])
                    set(fg_txt6, 'backgroundcolor',[0.8 0.8 0.8]) 
                    set(fg_txt7, 'backgroundcolor',[0.8 0.8 0.8])
                    set(fg_txt1,'string','***',...
                        'fontname','OCR A Extended','fontsize',16,...
                        'foregroundcolor',[0 0 1],'fontweight','bold')
                    set(fg_txt2,'string','***',...
                        'fontname','OCR A Extended','fontsize',16,...
                        'foregroundcolor',[0 0 1],'fontweight','bold')
                    set(fg_txt4,'string','***',...
                        'fontname','OCR A Extended','fontsize',16,...
                        'foregroundcolor',[0 0 1],'fontweight','bold')
                    plot(ax_1,t,zeros(1,length(t)))  
                    set(ax_1,'xcolor',[1 1 1],'ycolor',[1 1 1],...
                        'color',[1 1 1])
                    xlabel(ax_1,'Tiempo (s)','color',[1 1 1],'fontweight','bold')
                    plot(ax_2,f,zeros(1,length(f)))  
                    set(ax_2,'xcolor',[1 1 1],'ycolor',[1 1 1],...
                        'color',[1 1 1])
                    xlabel(ax_2,'Frecuencia (hz)','color',[1 1 1],'fontweight','bold')
                end
           end
        end
   
    function help_callback(hObject,eventdata)
        str0={' ','** AYUDA **'};
        str1={'1. Hacer clic en el bot�n "Capturar", para comenzar';...
              'a grabar.';...
              '2. Durante la grabaci�n, si no ha introducido se�al,';...
              'se mostrar� un efecto de blinking indicando la misma.';...
              '3. Con Frecuencia y Nota, puede observar la frecuencia';...
              'actual y su nota m�sical m�s cercana. ';...
              '4. Con las gr�ficas, puede observar la se�al en el tiempo';...
              'y en la frecuencia.';...
              '5. El programa trabaja desde las notas 55Hz (A1) hasta';...
              '830.61Hz (Ab5)';...
              '6. Si la frecuencia grabada es mayor al l�mite m�ximo que';...
              'soporta el programa (849.92Hz), mostrar� -of- (overflow)';...
              '7. Para detener captura, hacer clic en el bot�n, esta';...
              'vez, con la palabra "Parar".';...
              '8. Para salir del programa, hacer clic en "Archivo"';...
              'Luego, hacer clic en "Salir"'}; 
          % Mostrar dialogbox
        out = dialog('WindowStyle', 'normal', 'Name', 'Manual de Ayuda',...
                     'position',[182.25 269.25 300 350], ...
                     'color',[1 1 1]);
              uicontrol('parent',out,'style','text','string',str0,...
                      'foreground','b','fontsize',12,'fontweight','bold',...
                      'backgroundcolor',[1 1 1],'position',[20 310 250 50]);
              uicontrol('parent',out,'style','text','string',str1,...
                       'position',[10 60 280 250],...
                       'backgroundcolor',[1 1 1],...    
                       'foreground',[0.1 0.6 0.2],...
                      'HorizontalAlignment','left'); 
    end

    function exit_callback(hObject,eventdata)
        out = questdlg('�Desea salir?','�Precauci�n!','S�','No','S�');
        if strcmp(out,'No') %�No? 
           return;          %retornar
        else
           delete(fg)       %Cerrar programa: borrar handle de figure
        end   
    end
end