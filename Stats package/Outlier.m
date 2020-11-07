function [idx,I] = Outlier(Data,method,k)
% Syntax: idx = Outlier(Data,method)
%
% Long description
[a,b] = dim(Data)

if strcmp(method,'Grubbs')
    disp('Grubbs test for one outlier')
    disp('function not implemented yet')
elseif strcmp(method,'Dixon')
    disp('Dixon test for outliers')
    if a < 3 | a > 30
        error('Dixon test is best suited for small sample sizes only')
    end
    disp('function not implemented yet')
elseif strcmp(method, 'Rosner')
    disp('Rosner test for k outliers')
    disp('function not implemented yet')
elseif strcmp(method, 'Hampel')
    % Hempel filter
    % 3 standard deviations outisde Median absolute deviation
    xhat = median(Data);
    MAD = median(abs(Data - xhat));
    I(1) = xhat - 3*MAD; 
    I(2) = xhat + 3*MAD;
else
    % IQR Method 
    q75 = quantl(Data,75);
    q25 = quantl(Data,25);
    IQR = q75 - q25;
    I(1) = q25 - 1.5*IQR;
    I(2) = q75 + 1.5*IQR;
    % Outliers are any points outside Interquartile range
end

idx = find(Data < I(1) | Data > I(2));