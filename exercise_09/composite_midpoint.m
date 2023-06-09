function I = composite_midpoint(f,a,b,n)

    if (size(n, 1) ~= 1 || size(n, 2) ~= 1)
        
        error("input n not number");
    end

    if (size(a, 1) ~= 1 ||size(a, 2) ~= 1)
        
        error("input a not number");
    end

    if (size(b, 1) ~= 1 ||size(b, 2) ~= 1)
        
        error("input b not number");
    end

    if (isa(f, "function_handle") == false)
        
        error("input f not function handle");
    end

    if (nargin(f) ~= 1)
        
        error("input f must have exactly one parameter");
    end

    if (n ~= floor(n))
        
        error("input n not integer");
    end

    if (n <= 0)
        
        error("input n not 1 or greater");
    end
    
    totalIntervalSize = b - a;
    subIntervalSize = totalIntervalSize / n;
    
    firstRectangleMidPoint = a + subIntervalSize / 2;
    lastRectangleMidPoint = b - subIntervalSize / 2;

    subIntervalsRectanglesMiddlePoints = firstRectangleMidPoint:subIntervalSize:lastRectangleMidPoint;

    subIntervalsHeights = f(subIntervalsRectanglesMiddlePoints);

    subIntervalsHeights(isnan(subIntervalsHeights)) = 0;
    
    rectanglesAreas = subIntervalsHeights * subIntervalSize;
    
    I = sum(rectanglesAreas);

end