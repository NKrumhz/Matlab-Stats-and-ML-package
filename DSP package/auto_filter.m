function y = auto_filter(sig, fs, fc, method)
%auto_filter - Description
%
% Syntax: y = auto_filter(sig, fc)
%
%Inputs 
% sig = input signal 
% fc = target frequency 
% method = "low" for lowpass or "high" for highpass


% start with using the Butterworth filter function in the DSP toolbox.
% eventually I would like to implement a version of that function


fnyq = fs/2;

if fc > fnyq
    error('cut-off frequency cannot be higher than Nyquist frequency');
end


% Generate filter transfer function
[b,a] = butter(2, fc/(fnyq),ftype=method);

% apply filter to signal
y = filter(b,a,sig);