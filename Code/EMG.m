x = ecg(500).';
y = sgolayfilt(x,0,5); % applies a Savitzky-Golay finite impulse 
                       % response (FIR) smoothing filter of polynomial 
                       % order 0 and frame length 5 to the data in vector x.
Fs = 1000;
[M,N] = size(y); %M = 500, N = 1

%Initialize scopes
TS = dsp.TimeScope('SampleRate',Fs,...
                      'TimeSpan',1.5,...
                      'YLimits',[-1 1],...
                      'ShowGrid',true,...
                      'NumInputPorts',2,...
                      'LayoutDimensions',[2 1],...
                      'Title','Noisy and Filtered Signals');

% Design lowpass filter
Fpass  = 200;
Fstop = 400;
Dpass = 0.05;
Dstop = 0.0001;
F     = [0 Fpass Fstop Fs/2]/(Fs/2);
A     = [1 1     0     0];
D     = [Dpass Dstop];
b = firgr('minorder', F, A, D); %designs filters repeatedly until the minimum order filter is found.
LP = dsp.FIRFilter('Numerator',b); %returns a finite impulse response filter object with vector b as coefficients

% Design Highpass Filter
Fstop = 200;
Fpass = 400;
Dstop = 0.0001;
Dpass = 0.05;
F = [0 Fstop Fpass Fs/2]/(Fs/2); % Frequency vector
A = [0 0     1     1]; % Amplitude vector
D = [Dstop   Dpass];   % Deviation (ripple) vector (maximum allowable 
                       % deviation between the frequency response and 
                       % the desired amplitude of the output band)
b  = firgr('minord', F, A, D); %returns a length n+1 linear phase FIR filter
HP = dsp.FIRFilter('Numerator', b);

% Stream
tic;
while toc < 10
    x = .1 * randn(M,N); %random number generator
    highFreqNoise = HP(x); %high frequency noise generator
    noisySignal    = y + highFreqNoise; %noisy signal generation
    filteredSignal = LP(noisySignal); %filtering of signal
    TS(noisySignal,filteredSignal);
end

% Finalize
release(TS)
