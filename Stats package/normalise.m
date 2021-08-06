function [X, cntr] = normalise(Data, method)
    % Syntax: bootstrap = bootstp(statistic, Data)
    %


    if isstring(method)

    
        switch method
        case 'norm'
            a = min(Data);
            b = range(Data); 
        case 'std'
            a = mean(Data);
            b = std(Data);
        end
    elseif isnumeric(method)
        a = method[1];
        b = method[2];
    end

    X = (X - a)/b;
    cntr = [a;b]
end