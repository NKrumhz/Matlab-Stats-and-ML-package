function output = PCA(Data)
    % Syntax: [Dev,V,cntr,XV] = PCA(Data)
    %
    %Inputs: 
    % Data = data to perform PCA analysis on 
    %Outputs: 
    % Dev = cumulative percentage of variance explained by each new variable
    % rotation = rotation vector. Allows the same rotation to be applied to new data
    % cntr = output from normalise function to apply normalisation to new data
    % XV = new rotated Data. 
    
    tab = istable(Data);
    if tab == true
        names = Data.Properties.VariableNames;
        Data = table2array(Data);
    end
    [X,cntr] = normalise(Data,'norm');
    
    % find covariance matrix
    CV = cov(X);
    % calculate vector and values
    [V,Dev] = eig(CV);
    % sort eigenvectors
    [Dev,i] = sort(diag(Dev),'descend');
    V = V(:,i);
    % PCA vectors are columns where the rows are 
    output.dev = cumsum(Dev)/sum(Dev)*100;
    output.cntr = cntr;
    output.XV  = X*V;

    if tab == true
        V = table(V,'rownames',names);
    end
    output.rotation = V;     
    end