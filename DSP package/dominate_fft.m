function maxf = dominate_fft(sig, freq, wl, ovlp )
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
   

    % input checking 
    if ovlp >= 100 
        ovlp = 99; 
        disp("window overlap cannot be 100% or above")
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

    % loop through and find max frequency amplitude 
    for i = 1:N
        ft = quick_fft(sig(step(i):step(i+1), freq, false));
        maxf(1,i) = find(ft(:,1) == max(ft(:,1)));
    end
    plot(x, maxf)
end