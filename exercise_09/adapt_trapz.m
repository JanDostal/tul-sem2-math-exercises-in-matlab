function [I,k] = adapt_trapz(f,a,b,maxlevel,tol)

    if (size(a, 1) ~= 1 ||size(a, 2) ~= 1)
        
        error("input a not number");
    end

    if (size(b, 1) ~= 1 ||size(b, 2) ~= 1)
        
        error("input b not number");
    end

    if (size(maxlevel, 1) ~= 1 || size(maxlevel, 2) ~= 1)
        
        error("input maxlevel not number");
    end

    if (size(tol, 1) ~= 1 || size(tol, 2) ~= 1)
        
        error("input tol not number");
    end

    if (isa(f, "function_handle") == false)
        
        error("input f not function handle");
    end

    if (nargin(f) ~= 1)
        
        error("input f must have exactly one parameter");
    end

    if (maxlevel ~= floor(maxlevel))
        
        error("input maxlevel not integer");
    end

    if (tol < 0)
        
        error("input tol not 0 or greater");
    end

    if (maxlevel <= 0)
        
        error("input maxlevel not 1 or greater");
    end
    
    I = 0;
    currentLevel = 0;
   
    while (currentLevel < maxlevel)
        
        subIntervalWidth = (b - a) / (2^currentLevel);

        x = a:subIntervalWidth:b;
        y = f(x);

        I_prev = I;

        heightsOfSubIntervals = (y(1:end-1) + y(2:end));

        I = sum(heightsOfSubIntervals) * subIntervalWidth / 2;

        if currentLevel > 0 && abs(I - I_prev) < tol
            
            break;
        end
        
        currentLevel = currentLevel + 1;
    end
       
    k = currentLevel;
end