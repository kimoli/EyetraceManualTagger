function varargout = eyetraceSearchAndMarkGUI(varargin)
% EYETRACESEARCHANDMARKGUI MATLAB code for eyetraceSearchAndMarkGUI.fig
%      EYETRACESEARCHANDMARKGUI, by itself, creates a new EYETRACESEARCHANDMARKGUI or raises the existing
%      singleton*.
%
%      H = EYETRACESEARCHANDMARKGUI returns the handle to a new EYETRACESEARCHANDMARKGUI or the handle to
%      the existing singleton*.
%
%      EYETRACESEARCHANDMARKGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EYETRACESEARCHANDMARKGUI.M with the given input arguments.
%
%      EYETRACESEARCHANDMARKGUI('Property','Value',...) creates a new EYETRACESEARCHANDMARKGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before eyetraceSearchAndMarkGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to eyetraceSearchAndMarkGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help eyetraceSearchAndMarkGUI

% Last Modified by GUIDE v2.5 06-Dec-2018 17:56:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @eyetraceSearchAndMarkGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @eyetraceSearchAndMarkGUI_OutputFcn, ...
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


% --- Executes just before eyetraceSearchAndMarkGUI is made visible.
function eyetraceSearchAndMarkGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to eyetraceSearchAndMarkGUI (see VARARGIN)

% set up hidden figure variables
setappdata(0, 'trialdata', [])

% Choose default command line output for eyetraceSearchAndMarkGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% set table size to 100 x 1
set(handles.uitable1,'Data',cell(100,1));

% UIWAIT makes eyetraceSearchAndMarkGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = eyetraceSearchAndMarkGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function TrialSlider_Callback(hObject, eventdata, handles)
% hObject    handle to TrialSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% update the displayed trial number
trialSelected = int32(get(handles.TrialSlider, 'Value'));
set(handles.trialDisplayEditTextbox, 'string', num2str(trialSelected))

% update the displayed eyetrace plot
axes(handles.eyetrace)
trials = getappdata(0, 'trialdata');
plotEyetraceForSearchGUI(handles, trials, trialSelected)




% --- Executes during object creation, after setting all properties.
function TrialSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TrialSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function trialDisplayEditTextbox_Callback(hObject, eventdata, handles)
% hObject    handle to trialDisplayEditTextbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trialDisplayEditTextbox as text
%        str2double(get(hObject,'String')) returns contents of trialDisplayEditTextbox as a double


trials = getappdata(0, 'trialdata');
numtrials = size(trials.eyelidpos,1);
trialSelected = str2double(get(hObject, 'string'));

if trialSelected<=numtrials && trialSelected>0
    % update GUI
    set(handles.TrialSlider, 'Value', trialSelected);
    plotEyetraceForSearchGUI(handles, trials, trialSelected)
else
    % tell the user not to select impossible trialnumbers
    a = 'Trial number';
    b = num2str(trialSelected);
    c = 'does not exist.';
    message = [a ' ' b ' ' c];
    f = msgbox(message,'no no no','error');
    
    % reset the edit textbox to the numerical value on the slider
    currentTrial = int32(get(handles.TrialSlider, 'Value'));
    set(handles.trialDisplayEditTextbox, 'string', num2str(currentTrial))
end


% --- Executes during object creation, after setting all properties.
function trialDisplayEditTextbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trialDisplayEditTextbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in loadFileButton.
function loadFileButton_Callback(hObject, eventdata, handles)
% hObject    handle to loadFileButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% tell user to select directory
dname = uigetdir('L:\\users\okim\behavior', 'Select an animal and a day.'); % this assumes that the user is working on ALBUS
cd(dname)

% check the trialdata.mat file to determine if you need to set a different
% calib baseline value
loadMe = dir('trialdata.mat');
load(loadMe.name)
numtrials = size(trials.eyelidpos,1);

setappdata(0, 'trialdata', trials)

% update the display in the textbox & slider to reflect the first trial
set(handles.trialDisplayEditTextbox, 'string', '1')
set(handles.TrialSlider, 'Value', 1);
set(handles.TrialSlider, 'min', 1);
set(handles.TrialSlider, 'max', numtrials);
set(handles.TrialSlider, 'SliderStep', [1/numtrials , 10/numtrials]);

% plot the first trial
axes(handles.eyetrace)
plotEyetraceForSearchGUI(handles, trials, 1)



% --- Executes on button press in markTrialButton.
function markTrialButton_Callback(hObject, eventdata, handles)
% hObject    handle to markTrialButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in undoButton.
function undoButton_Callback(hObject, eventdata, handles)
% hObject    handle to undoButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in saveButton.
function saveButton_Callback(hObject, eventdata, handles)
% hObject    handle to saveButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function filenameEditTextbox_Callback(hObject, eventdata, handles)
% hObject    handle to filenameEditTextbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filenameEditTextbox as text
%        str2double(get(hObject,'String')) returns contents of filenameEditTextbox as a double


% --- Executes during object creation, after setting all properties.
function filenameEditTextbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filenameEditTextbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
