classdef lm < handle
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

                fit.theta = theta;
                fit.fitted= X * theta;
                fit.residuals = y - fit.fitted; 
                fit.rank = [b, zero];

                %compute t statistic for regression line: 
                sigma = (sum(fit.residuals).^2)/(a-b); %error variance
                s_ehat = sqrt(diag(sigma .* pinv(X' * X)));
                t = theta' ./ s_ehat';

                %compute p value from t statistic 
                p = 2 * (1-student_cdf(abs(t),repelem(a-b,length(t)))); % we want 2 sided test
                vars = {'coefs', 't_Val', 'p_Val'};
                fit.stats = table(theta,t',p','VariableNames',vars);
            else
                disp("Need equal number of observations (X) and labels (y)")
            end

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
                [n,b] = size(X);
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
            weight = zeros(1,ms);
            thetaM = zeros(obj.rank(1),ms);
            % Main Loop 
            for i = 1:ms
                j_out = j(s == i);
                j_in = j(s ~= i);
                d_lm = lm(X(j_in,:),y(j_in),obj.rank(2));
                weight(i) = d_lm.mse;
                thetaM(:,i) = d_lm.theta;
                costi = mean((fit_y(j_out) - predict(d_lm,X(j_out,:)).^2));
                CV = CV + length(j_out)/n * costi;
            end
        
            obj.theta = sum(thetaM .* weight, 2) / sum(weight);
        end
    end
end

