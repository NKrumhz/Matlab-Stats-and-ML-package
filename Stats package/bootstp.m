function [hypothesis, bootstrap] = bootstp(statistic, X, Y)
% Syntax: bootstrap = bootstp(statistic, Data)
%
% A statistical test that uses random sampling with replacment to measure the accuracy
% of said sample statistic. This method can be used on almost any statisic. 

if nargin == 2
    Y = X;
end
hypothesis = statistic(X);

B = 3000 + round(20*sqrt(length(X)));
S = zeros(B,1);

for i = 1:B 
    y.boot = resample(Y,length(Y),true);
    S(i) = statistic(y.boot);
end
order = sort(S);
quantile = find(order==hypothesis,1,'first')/B;

histogram(S)
line([hypothesis,hypothesis],ylim,'LineWidth', 2, 'color','red')