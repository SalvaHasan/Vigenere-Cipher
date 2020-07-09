function varargout = VigenereCipherGUI(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VigenereCipherGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @VigenereCipherGUI_OutputFcn, ...
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


function VigenereCipherGUI_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

function varargout = VigenereCipherGUI_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function PlainText_Callback(hObject, eventdata, handles)

function PlainText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Key_Callback(hObject, eventdata, handles)

function Key_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function EncryptedText_Callback(hObject, eventdata, handles)

function EncryptedText_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Encryption_Callback(hObject, eventdata, handles)

Alph = ['a':'z'];
PlainText =  get(handles.PlainText,'string'); %Get text from GUI
PlainText = lower(PlainText);                 %Convert to lowercase to match dictionary
TextLength = length(PlainText);
Key =  get(handles.Key,'string');             %Get Key from GUI
Key = lower(Key);              
KeyLength = length(Key);

CheckInput=0;
CheckKey=0;


%------Dictionary Grid------%
m=1; n=1;
for i = 1:26  
    n=i;
    for j = 1:26
        
        if(m == 0)                        
            if n > 26
                n=1;
            end    
            Dictionary(i,j)= Alph(n);
            n=n+1;
        else
            Dictionary(i,j)= Alph(j);
        end    
    end
    m=0;
end


%------Input Validation Check------%

for i = 1:TextLength
    for j = 1:26        
                                %Include spaces in input
        if PlainText(i) == Alph(j) || PlainText(i) == ' ' 
           CheckInput=1;
        end
    end
   
   if(CheckInput == 0)
        set(handles.Output,'String','Invalid Input');
        return
    else
        CheckInput=0;
    end   
end


%------Key Validation Check------%

for i = 1:KeyLength
    for j = 1:26
        
        if Key(i) == Alph(j) 
           CheckKey=1;
        end
    end
   
   if(CheckKey == 0)
         set(handles.Output,'String','Invalid Key');
        return
    else
        CheckKey=0;
    end   
end


%------Encryption------%
k=1; 
for i = 1:TextLength
    for j = 1:26
        
        if PlainText(i) == ' ' 
            rows(i)=0;
            k = k-1;
            break;
        else
            if PlainText(i) == Alph(j)
                rows(i)=j;
            end
            if k > KeyLength
                k=1;                        %Repeat Key
            end
            if Key(k) == Alph(j)
                cols(i)=j;
            end
        end 
    end
    k=k+1;    
    if(rows(i) == 0)
        EncryptedText(i)=' ';
    else    
        EncryptedText(i)= Dictionary(rows(i),cols(i));
    end       
end
set(handles.Output,'String',EncryptedText);     %Display output on GUI



function Decryption_Callback(hObject, eventdata, handles)

Alph = ['a':'z'];

Key =  get(handles.Key,'string');
Key = lower(Key);              
KeyLength = length(Key);

EncryptedText =  get(handles.EncryptedText,'string');
EncryptedText = lower(EncryptedText);              
TextLength = length(EncryptedText);


%------Dictionary Grid------%
m=1; n=1;
for i = 1:26
    
    n=i;
    for j = 1:26
        
        if(m == 0)                        
            if n > 26
                n=1;
            end    
            Dictionary(i,j)= Alph(n);
            n=n+1;
        else
            Dictionary(i,j)= Alph(j);
        end
        
    end
    m=0;
end


%------Decryption------%
k=1;
for i = 1:TextLength
    for j = 1:26
            if k > KeyLength
                k=1;                        %Repeat Key
            end
            if Key(k) == Alph(j)
                decols(i)=j;
            end       
    end
    
    for j = 1:26
        if EncryptedText(i) == ' ' 
            derows(i)=0;
            k = k-1;
            break;
        elseif EncryptedText(i) == Dictionary(j,decols(i))
         derows(i)=j;
        end
    end
      k=k+1;   
    if derows(i) == 0
        DecryptedText(i)=' ';
    else     
        DecryptedText(i)= Dictionary(derows(i),1);
    
    end         
end
set(handles.Output,'String',DecryptedText);         %Display output on GUI
