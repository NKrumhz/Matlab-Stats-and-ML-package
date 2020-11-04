% 1. Make the data stationary
% 2. Fit an AR model
% 3. Fitting an MA model on the residuals 
% 4. Getting back the original data

function mdl = ARIMA(X, p,d,q)
% Syntax: mdl = ARIMA(X, p,d,q)
%
% Auto-Regressive Integrated Moving Average
%

% 1. Difference data to make data stationary on time
% remove trend
if d == 1
    X_1 = X(2:end);
    X = X(1:(end-1)) - X_1;
elseif d > 1
    error('integrated term >1 not implimented yet');
end
% 2. log transform data to make data stationary on variance
Ynew = log10(X);

% 3. Difference log transform data stationary on variance
if p == 1
    Y_1 = Ynew(2:end);
    Ynew = Ynew(1:(end-1)) - Y_1;
elseif p > 1
    error('Higher order auto-regressive model not implimented yet')
end
% 4. Moving Average Pass 
if q == 1
    %Yt = lm()
elseif q > 1
    error('Higher order Moving Average model not implimented yet')
end