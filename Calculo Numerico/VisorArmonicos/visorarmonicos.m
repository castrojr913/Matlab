function varargout = visorarmonicos(varargin)
% VISORARMONICOS M-file for visorarmonicos.fig
%      VISORARMONICOS, by itself, creates a new VISORARMONICOS or raises the existing
%      singleton*.
%
%      H = VISORARMONICOS returns the handle to a new VISORARMONICOS or the handle to
%      the existing singleton*.
%
%      VISORARMONICOS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VISORARMONICOS.M with the given input arguments.
%
%      VISORARMONICOS('Property','Value',...) creates a new VISORARMONICOS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before visorarmonicos_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to visorarmonicos_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help visorarmonicos

% Last Modified by GUIDE v2.5 04-Dec-2010 01:42:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @visorarmonicos_OpeningFcn, ...
                   'gui_OutputFcn',  @visorarmonicos_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before visorarmonicos is made visible.
function visorarmonicos_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to visorarmonicos (see VARARGIN)

% Choose default command line output for visorarmonicos
handles.output = hObject;

% --- DATOS DE INICIO ---
handles.var=sym('t'); %variable a usar t
handles.n=sym('n');
handles.intervalo=zeros(1,2);
if isunix %unix 
    handles.bckg1=imread(strcat(pwd,'/images/gradcolor3'),'jpg'); 
else % windows
    handles.bckg1=imread(strcat(pwd,'\images\gradcolor3'),'jpg');
end
image(handles.bckg1,'parent',handles.axes1)
axis(handles.axes1,'off');

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes visorarmonicos wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = visorarmonicos_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

cla(handles.axes3); %borrar contenido axes2
try
    % -- DATOS INGRESADOS EN LOS TEXTFIELDS --
    handles.fun=sym(get(handles.edit1,'string'));
    handles.intervalo(2)=double(sym(get(handles.edit2,'string')));
    handles.smax=double(sym(get(handles.edit3,'string')));
    handles.selected=double(sym(get(handles.edit4,'string')));
    set(handles.figure1,'name','visorarmonicos (Espere...)');
    % -----
    pause(0.2);%pausa de sincronizacion
    handles.cantidad=length(handles.fun); 
    handles.integral=struct('a0',sym(zeros(1,handles.cantidad)),...
                            'an',sym(zeros(1,handles.cantidad)),...
                            'bn',sym(zeros(1,handles.cantidad)));
   handles.long=(handles.intervalo(end)-handles.intervalo(1))/2;
   for c=1:handles.cantidad
      handles.integral.a0(c)=int(handles.fun(c),handles.var,...
                                 handles.intervalo(1,c),handles.intervalo(1,c+1));
      handles.integral.an(c)=int(handles.fun(c).*cos((handles.n*pi*handles.var)/handles.long),...
                                 handles.var,handles.intervalo(1,c),handles.intervalo(1,c+1));
      handles.integral.bn(c)=int(handles.fun(c).*sin((handles.n*pi*handles.var)/handles.long),handles.var,...
                                 handles.intervalo(1,c),handles.intervalo(1,c+1));
   end
 handles.a0=sum(handles.integral.a0)/(2*handles.long);
 handles.an=sum(handles.integral.an)/handles.long;
 handles.bn=sum(handles.integral.bn)/handles.long;
 handles.dn=simple(handles.an*cos(handles.n*pi*handles.var/handles.long)+...
            handles.bn*sin(handles.n*pi*handles.var/handles.long));
 %disp('Fourier Series:')
 %disp(handles.a0);
 %disp(handles.dn); %print symbolic expression 
 % % PROBLEMA: la función x(t) puede tener indeterminaciones finitas, es decir
 % % 0/0, forzando a crear un error de ejecución al graficar. Para resolverlo,
 % % usamos la regla de L'Hopital. Nota: las indeterminaciones infinitas, como
 % % también un número infinito de indeterminaciones finitas no pueden
 % % resolverse; x(t) tiene que cumplir las condiciones de Dirichlet.
 handles.flag=1;
 handles.test_n1=zeros(1,handles.smax);
 handles.test_v=sym(zeros(1,handles.smax));
 for c=1:handles.smax %Serie trigonometrica n=0:50 y Compleja n=-50:50
     handles.test_dn=double((subs(handles.dn,{handles.n,handles.var},{c,1})));
%        % Subs aveces no obtiene 0/0 sino (e/0), donde e es un valor muy
%        % tendiendo a cero (<10^-14), por limitaciones de MATLAB con el uso
%        % de la clase double. Esto genera un Inf en vez de un NaN.
     if isnan(handles.test_dn)==1 || isinf(handles.test_dn)==1%¿indeterminacion? 
         handles.test_n1(handles.flag)=c;%guardando valores n donde existan esos casos
         handles.flag=handles.flag+1;
     end
 end
 handles.test_n2=handles.flag-1; %Totales de n de los 50 donde existen indeterminaciones
 handles.test_n=zeros(1,handles.test_n2);
 for c=1:handles.test_n2
     handles.test_n(c)=handles.test_n1(c);
 end
  % % -- [Regla de L'Hopital] --
  handles.flag=1;
  for c=1:handles.test_n2
     if handles.flag==1
         handles.flag=0;% (re)iniciamos el proceso 
        [handles.num,handles.den]=numden(handles.dn);
    end   
    while handles.flag==0 % ahora calculamos el valor del límite
        handles.num=diff(handles.num,handles.n);%derivada num
        handles.den=diff(handles.den,handles.n);%derivada den
        handles.test_v(c)=subs(handles.num,{handles.n},{handles.test_n(c)})/subs(handles.den,{handles.n},{handles.test_n(c)});
        handles.test_v1=double(subs(handles.test_v(c),{handles.var},{1}));
        if isnan(handles.test_v1)==1 || isinf(handles.test_v1)==1
            handles.flag=0;% seguir derivando
        else
            handles.flag=1;% continuar con otro valor de n
        end
    end
 end
   % --- mostrar funciones a la cuales tiende la serie en casos de 0/0 ---
%  if handles.test_n2>0
%     for c=1:handles.test_n2
%         fprintf('For n=%i\n',handles.test_n(c))
%         disp(simple(handles.test_v(c)))
%     end
%  end
 %  *** [PLOT SECTION AND/OR OUTPUT ARGUMENT VALUE] ***
 handles.pasos=0.01;
 handles.chart=handles.intervalo(1):handles.pasos:handles.intervalo(end); %valores para intervalo
 % matriz de ceros para almacenar los valores de cada suma parcial
 % al ser evaluados con el intervalo.
 handles.vector=zeros(handles.smax,length(handles.chart)); 
 handles.alfa=zeros(1,length(handles.chart)); %creamos un vector zeros para acelerar
                                %velocidad de ejecución al momento de
                                %guardar datos en vector(v,:)
 % --- graficar las series y/o retornar valor de argumento de salida ---
 for v=1:handles.smax
    handles.beta=subs(handles.dn,handles.n,v);
    for c=1:handles.test_n2
        if handles.test_n(c)==v
            handles.beta=handles.test_v(c);
            break;
        end
    end
    handles.alfa=subs(handles.a0+handles.beta,{handles.var},{handles.chart}); 
    handles.vector(v,:)=handles.alfa; 
 end
 plot(handles.chart,handles.vector(handles.selected,:));
 set(handles.figure1,'name','visorarmonicos');
catch ME
   disp(ME.identifier);
   msgbox('Asigne los datos correctamente.','Error','error');
end


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
