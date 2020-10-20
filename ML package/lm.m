function [theta,mse, t] = lm(X, y, alpha, num_iters)
% Multivariate linear Regression
%
% Syntax: [theta, err, fit] = lm(X, y, theta, zero)
%
% Description:
% Linear Regression 
%Outputs: 
% theta = Fit Coeficients 
% 


    m = length(y); % number of training examples 
    if ~exist('zero','var') 
        zero = false;
    end
    
    if zero == false
        X = [ones(m,1), X]; % Add a column of ones to X too add bias
    end

    [a,b] = size(X); 
    theta = zeros(b, 1); % Initialize fitting parameters

    if m == a
        % Regression through Normal Equation
        hx = X*theta-y;
        theta = pinv(X' * X) * X' * y;
        mse = mean(((X*theta) - y)).^2;
        %compute t statistic for regression line: 
        sigma = sum(y.^2);
        for i = 1:b
            temp = theta(i) * sum(X(:,i).*y);
            sigma = sigma - temp;
        end
        sigma = sqrt(sigma/(a-b));
        SXX = sum(X.^2) - (sum(X).^2./m);
        s_ehat = sigma./sqrt(SXX);
        t = theta' ./ s_ehat;
        t = t(1) = NaN;
        
        %compute p value from t statistic 
        nd = a-b;
        p = 2 * (1-student_cdf(abs(t),repelem(a-b,length(t))));
        vars = {'coefs', 't value', 'Pr(>|t|)'};
        fit = table(theta,t',p','VariableNames',vars);
    else
        disp("Need equal number of observations (X) and labels (y)")
    end
end