function varargout = EcuacionDeCalor(varargin)
% ECUACIONDECALOR M-file for EcuacionDeCalor.fig
%      ECUACIONDECALOR, by itself, creates a new ECUACIONDECALOR or raises the existing
%      singleton*.
%
%      H = ECUACIONDECALOR returns the handle to a new ECUACIONDECALOR or the handle to
%      the existing singleton*.
%
%      ECUACIONDECALOR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ECUACIONDECALOR.M with the given input arguments.
%
%      ECUACIONDECALOR('Property','Value',...) creates a new ECUACIONDECALOR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before EcuacionDeCalor_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to EcuacionDeCalor_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help EcuacionDeCalor

% Last Modified by GUIDE v2.5 05-Dec-2010 18:12:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @EcuacionDeCalor_OpeningFcn, ...
                   'gui_OutputFcn',  @EcuacionDeCalor_OutputFcn, ...
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


% --- Executes just before EcuacionDeCalor is made visible.
function EcuacionDeCalor_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to EcuacionDeCalor (see VARARGIN)

% Choose default command line output for EcuacionDeCalor
handles.output = hObject;

% --- DATOS DE INICIO ---
handles.var=sym('x'); %variable a usar x
handles.t=sym('t');
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

% UIWAIT makes EcuacionDeCalor wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = EcuacionDeCalor_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;




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


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pdetool % abrir pdftool para graficos


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%try
  handles.fun=sym(get(handles.edit3,'string'));
  handles.alfa=double(sym(get(handles.edit1,'string'))); 
  handles.long=double(sym(get(handles.edit2,'string'))); 
  % *** RESOLUCION DE LA ECUACION DE CALOR CON LAS CONDICIONES DE 
  % FRONTERA ***
  %
  % d(du/dt)-div(c*grad(u)) + a*u = f
  % En realidad se toma la forma sencilla: a=f=0,d=1,
  % Debemos calcular c apartir de alpha.
  %
  % Pasos al ingresar pdetool
  % 1. Ingresar al Options, luego escoger Axis Limits: definir los 
  %    intervalo del Eje x.
  % 2. Ingresar Draw Mode: hacer clic en el icono cuadrado y dibujar
  %    a la longitud L en x.
  % 3. Ingresar Boundary Mode: hacer clic en las fronteras en la de arriba
  %    y abajo, escoger Criterio de Newman g=q=0. Luego en la izquierda y
  %    derecha los valores de frontera U(0,t)=U(L,t)=0 en la Criterio de
  %    de Dirichlet donde r=0,h=1.
  % 4. Ingresar PDE mode, escoger parabolico y dar los valores:
  %    c,a=f=0,d=1
  % 5. Ingresar a Solve, parametres: en u(x,0) ingresar funcion f(x)
  % 6. Luego hacer clic en solve PDE.
  % 7. Ir a Plot, parametres, escoger opcion 3D, y valor abs(u) y luego
  %    presionar plot
  %
  %
  % Ut=alpha^2*Uxx  <--> U(0,t)=0, U(L,t)=0 , U(x,0)=f(x)
  % donde 0<x<L y t>0
  %
  handles.cantidad=length(handles.fun);
  handles.integral=struct('an',sym(zeros(1,handles.cantidad)));
  %handles.long=(handles.intervalo(end)-handles.intervalo(1))/2;
  for c=1:handles.cantidad
%       handles.integral.a0(c)=int(handles.fun(c),handles.var,...
%                                  handles.intervalo(1,c),handles.intervalo(1,c+1));
      handles.integral.an(c)=int(handles.fun(c).*cos((handles.n*pi*handles.var)/handles.long),...
                                 handles.var,0,handles.long);
%       handles.integral.bn(c)=int(handles.fun(c).*sin((handles.n*pi*handles.var)/handles.long),handles.var,...
%                                  handles.intervalo(1,c),handles.intervalo(1,c+1));
  end
  %handles.a0=sum(handles.integral.a0)/(2*handles.long);
  handles.an=2*sum(handles.integral.an)/handles.long;
  %handles.bn=sum(handles.integral.bn)/handles.long;
  handles.dn=handles.an*exp(-(pi^2*handles.n^2*handles.alfa^2)*handles.t/handles.long^2)*...
             cos(handles.n*pi*handles.var/handles.long);
  disp('Sumatoria de n=0 hasta inf');
  disp(handles.dn);
% catch ME
%    errordlg('Datos invalidos o faltantes!','Error','error'); 
% end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
 out = questdlg('salir?','Cerrar programa...','Si','No','Si');
        if strcmp(out,'No') %No? 
           return;          %regresar
        else
           delete(hObject); %borrar handle de figura
        end

