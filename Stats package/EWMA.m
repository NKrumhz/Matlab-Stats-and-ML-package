function [output, ci] = EWMA(input, lmbd)
%
%Called Exponentially Weighted Moving Average 
%   This function is only exponentially weighted if 1/e is entered as
%   lambda (lmbd(. This implementation also employs a 1-D filter to further
%   smooth out the data. In this function, the window size of the 1-d
%   filter is 1/lambda, which for lambda of 1/e gives a window size rounded
%   to 3. 


[x,y] = size(input);
windowSize = round(1/lmbd);
b = (1/windowSize)*ones(1,windowSize);

a = 1;
% need an exponentially weighted mask
rez = zeroes(x+1,y);
rez(1) = median(input);
V = zeros(x,y);
ci = zeros(x,y);
t = 1:x;

%% itterative solve
input = filter(b,a,input);
for i = t
    rez(i+1) = lmbd*input(i) + (1-lmbd)*rez(i);
    sig2 = var(input(1:i));
    V(i) = sig2 * (lmbd / (2-lmbd) * (1 - (1 - lmbd)^(2*i)));
    ci(i) = 3*sqrt(V(i));
    
end
b_n = (2/x/3)*ones(1,x/3);
mu = filter(b_n,a,(input-rez(1)));

above = mu + rez(1) + ci;
above2 = mu + rez(1) + (ci*3);
below = mu + rez(1) - ci;
below2 = mu + rez(1) - (ci*3);
output = rez(2:end);

%% output figure

figure(2)
hold on 
plot(input)
plot(output, 'k-')
% 3 stdevs
plot(above, 'r-')
plot(below, 'b-')
% 9 stedevs
plot(above2,'r:')
plot(below2, 'b:')
legend({'Input', 'Average', 'Ci-high', 'Ci-low'}, 'Location', 'southwest')
grid()
hold off

end