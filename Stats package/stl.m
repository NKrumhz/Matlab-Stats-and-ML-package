function decomp = stl(Data,period)
% Syntax: decomp = stl(x,period)
%
%Input:
%
%Output:
%Trend
%Seasonality
%Residual
    
x = 1:length(Data)
%1.find an approximate Trendline 
[mdl,~,~] = lm(x',Data);
newX = [ones(1:length(x),1),x];
apptrend = newX * mdl;

%2. get seasonality mean 
detrend = x - apptrend;
M = reshape(detrend,[],period);
season = mean(M);
[a,~] = size(M);

% populate this component 
seasonal = repelem(season,a);
seasonal = seasonal[1:length(x)]; % shorten length if needed
decomp.seasonal = seasonal;
%3. De-Seasonalized data 
%deseasoned = Data - seasonal;
% you can now fit a polynomial model again?
trend = apptrend;
decomp.trend = trend;
%4. find residuals 
decomp.residual = x - trend - seasonal

% plot

end