function ft = quick_fft(sig, freq, plot)
%quick_fft - Description
%
% Syntax: ft = quick_fft(sig, freq, plot)
%
% Long description
% Inputs 
%sig = input data 
%freq = sampling frequency (Hz)
%TL = transform length
%plot = true or false if you want a plot of the data 
    
    if ~exist('plot','var') 
        plot = true;
    end

    T = 1/freq;         % Sampling period
    L = length(sig);    % length of signal 
    nfft = 2^nextpow2(L)% Transform Length
    t = (0:L-1)*T;      % Time vector

    sig = detrend(sig); % detrend input 

    Y = fft(sig, nfft);

    P2 = abs(Y/L);
    P1 = P2(1:floor(L/2+1));
    P1(2:end-1) = 2*P1(2:end-1);

    f = freq*(0:floor(L/2))/L;

    if plot == true
        plot(f, P1) 
        title('Spectrum of X(t)')
        xlabel('f (Hz)')
        ylabel('|P1(f)|')
    end
    
    % frequency,amplitude
    ft = [f, P1];

end