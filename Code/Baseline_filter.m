Fs = 360; % Sampling Frequency 
F = 3000;
Fnotch = 0.667; % Notch Frequency 
BW = 5; % Bandwidth 
Apass = 1; % Bandwidth Attenuation
 
 [b, a] = iirnotch (Fnotch/ (Fs/2), BW/(Fs/2), Apass); 
 Hd = dfilt.df2 (b, a); %discrete-time, double form filter

x=load ('ECG.txt');
x1=x (:, 1); 
x2=x1./600; 
x2=x2(55000:65000)
 TS = dsp.TimeScope('SampleRate',F,...
                       'TimeSpan',1.5,...
                       'YLimits',[-1 1],...                       
                       'ShowGrid',true,...
                       'NumInputPorts',2,...
                       'LayoutDimensions',[2 1],...
                      'Title','Noisy and Filtered Signals');
tic
while toc<10
    y0=filter (Hd, x2);  
    TS(x2,y0)
end