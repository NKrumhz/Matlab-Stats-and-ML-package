function [X_train,y_train,X_test,y_test] = test_train_split(X,y,reserve)
%
% Syntax: [X_train,y_train,X_test,y_test] = test_train_split(X,y,reserve)
%
%Inputs:
% X a vector or matrix of features for regression
% y the response variable or the column the response variable is in matrix X
% reserve < 1 is the percentage of samples to reserve for the testing dataset. 
% reserve > 1 is the number of samples to reserve for the testing dataset. 

    [a,b] = dim(X);
    [c,d] = dim(y);

    idx = 1:a;

    if reserve < 1
        n = max(c,d);
        reserve = reserve * n;
        
    idx_test = resample(idx, reserve, false);
    idx_train = setdiff(idx, idx_test);
    % if X is all the data and y is the channel location of the response
    if c == d == 1
        y = X(:,y);
        X(:,y) = [];
    
    X_train = X(idx_train,:);
    X_test = X(idx_test,:);
    y_train = y(idx_train,:);
    y_test = y(idx_test,:);
end