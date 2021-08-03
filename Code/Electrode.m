clear all
y1=load ('1a.txt'); 
Fs=3000;

y2= (y1 (:,1)); % ECG signal data 
a1= (y1 (:,1)); % accelerometer x-axis data 
a2= (y1 (:,1)); % accelerometer y-axis data 
a3= (y1 (:,1)); % accelerometer z-axis data
y2 = y2/max (y2); 
a = a1+a2+a3; 
a=a/max (a); 
mu= 0.0008; 
lms = dsp.LMSFilter(32, 'StepSize', mu);
[s2,e] = lms(y2,a);
 TS = dsp.TimeScope('SampleRate',Fs,...
                       'TimeSpan',1.5,...
                       'YLimits',[-1 1],...
                       'ShowGrid',true,...
                       'NumInputPorts',2,...
                       'LayoutDimensions',[2 1],...
                      'Title','Noisy and Filtered Signals');
 tic
 while toc < 10
     TS(y2,e)
 end

