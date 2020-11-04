function acf = ACF(X,lag)
% Syntax: acf = ACF(X,lag)
%
%Inputs
% X = univariate numeric time series or vector 
% lag = maximum lag at which to cacluate the acf
    
% Input Checks
if class(X) == 'timeseries'
    X = permute(X.Data,[3,1,2]);
end

[a,b] = size(X);
if a ~=1 & b ~=1 
    error('Input series muxt be an nx1 column vector')
elseif b ~= 1
    X = X';
    [a,b] = swap(a,b);
end

if ~exist('lag', 'var')
    if a < 30
        lag = 10 * log10(a/(a-1));
    else
        lag = 10 * log10(a/30);
    end
elseif sum(size(lag)) > 2
    error('Input number of lags must be a 1x1 scalar')
end

% Code 
xbar = mean(X);

% let's use implemented function in MATLAB
X = X-xbar;
[C,lags] = xcorr(X,lag);

z = lag+1; % MATLAB index's at 1
acf = C(z:end-1)/100; % I want values on [-1 1]
lags = lags(z:end-1)+1; % values make sense; 

% ACF plot
stem(lags,acf)
line([0 lag+0.5], (1.96)*(1/sqrt(a))*ones(1,2))
line([0 lag+0.5], (-1.96) *(1/sqrt(a))*ones(1,2))