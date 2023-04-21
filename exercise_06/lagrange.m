    function yq = lagrange(x, y, xq)
    
    if (size(x, 1) <= 1 && size(x, 2) <= 1) || (size(x, 1) > 1 && size(x, 2) > 1)
        
        error('input x not vector');
    end

    if (size(y, 1) <= 1 && size(y, 2) <= 1) || (size(y, 1) > 1 && size(y, 2) > 1)
        
        error('input y not vector');
    end

    if size(xq, 1) > 1 && size(xq, 2) > 1
        
        error('input xq not vector or scalar');
    end

    if (length(y) ~= length(x) && ((size(y, 1) > 1 && size(y, 2) == 1) || ...
            (size(y, 1) == 1 && size(y, 2) > 1)))

        error("input x not same length as y");
    end

    if length(x) ~= length(unique(x))
        
        error("Sample points must be unique");
    end
    
    x_count = length(x);
    xq_count = length(xq);

    L = zeros(xq_count, x_count);
    yq = zeros(1, xq_count);

    if size(y, 1) == 1 && size(y, 2) > 1

        y = y.';
    end

    for currentXqIndex = 1:xq_count
        
        if xq(currentXqIndex) < min(x) || xq(currentXqIndex) > max(x)
                
            L(currentXqIndex, :) = NaN;
        else
            
            for currentXIndex = 1:x_count
            
                L(currentXqIndex, currentXIndex) = prod(xq(currentXqIndex) - x([1:currentXIndex-1, currentXIndex+1:end])) / ... 
                    prod(x(currentXIndex) - x([1:currentXIndex-1, currentXIndex+1:end]));
            end
        end

        yq(currentXqIndex) = L(currentXqIndex, :) * y;
        
    end

    if size(xq, 1) > 1 && size(xq, 2) == 1
        
        yq = yq.';
    end
end