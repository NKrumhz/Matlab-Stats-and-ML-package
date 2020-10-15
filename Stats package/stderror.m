function SEM = stderror(X)
% Syntax: STE = stderror(X)
%
%INPUTS:
% X = Data to take standard error of 
%OUTPUTS: 
% SEM = Standard error of the mean

sigma = std(X);
n = length(X);

SEM = sigma ./(sqrt(n));
end