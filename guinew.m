% Ayush Aggarwal
%11177
% to change spectral file acccording to image wavelength values and other
% functions like plotting etc.
% 27/3/2015



function varargout = guinew(varargin)
% GUINEW MATLAB code for guinew.fig
%      GUINEW, by itself, creates a new GUINEW or raises the existing
%      singleton*.
%
%      H = GUINEW returns the handle to a new GUINEW or the handle to
%      the existing singleton*.
%
%      GUINEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUINEW.M with the given input arguments.
%
%      GUINEW('Property','Value',...) creates a new GUINEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before guinew_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to guinew_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help guinew

% Last Modified by GUIDE v2.5 27-Mar-2015 02:22:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @guinew_OpeningFcn, ...
                   'gui_OutputFcn',  @guinew_OutputFcn, ...
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


% --- Executes just before guinew is made visible.
function guinew_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to guinew (see VARARGIN)

% Choose default command line output for guinew
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes guinew wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = guinew_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



    




% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    [fileName,pathName] = uigetfile('*.asc','Select Spectral File'); % to browse file of ascci format 
    fullpathname = strcat(pathName,fileName);
    set(handles.text1,'string',fullpathname);
    str_part ='Spectral file Loaded';              % for showing what happening
    old_str = get(handles.listbox1,'String');
    new_str = strvcat(old_str, str_part);
    set(handles.listbox1,'string',new_str );
    data = dlmread(fullpathname,'',17,0);           % to read data from where we want in asccii file
    specwave = data(:,1);
    specvalue = data(:,2);
    axes(handles.axes1);
    plot(specwave, specvalue, '+b')                 % make spectral profile curve
    set(gca, 'XLim', [min(specwave) max(specwave)], 'YLim', [min(specvalue) max(specvalue )])
    axis square
    xlabel('wavelength in micrometer')
    ylabel('spectral value')
    title('Spectral Signature')
    handles.data=data;
    guidata(hObject,handles);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    [fileName,pathName] = uigetfile('*.tif','Select Image File'); % to browse file
    fullpathname = strcat(pathName,fileName);
    set(handles.text2,'string',fullpathname);
    str_part ='Image file Loaded';
    old_str = get(handles.listbox1,'String');
    new_str = strvcat(old_str, str_part);
    set(handles.listbox1,'string',new_str );
    image1 = imread(fullpathname);
    image = im2uint8(image1);                       %To see true color of the image
    imagetrue(:,:,1) = image(:,:,11);
    imagetrue(:,:,2) = image(:,:,21);
    imagetrue(:,:,3) = image(:,:,29);
    axes(handles.axes3);
    imshow(imagetrue);                              % To show image on axis
    handles.image1=image1;
    guidata(hObject,handles);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc; % clear command window
delete(handles.figure1);            


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
datan = zeros(234,2);
data = handles.data;
m = 5;
for k = 1:234                          % THIS IS MADE TO FIND WAVELENGTH WHICH IS IN HYPERSPECTRAL IMAGE IT TAKES THAT SPECTRAL VALUE OF WAVELENGTH 
                                        % i MADE THIS BY READING THE my
                                        % HYPERSPECTRAL IMAGE FORMAT
    datan(k,1) = data(m,1);
    datan(k,2) = data(m,2);
    m = m + 9;
end
dlmwrite('newspec.txt',datan,'delimiter','\t','precision',3)
    axes(handles.axes1);
    specwave = data(:,1);
    specvalue = data(:,2);
    plot(specwave, specvalue, '+b')
    hold on
    plot(datan(:,1), datan(:,2), 'g+')        % IT PLOTS USEFUL SPECTRAL VALUE ON GRAPH
    set(gca, 'XLim', [min(specwave) max(specwave)], 'YLim', [min(specvalue) max(specvalue)])
    axis square
    xlabel('wavelength in micrometer')
    ylabel('spectral value')
    title('Spectral Signature')
    str_part ='Converted Spectral file';
    old_str = get(handles.listbox1,'String');
    new_str = strvcat(old_str, str_part);
    set(handles.listbox1,'string',new_str );
    str_part ='Download new Spectral file';
    old_str = get(handles.listbox1,'String');
    new_str = strvcat(old_str, str_part);
    set(handles.listbox1,'string',new_str );
    


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
image1 = handles.image1;

i = round(handles.edit1);       % To get the pixel value define in text
j = round(handles.edit2);

k = 1;
for k = 1:234
    readspectra(k,1) = image1(i,j,k);           % THIS IS DONE TO SHOW SPECTRAL VALUE OF A PIXEL IN A IMAGE IN ALL BANDS
    k = k + 1;
end

datan = zeros(234,2);          % helps in making plot of above as want spectral wavelength of each band of image
data = handles.data;
m = 5;
k = 1;
for k = 1:234     
    datan(k,1) = data(m,1);
    datan(k,2) = data(m,2);
    m = m + 9;
end
    
    axes(handles.axes2);
    plot(datan(:,1), readspectra(:,1), 'y+')    
    %set(gca, 'XLim', [min(specwave) max(specwave)+0.05], 'YLim', [min(specvalue) max(specvalue)+0.005])
    axis square
    xlabel('wavelength in micrometer')
    ylabel('spectral value')
    title('Spectral image value')
    str_part ='showed Image spectral value';
    old_str = get(handles.listbox1,'String');
    new_str = strvcat(old_str, str_part);
    set(handles.listbox1,'string',new_str );



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
