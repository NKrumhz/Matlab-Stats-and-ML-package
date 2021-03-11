function p = student_cdf(t,nd)
% Syntax: p = student_cdf(t,nd)
%
%Ouput: 
% P = One-tailed probability (left tail) 
%
%Inputs: 
% t = Student t-test score
% nd = degrees of freedom
    
if nd <=0
    error('Degrees of freedom must be positive.');
end


% input checking 
if ~iscolumn(t)
    t = t';
end
if ~iscolumn(nd)
    nd = nd';
end

%check for Nan's 
if any( not(isfinite(t(:))) | not(isfinite(nd(:))) )
    sel = find(isfinite(t) & isfinite(nd));
    x = nan(size(t));
    p = nan(size(t));
    x(sel) = t(sel).^2 ./ (nd(sel) + t(sel).^2);
    p(sel) = 0.5 .* ( 1 + sign(t(sel)) .* betainc( x(sel), 0.5, 0.5*nd(sel)) );
else
    x = t.^2 ./ (nd + t.^2) ;
    p = 0.5 .* ( 1 + sign(t) .* betainc( x, 0.5, 0.5*nd ) );
end 
end