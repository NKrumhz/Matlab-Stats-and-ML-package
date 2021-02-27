classdef lm
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        rank
        theta
        fitted
        mse
        stats
        residuals
        
    end
    
    methods
    function fit = lm(X, y, zero)
        % Multivariate linear Regression
        %
        % Syntax: fit = lm(X, y, zero)
        %
        % X = Training Data
        % y = Training Labels
        % zero = true if you want to force the regression through (0,0). 
        
            if ~ iscolumn(y) % check if y is a column vector
                y = y';
            end 

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
                    fit.mse = mean(hx.^2);

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
                fit.stats = table(theta,t',p','VariableNames',vars);
            else
                disp("Need equal number of observations (X) and labels (y)")
            end
        fit.theta = theta;
        fit.fitted= X * theta;
        fit.residuals = fit.fitted - y; 
        fit.rank = [b, zero];
        end
        
        function yprime = predict(obj,newX)
        % predict from regression 
        %
        % Syntax: yprime = predict(lm, newX)
        %
        % lm = lm object 
        % newX = new data to make predictions on 
            
            % input error checking 
            if ~exist('newX','var') 
                yprime = obj.fitted;
            else
                [m,~] = size(newX);
                if obj.rank(2) == 0
                    newX = [ones(m,1),newX]; % Add a column of ones to X too add bias    
                end
                
                [~,b] = size(newX);
                if obj.rank(1) ~= b
                    error("number of input columns not the same as the trained data");
                end
                
                % compute fit 
                yprime = newX * obj.theta;
            end
        end
        
        
        function CV = cv_folds(obj, X, y, K)
        %lm_cv - Description
        %
        % Syntax: CV = lm_cv(lmfit, x, y, K)
        %
        % Long description
        % see glm.cv from boot library in R 
      
            % input error checking 
            [n,b] = size(X);
            if b > n
                X = X';
                [n,~] = size(X);
            end
            
            if ~ iscolumn(y) % check if y is a column vector
                y = y';
            end 

            if ~exist('K','var')
                K = n;
            end

            if K > n || K <= 1
                error("'K' is outside allowable range")
            end

            f = ceil(n/K);
            s = resample(repmat(1:K,f),n,false);
            fit_y = obj.fitted + obj.residuals;
            ms = max(s);
            CV = 0;
            j = 1:n;
            for i = 1:ms
                j_out = j(s == i);
                j_in = j(s ~= i);
                d.lm = lm(X(j_in,:),y,obj.rank(2));
                costi = mean((fit_y(j_out) - predict(d.lm,X(j_out)).^2);
                CV = CV + length(j_out)/n * costi;
            end
            
    end
end

