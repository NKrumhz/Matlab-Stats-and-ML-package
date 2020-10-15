function [output] = quantl(Data, percentile)
%% [output] = quantl(Data, percentile)
%
%Inputs: 
    %Data = a 1-D vector of Data
    %percentile = the percentile of the data requested. 

if isequal(class(Data), 'table')
    Data = table2array(Data);
end
%percentile input should be a double, not a char or else
if isequal(class(percentile),'double')
    % assuming that if the values are less than 1 then you input the
    % fractional equivalent [0-1) as opposed to the integer equivalent
    % [1-100] of the requested quantile
    if percentile < 1
        percentile = percentile * 100;
    elseif percentile > 100
        error('value over 100%');
    end

    order = sortrows(Data); % order data
    [x,y] = size(Data); % get number of samples 
    % round requested sample to nearest whole number 
    if y > x
        point = round(y * percentile/100);
    else
        point = round(x * percentile/100);
    end

else
    error('Quantile percentile not entered as a double');
end
    if x == 1
        output = order(point);
    else
        output = order(point,:);
    end
end