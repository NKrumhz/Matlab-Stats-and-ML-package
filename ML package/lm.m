function [theta, history, t] = lm(X, y, alpha, num_iters)
% Multivariate linear Regression
%
% Syntax: [theta, history] = lm(X, y, theta, alpha, num_iters)
%
% Description

    m = length(y); % number of training examples 
    X = [ones(m,1), X]; % Add a column of ones to X
    [a,b] = size(X); 
    theta = zeros(b, 1); % Initialize fitting parameters
    if m == a
        history = zeros(num_iters, 1);
        for iter = 1:num_iters
            hx = X*theta-y;
            theta = theta - X'*hx*(alpha/m);
            history(iter) = (hx'*hx)/m/2;
        end
        %compute t statistic for regression line: 
        sigma = sum(y.^2);
        for i = 1:b
            temp = theta(i) * sum(X(:,i).*y);
            sigma = sigma - temp;
        end
        sigma = sqrt(sigma/(a-b));
        SXX = sum(X.^2) - (sum(X).^2./m);
        t = sigma./sqrt(SXX);
        
    else
        disp("Need equal number of observations (X) and labels (y)")
    end
end