function trig = auto_trig(sig, method, alpha)
%auto_trig - Description
%%
%inputs: 
% sig = input Data
% method = returns signals greater than alpha when positive, 
%less than alpha when negative and equal to alpha when 0. 
%alpha is also scaled by the value of method. 
% alpha = the numeric threshold to restart the signal.
%if not input, the min value will be used if method is 
%positive, the max value will be used if method is negative. 

if(istable(sig))
    sig = table2array(sig).';
end

if(method > 0)
    % use min value if alpha is not supplied
    if ~exist('alpha','var') 
        alpha = min(sig);
    end
    trig = sig > abs(method) * alpha;
elseif(method == 0)
    trig = sig == alpha;
elseif(method < 0)
    % use max value if alpha is not supplied
    if ~exist('alpha','var') 
        alpha = max(sig);
    end
    trig = sig < abs(method) * alpha;
end


trig = 1 + find(diff(trig)>0);
end