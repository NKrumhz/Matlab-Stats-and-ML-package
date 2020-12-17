function [X,scales] = standardize(X, method)
% Syntax: [X,scale] = standardize(X, method)
%Inputs
% X = vector or matrix to be normalized 
% methods:
% norm = Center and scale to have mean 0 and standard deviation of 1. 
    %same as 'zscore' in base MATLAB function
% robust = Center and scale to have median 0 and median absolute deviation 1
    %same as 'zscore','robust' in base MATLAB function
% range = scale ouput on the Interval of [0 1] 
    %same as 'range' in base MATLAB function 
% mean = Center data to have mean 0
    %same as 'center','mean' in base MATLAB function
% median = Center data to have median 0
    %same as 'center','median' in base MATLAB function
% [2,n] matrix = where n is the number of columns, the first row is mu
    % and the second row is sigma in a standard score normalization equation
    % used to apply the same normalization on 2 different matricies of data.
%
%
%Outputs: 
% X = normalized vector / matrix 
% scales = 2xn transformation applied to input data


A(1) = ischar(method);
A(2) = isstring(method);
if max(A) == 1
    if strcmp(method, 'range')
        mu = min(X);
        sigma = max(X) - mu;
    elseif strcmp(method, 'norm')
        mu = mean(X);
        sigma = std(X);  
    elseif strcmp(method, 'robust')
        mu = median(X);
        sigma = median(abs(X-mu));    
    elseif strcmp(method, 'mean')
        mu = mean(X);
        sigma = 1;   
    elseif strcmp(method, 'median')
        mu = median(X);
        sigma = 1;
    end
end

if isa(method, 'double')
    mu = method(1,:);
    sigma = method(2,:);
end

X = (X-mu)./sigma;
scales = [mu;sigma];
end