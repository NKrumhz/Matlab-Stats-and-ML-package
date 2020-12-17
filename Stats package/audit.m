function [out] = audit(Arg, a, b)
%to mimic the 'summary' function in R.
% When feeding in numeric values this function will return the quantiles
% specified with the standard statistics of min, median, mean, and max. 


% turn argument into a table
if isequal(class(Arg), 'double')
    Arg = array2table(Arg);
    nmes = string(Arg.Properties.VariableNames);
    Arg = table2array(Arg);
elseif isequal(class(Arg), 'table')
   nmes = Arg.Properties.VariableNames;
   Arg = table2array(Arg);
end
%%

if isequal(class(Arg), 'double')

    % default to 1st and 3rd quantile if quantile is not specified. 
    if nargin < 3
        a = 25;
        b = 75;
    end
    [~,y] = size(Arg);
    % Statistics are limited to numeric data
    vals = zeros(6,y);
    vals(1,:) = min(Arg,[],1);
    vals(2,:) = quantl(Arg,a);
    vals(3,:) = median(Arg,'omitnan');
    vals(4,:) = mean(Arg,'omitnan');
    vals(5,:) = quantl(Arg,b);
    vals(6,:) = max(Arg,[],1);
    rowNames = string({"min"; a+"%"; "median"; "mean"; b+"%"; "max"});
    out = array2table(vals,'RowNames',rowNames,'VariableNames', nmes);
else
    error('enter numeric data');
end

% 
if isequal(class(Arg), 'cell')
    mask = unique(Arg);
    vals = cellfun(@(x) sum(ismember(Arg,x)), mask, 'un',0);
    out = table(mask.', vals.');
end