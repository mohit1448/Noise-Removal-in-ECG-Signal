x= load('ECG.txt'); %loading ECG dataset
x1= x(:,1);
Fs=3600;
x2= x1./800;
x2= x2 (1:5000);
% [M,N] = size(x2);
TS = dsp.TimeScope('SampleRate',Fs,...
                      'TimeSpan',1.5,...
                      'YLimits',[-1 1],...
                      'ShowGrid',true,...
                      'NumInputPorts',2,...
                      'LayoutDimensions',[2 1],...
                      'Title','Noisy and Filtered Signals');
tic
while toc < 10

[C, L] = wavedec (x2,9,'bior3.7'); %9 level decomposition using wavelet bior3.7, C = wavelet decomposition vector
                                                                                 %L = number of coefficients by level
%a9 = wrcoef ('a', C, L,'bior3.7',9); 
d9 = wrcoef ('d', C, L,'bior3.7',9); % reconstructs the coefficients of a one-dimensional signal
d8 = wrcoef ('d', C, L,'bior3.7',8);
d7 = wrcoef ('d', C, L,'bior3.7',7);
d6 = wrcoef ('d', C, L,'bior3.7',6);
d5 = wrcoef ('d', C, L,'bior3.7',5);
d4 = wrcoef ('d', C, L,'bior3.7',4);
d3 = wrcoef ('d', C, L,'bior3.7',3);
d2 = wrcoef ('d', C, L,'bior3.7',2);
d1 = wrcoef ('d', C, L,'bior3.7',1);
y= d9+d8+d7+d6+d5+d4+d3+d2+d1;
TS(x2,y)

end
