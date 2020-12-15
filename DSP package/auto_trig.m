function trig = auto_trig(sig, alpha, method)
%auto_trig - Description
%%
%inputs: 
% Data 
% alpha 
% method 
if(istable(sig))
    sig = table2array(sig).';
end

if(method >= 1)
    trig = sig > alpha;
elseif(method == 0)
    trig = sig == alpha;
elseif(method <= -1)
    trig = sig < alpha;

trig = 1 + find(diff(trig)>0);
end