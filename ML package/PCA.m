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
    
    %[a,b] = size(Data);
    % Center Data & normalize data on [0,1]
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
    output.rotation = V;
    output.cntr = cntr;
    output.XV  = X*V;
     
    end