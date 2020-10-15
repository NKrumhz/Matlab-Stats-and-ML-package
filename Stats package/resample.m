function y = resample(Data, obs, replace)
% Syntax: y = resample(Data, observe,replace)
%
%Inputs:
% Data = Vector of data to be resampled. 
% obs = number of observations 
m = length(Data);
if isequal(class(Data), 'table')
    Data = table2array(Data);
end

if obs > m
    error('Resample cannot return more values than input data. obx > Data')
end

% Resample with or without replacement
if replace == true
    idx = randi(m,obs,1);
    y = Data(idx);
else
    idx = randperm(m,obs);
    y = Data(idx);
end