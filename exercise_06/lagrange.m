function yq = lagrange(x, y, xq)
    
    if (size(x, 1) <= 1 && size(x, 2) <= 1) || (size(x, 1) > 1 && size(x, 2) > 1)
        
        error('input x not vector');
    end

    if size(y, 1) <= 1 && size(y, 2) <= 1
        
        error('input y not vector or matrix');
    end

    if isnumeric(xq) == false
        
        error('input xq not vector or scalar or matrix');
    end

    if (length(y) ~= length(x) && ((size(y, 1) > 1 && size(y, 2) == 1) || ...
            (size(y, 1) == 1 && size(y, 2) > 1)))

        error("input x not same length as y");
    end

    if size(y, 1) ~= length(x) && (size(y, 1) > 1 && size(y, 2) > 1)

        error("input x not same length as y1");
    end
    
    yq = 5;
end