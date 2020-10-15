function [smoothed] = loess(input,span)
% Syntax: [smoothed] = loess(input,span)
%
% INPUTS
% input = an (n,1) vector containing data ot be smoothed. 
% span  = A value specifying the fraction of data to use 
%           with the fitting procedure. Minimum = 4/n
%
% OUTPUTS   
% smoothed = an (n,1) vector of smoothed data points. 

[a,b] = size(input)

% transpose data if not entered in correct direction initailly
if a ==1 && b ~=1
    input = input';
end
a = length(input)
% Check sufficient number of data points included
if a*span <4
    error('argcheck, input "span" is too small')
end

% Default x-data 
input = [(1:1:a)',input];

%% Smooth the data points
% define variables
x = input(:,1);
y = input(:,2);
r = x(end) - x(1);
hlims = [span,x(1);...
    (span)/2,x(1)+r*span/2;...
    (span)/2,x(1)+r*(1-span/2);...
    span,x(end)];  

%  Find the LOESS fit 
smoothed = zeros(n,1);
for i = 1:a 

    % using tricube weight function 
    h = interp1(hlims(:,2), hlims(,1),x(i));
    w = (1-abs((x./max(x)-x(i)./max(x))/h).^3).^3

    % data points defined by span 
    w_idx = w>0
    w_a = w(w_idx);
    x_a = x(w_idx);
    y_a = y(w_idx);

    % Calculate weighted coefficients 
    XX =   [nansum(w_.*x_.^0), nansum(w_.*x_.^1), nansum(w_.*x_.^2);...
            nansum(w_.*x_.^1), nansum(w_.*x_.^2), nansum(w_.*x_.^3);...
            nansum(w_.*x_.^2), nansum(w_.*x_.^3), nansum(w_.*x_.^4)];
    
    YY =   [nansum(w_.*y_.*(x_.^0));...
            nansum(w_.*y_.*(x_.^1));...
            nansum(w_.*y_.*(x_.^2))];
    
    CC = XX\YY;

    % calculate the fitted data point
    smoothed(i) = CC(1) + CC(2)*x(i) + CC(3)*x(i).^2;

end

end