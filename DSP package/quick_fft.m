function ft = quick_fft(sig, freq, windo, pt)
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
    
    % inpuc checking 
    if ~exist('pt','var') 
        pt = true;
    end

    if isrow(sig)
        sig = sig';
    end

    T = 1/freq;          % Sampling period
    L = length(sig);     % length of signal 

    sig = detrend(sig); % detrend input 

    % get window 
    if ~exist('windo','var') 
        Twindow = ones(L,1);
        scale = 1; 
    else
        Twindow = windo(L);
        scale = L / sum(Twindow);
    end

    %Use FFT function
    Y = fft(sig .* Twindow);

    P2 = abs(Y/L);
    P1 = P2(1:floor(L/2+1));
    P1(2:end-1) = scale * 2 * P1(2:end-1);

    f = freq*(0:floor(L/2))/L;
    ft = [f', P1];

    if pt == true
        plot(f', P1) 
        title('Spectrum of X(t)')
        xlabel('f (Hz)')
        ylabel('|P1(f)|')
    end
    
    

end
