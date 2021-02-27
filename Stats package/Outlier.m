function [idx,I] = Outlier(Data,method,k)
% Syntax: idx = Outlier(Data,method)
%
% Long description
%Inputs
% Data = Input data vector
% method = IQR method by Default, "Hampel" to use Hampel filter method
%
%Outputs
% idx = indicies where the input data is greater or lower than the range
% I = matrix of min and max range that specify what values are outliers
[a,~] = dim(Data);

if ~exist('method','var')
    method = "";
end 

method = lower(method);

if strcmp(method,'grubbs')
    disp('Grubbs test for one outlier')
    disp('function not implemented yet')
elseif strcmp(method,'dixon')
    disp('Dixon test for outliers')
    if a < 3 | a > 30
        error('Dixon test is best suited for small sample sizes only')
    end
    disp('function not implemented yet')
elseif strcmp(method, 'rosner')
    disp('Rosner test for k outliers')
    disp('function not implemented yet')
elseif strcmp(method, 'hampel')
    % Hempel filter
    % 3 standard deviations outisde Median absolute deviation
    if ~exist('k','var') 
        k = 3;
    end

    xhat = median(Data);
    MAD = median(abs(Data - xhat));
    I(1) = xhat - k*MAD; 
    I(2) = xhat + k*MAD;
else
    % IQR Method
    if ~exist('k','var') 
        k = 1.5;
    end 
    q75 = quantl(Data,75);
    q25 = quantl(Data,25);
    IQR = q75 - q25;
    I(1) = q25 - k*IQR;
    I(2) = q75 + k*IQR;
    % Outliers are any points outside Interquartile range
end

idx = find(Data < I(1) | Data > I(2));