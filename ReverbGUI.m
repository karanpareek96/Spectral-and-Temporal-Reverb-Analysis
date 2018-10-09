%       Name: Karan Pareek
%       Student ID: kp2218
% |------------------Click 'Run' to access the GUI!-----------------------|
% This GUI script runs the reverberation module by executing the various
% reverb functions. Further, the user can choose the module and type of
% reverb in addition to the reverberation mix, gain and spread.
% Note: Jump to line 176 to view the 'Reverberation' callback funtion.

function varargout = ReverbGUI(varargin)
% REVERBGUI MATLAB code for ReverbGUI.fig
%      REVERBGUI, by itself, creates a new REVERBGUI or raises the existing
%      singleton*.
%
%      H = REVERBGUI returns the handle to a new REVERBGUI or the handle to
%      the existing singleton*.
%
%      REVERBGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in REVERBGUI.M with the given input arguments.
%
%      REVERBGUI('Property','Value',...) creates a new REVERBGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ReverbGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ReverbGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ReverbGUI

% Last Modified by GUIDE v2.5 06-Aug-2018 22:39:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ReverbGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @ReverbGUI_OutputFcn, ...
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


% --- Executes just before ReverbGUI is made visible.
function ReverbGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ReverbGUI (see VARARGIN)

% Choose default command line output for ReverbGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ReverbGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ReverbGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in revModule.
function revModule_Callback(hObject, eventdata, handles)
% hObject    handle to revModule (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns revModule contents as cell array
%        contents{get(hObject,'Value')} returns selected item from revModule


% --- Executes during object creation, after setting all properties.
function revModule_CreateFcn(hObject, eventdata, handles)
% hObject    handle to revModule (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in typeRev.
function typeRev_Callback(hObject, eventdata, handles)
% hObject    handle to typeRev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns typeRev contents as cell array
%        contents{get(hObject,'Value')} returns selected item from typeRev


% --- Executes during object creation, after setting all properties.
function typeRev_CreateFcn(hObject, eventdata, handles)
% hObject    handle to typeRev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inputFile_Callback(hObject, eventdata, handles)
% hObject    handle to inputFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inputFile as text
%        str2double(get(hObject,'String')) returns contents of inputFile as a double


% --- Executes during object creation, after setting all properties.
function inputFile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inputFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function outputFile_Callback(hObject, eventdata, handles)
% hObject    handle to outputFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of outputFile as text
%        str2double(get(hObject,'String')) returns contents of outputFile as a double


% --- Executes during object creation, after setting all properties.
function outputFile_CreateFcn(hObject, eventdata, handles)
% hObject    handle to outputFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in reverberate.
function reverberate_Callback(hObject, eventdata, handles)
% hObject    handle to reverberate (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Extracting the various paramters from the GUI objects
inputFilename = get(handles.inputFile,'String');
outputFilename = get(handles.outputFile,'String');

param01 = cellstr(get(handles.revModule,'String'));
reverbModule = param01{get(handles.revModule,'Value')};

param02 = cellstr(get(handles.typeRev,'String'));
revType = param02{get(handles.typeRev,'Value')};

param03 = cellstr(get(handles.roomSize,'String'));
revSize = param03{get(handles.roomSize,'Value')};

% Setting the Dry-Wet conditions
revGain = get(handles.dryWet,'Value');
if revGain == 0
    revGain = 0.01;
elseif revGain == 1
    revGain = 0.99;
end

% Obtaining the value of spread from the slider
revSpread = get(handles.spreadRev,'Value');

% Reverberation Functions
if strcmp(reverbModule,'Freeverb')
    y = Freeverb(inputFilename,revType,revGain,revSize,revSpread);
elseif strcmp(reverbModule,'JCRev')
    y = JCRev(inputFilename,revType,revGain,revSize);
elseif strcmp(reverbModule,'Moorer')
    y = Moorer(inputFilename,revType,revGain,revSize,revSpread);
elseif strcmp(reverbModule,'Schroeder')
    y = Schroeder(inputFilename,revType,revGain,revSize,revSpread);
elseif strcmp(reverbModule,'Stereo')
    y = StereoReverb(inputFilename,revType,revGain,revSize);
end

% Writes the output file at a sample rate of 44.1 kHz (only if selected)
if (get(handles.saveParameter,'Value') == get(handles.saveParameter,'Max'))
    audiowrite(outputFilename,y,44100);
end

% Playback of output at sample rate of 44.1 kHz (only if selected)
if (get(handles.soundParameter,'Value') == get(handles.soundParameter,'Max'))
	soundsc(y,44100);
end

% Plotting the input and output signal on a graph using the SignalPlotter.m
% script
[x,~] = audioread(inputFilename);

% RT60 Reverberation Time
reverbTime = RT60(x,y);
set(handles.rt60Time,'string',num2str(reverbTime));

% Plotting the input and output signal using various spectral and temporal
% tools
param04 = cellstr(get(handles.plotType,'String'));
plotSig = param04{get(handles.plotType,'Value')};

% Input Signal
axes(handles.inputGraph);
SignalPlotter(x,plotSig)

% Output Signal
axes(handles.outputGraph);
SignalPlotter(y,plotSig)




% --- Executes on button press in saveParameter.
function saveParameter_Callback(hObject, eventdata, handles)
% hObject    handle to saveParameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of saveParameter


% --- Executes on button press in soundParameter.
function soundParameter_Callback(hObject, eventdata, handles)
% hObject    handle to soundParameter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of soundParameter


% --- Executes on slider movement.
function dryWet_Callback(hObject, eventdata, handles)
% hObject    handle to dryWet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function dryWet_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dryWet (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function spreadRev_Callback(hObject, eventdata, handles)
% hObject    handle to spreadRev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function spreadRev_CreateFcn(hObject, eventdata, handles)
% hObject    handle to spreadRev (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on selection change in roomSize.
function roomSize_Callback(hObject, eventdata, handles)
% hObject    handle to roomSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns roomSize contents as cell array
%        contents{get(hObject,'Value')} returns selected item from roomSize


% --- Executes during object creation, after setting all properties.
function roomSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to roomSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function uipanel1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when uipanel1 is resized.
function uipanel1_SizeChangedFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object deletion, before destroying properties.
function uipanel1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to uipanel1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in plotType.
function plotType_Callback(hObject, eventdata, handles)
% hObject    handle to plotType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns plotType contents as cell array
%        contents{get(hObject,'Value')} returns selected item from plotType


% --- Executes during object creation, after setting all properties.
function plotType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plotType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rt60Time_Callback(hObject, eventdata, handles)
% hObject    handle to rt60Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rt60Time as text
%        str2double(get(hObject,'String')) returns contents of rt60Time as a double


% --- Executes during object creation, after setting all properties.
function rt60Time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rt60Time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
