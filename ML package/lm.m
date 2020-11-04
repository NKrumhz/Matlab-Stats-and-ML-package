function [theta, mse, fit] = lm(X, y, zero)
    % Multivariate linear Regression
    %
    % Syntax: [theta, err] = lm(X, y, theta, alpha, num_iters)
    %
    % X = Training Data
    % y = Training Labels
    % zero = true if you want to force the regression through (0,0). 
    
        m = length(y); % number of training examples
        
        if ~exist('zero','var') 
            zero = false;
        end
        
        if zero == false
            X = [ones(m,1), X]; % Add a column of ones to X too add bias
        end
        
        % evaluation to regression
        [a,b] = size(X); 
        theta = zeros(b, 1); % Initialize fitting parameters
        if m == a
    
            % Regression through Normal Equation
                theta = pinv(X' * X) * X' * y;
                hx = X*theta-y;
                mse = mean(hx.^2);
            
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
            t(1) = theta(1) * ((1/b)+(mean(X(:,1))/SXX(1)));
            
            %compute p value from t statistic 
            p = 2 * (1-student_cdf(abs(t),repelem(a-b,length(t))));
            vars = {'coefs', 't value', 'Pr(>|t|)'};
            fit = table(theta,t',p','VariableNames',vars);
        else
            disp("Need equal number of observations (X) and labels (y)")
        end
    end