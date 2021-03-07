function maxf = dominate_fft(sig, freq, wl, ovlp, windo)
%dominate_fft - Description
%
% Syntax: maxf = dominate_fft(sig, freq, wl, ovlp)
%
% Long description
%Inputs
% sig = input data 
% freq = sampling frequency (Hz)  
% wl = window length (samples)
% ovlp = window overlap percentage [0-100)
% windo = window function to use instead of square window (function input @)
   

    % input checking 
    if ovlp >= 100 
        ovlp = 99; 
        disp("window overlap cannot be 100% or above")
    end

    if isrow(sig)
        sig = sig';
    end
    
    n = length(sig);

    if wl > n 
        wl = n;
        disp("window length cannot be larger than length of input data")
    end 

    % find number of separate windows 
    step = [1 : wl - (ovlp * wl/100) : n , n];
    N = length(step) -1;
    x = linspace(0, n/freq, length = N);
    maxf = zeros(1,N);

    % apply window 
    if ~exist('windo','var') 
        Twindow = ones(1,wl)
        scale = 1; 
    else
        Twindow = windo(wl);
        scale = wl / sum(Twindow);
    end

    % loop through and find max frequency amplitude 
    for i = 1:N
        sub_sig = sig(step(i):step(i+1) .* Twindow;
        ft = quick_fft(scale * sub_sig .* Twindow, freq, false));
        maxf(1,i) = find(ft(:,1) == max(ft(:,1)));
    end
    plot(x, maxf)
    title('Dominant Frequency of X(t)')
    xlabel('time (s)')
    ylabel('frequency (Hz)')
end