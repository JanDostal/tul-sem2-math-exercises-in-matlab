function [k, q] = lin_regression(x, y)

    if (size(x, 1) <= 1 && size(x, 2) <= 1) || (size(x, 1) > 1 && size(x, 2) > 1)
        
        error('input x not vector');
    end

    if (size(y, 1) <= 1 && size(y, 2) <= 1) || (size(y, 1) > 1 && size(y, 2) > 1)
        
        error('input y not vector');
    end

    if (length(y) ~= length(x))

        error("input x not same length as y");
    end
    
    if (size(x, 2) > 1)
        
        x = x.';
    end

    if (size(y, 2) > 1)
        
        y = y.';
    end

    A = [x, ones(length(x), 1)];
    b = y;

    AT = A.';

    %sum_x2 = sum(x(1:end) .* x(1:end));
    %sum_x = sum(x(1:end));
    %n = length(x);
    %sum_xy = sum(x(1:end) .* y(1:end));
    %sum_y = sum(y(1:end));

    lineParams = (AT * A) \ (AT * b);
    %lineParams = [sum_x2, sum_x; sum_x, n] \ [sum_xy; sum_y];

    k = lineParams(1);
    q = lineParams(2);

end