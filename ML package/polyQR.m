function [C, norm2] = polyQR(X, nd)
% Syntax: [C2] = polyQR(X, nd)
%
% Compute Orthogonal Polynomials via QR decomposition
% In Progress
%INPUTS
% X = vector to apply polynomial transformation to
% nd = highest degree polynomial 
%OUTPUTS
% C = Transformed matrix 
% norm2 = normalization vector 


% xbar <- mean(x)
% x <- x - xbar
% X <- outer(x, 0L:degree, "^")
% QR <- qr(X)
% if (QR$rank < degree)
%     stop("'degree' must be less than number of unique points")
% z <- QR$qr
% z <- z * (row(z) == col(z))
% Z <- qr.qy(QR, z)
% norm2 <- colSums(Z^2)
% alpha <- (colSums(x * Z^2)/norm2 + xbar)[1L:degree]
% norm2 <- c(1, norm2)
% Z <- Z/rep(sqrt(norm2[-1L]), each = length(x))


%%
[a,b] = size(X);
if b ==1
    l = nchoosek(b+nd,b)-1;
    xbar = mean(X);
    X = X-xbar;
    y = 0:nd;
    xtend = ones(b,nd+1);
    outer = (X*xtend).^y;
    [Q,R] = qr(outer);
    alpha = eye(a,l+1);
    C = Q(:,2:l+1);
    norm2 = sum(abs(R .* alpha));
    norm2 = [1,norm2];
end
