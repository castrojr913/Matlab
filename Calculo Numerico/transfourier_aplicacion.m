function transfourier
    clear all
   
    % variables globales
    
     % -- REFERENCIAS A OBJETOS COMPONENTES DEL GUI --
     %Nota: GUI = Graphics User Interface. Interfaz de Usuario
    
    % FIGURE

    fig=figure('name','Espectro De Frecuencias','numbertitle','off',...
        'handlevisibility','callback','position',[200 100 700 500],...
        'resize','off','Toolbar','none','MenuBar','none',...
        'tag','fig',...
        'DefaultAxesColor',[0 1 1],...
        'Color',[0 0.8 0.3],...
        'closerequestfcn',@salir);
    
    % PANEL

     panel2=uipanel('parent',fig,'Position',[.765 0 .3 1],...            
                   'title','Controles','fontname','impact',...
                   'foregroundcolor','red',...
                   'shadowcolor',[0 1 0]);
                            
    %AXES
                  
    axes1=axes('parent',fig,'position',[0.1 0.1 0.6 0.78]);
    title(axes1,'Espectro de Señal de entrada')
    grid(axes1,'on')
   
    % EDIT
    
    edit1=uicontrol('parent',panel2,'style','edit','backgroundcolor',[1 1 1],...
                    'units','normalized','position',[0 .7 .8 .1]);
                
    edit2=uicontrol('parent',panel2,'style','edit','backgroundcolor',[1 1 1],...
                    'units','normalized','position',[0 .5 .8 .1]);  
                
    edit5=uicontrol('parent',panel2,'style','edit','backgroundcolor',[1 1 1],...
                    'units','normalized','position',[0 .26 .8 .1]);                           
                    
    % LABEL 
    
    lbl1=uicontrol('parent',panel2,'style','text','backgroundcolor',[1 0 .5],...
                   'units','normalized','position',[0 .6 .8 .05], ...
                   'String','Tiempo Adquisicion(s)','foregroundcolor',[1 1 1],...
                    'fontsize',12);
    lbl2=uicontrol('parent',panel2,'style','text','backgroundcolor',[1 0 .5],...
                   'units','normalized','position',[0 .8 .8 .05],...
                   'String','Función','foregroundcolor',[1 1 1],...
                    'fontsize',12);
    lbl3=uicontrol('parent',panel2,'style','text','backgroundcolor',[1 0 .5],...
                   'units','normalized','position',[0 .35 .8 .08],...
                   'String','Frecuencia de Muestreo (Hz)','foregroundcolor',[1 1 1],...
                   'fontsize',12);           
    
    % PUSHBUTTON
    
    push1=uicontrol(panel2,'Style','pushbutton','String','ok?',...
                     'Units','normalized', ...
                     'fontsize',12,'fontweight','bold',...
                     'foregroundcolor',[1 0 0],...
                     'backgroundcolor',[.8 .8 .9],...
                     'Position',[0 .15 .9 .08],...
                     'Callback',@calculo_fourier); 
                 
   % MENU E ITEMS DE CADA MENU
   
   menu1 = uimenu(fig,'Label','Archivos');
           uimenu(menu1,'Label','Salir','callback',@salir);
   menu2 = uimenu(fig,'Label','?');
           uimenu(menu2,'Label','Acerca de','callback',@about);

    % -- LLAMADAS A EVENTOS/EJECUCION DE RUTINAS (CALLBACKS) ---

    %CERRAR PROGRAMA
    function salir(hObject,eventdata)
        out = questdlg('salir?','Cerrar programa...','Si','No','Si');
        if strcmp(out,'No') %No? 
           return;          %regresar
        else
           delete(fig); %borrar handle de figura
        end
    end

% calcular la transformada de Fourier y graficarla
    function calculo_fourier(hObject,evendata)
      try  
        cla(axes1);
        set(push1,'String','Espere ...')
        pause(0.2)
        fun=sym(get(edit1,'string')); % pasar a sym para poder aplicar fourier
        fs=double(sym(get(edit5,'string'))); %muestreo
        tadq=double(sym(get(edit2,'string')));
        time=0:1/fs:tadq;
        time_L=length(time);
        p=subs(fun,time);
        % -- FFT: Transformada Rapida de Fourier ---
        n = pow2(nextpow2(length(p))); 
        fscale = (fs/2)*linspace(0,1,n/2); % Escala de f
        FFT=fft(p,n); %fft
        FFT_abs_norm=abs(FFT)./(max(abs(FFT)));
        % ---
        plot(axes1,fscale(1:round(time_L/2)),FFT_abs_norm(1:round(time_L/2)),'r');
        title(axes1,'Espectro de frecuencias de la funcion')
        xlabel('Hz');
        grid(axes1,'on')
        set(push1,'String','ok?')
      catch ME
          msgbox('Faltan datos por ingresar!','Error','error');
      end
    end

    % creditos 
    function about(hObject,evendata)
    
       str={'  Universidad Popular del Cesar',...
             '     Funciones Especiales',...
             '       Prof. Daniel Meza',...
             '               2010'};
       str1={' Ejemplo Trans. Fourier'};
       % caja de dialogo 
       out = helpdlg(str,'Acerca de');
       set(out,'position',[182.25 269.25 197.25 140])
       out1=uipanel('parent',out,'Title','Programa','titleposition',...
                     'centertop','backgroundcolor',[0.7 0.7 0.8],...
                     'foregroundcolor','b','fontsize',8,...
                     'position',[.07 .55 .85 .4],'shadowcolor',[0.7 0.7 0.6]);
            uicontrol('parent',out1,'style','text','string',str1,...
                       'units','centimeters','position',[0.8 0.3 4 1],...
                       'backgroundcolor',[0.7 0.7 0.8],...
                       'foreground','b');
    end
end
