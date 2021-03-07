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
    x = linspace(0, n/freq, N);
    maxf = zeros(1,N);

    % loop through and find max frequency amplitude 
    for i = 1:N
        sub_sig = sig(step(i):step(i+1));
        ft = quick_fft(sub_sig, freq, windo, false);
        maxf(i) = ft(find(ft(:,2) == max(ft(:,2))),1);
    end
    scatter(x, maxf)
    title('Dominant Frequency of X(t)')
    xlabel('time (s)')
    ylabel('frequency (Hz)')
end