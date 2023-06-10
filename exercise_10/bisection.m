function [x,res,k] = bisection(f,a,b,tol,maxit)
    if (size(a, 1) ~= 1 || size(a, 2) ~= 1)
        
        error("input a not number");
    end

    if (size(b, 1) ~= 1 || size(b, 2) ~= 1)
        
        error("input b not number");
    end

    if (size(maxit, 1) ~= 1 || size(maxit, 2) ~= 1)
        
        error("input maxit not number");
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

    if (maxit ~= floor(maxit))
        
        error("input maxit not integer");
    end

    if (tol <= 0)
        
        error("input tol not greater than 0");
    end

    if (maxit <= 0)
        
        error("input maxit not 1 or greater");
    end

    if f(a) * f(b) >= 0
        x = NaN;
        res = NaN;
        k = 0;
        return;
    end
    
    currentIt = 0;

    while (currentIt < maxit)
        
        currentIt = currentIt + 1;
    
        s = (a + b) / 2;

        if abs(f(s)) < tol
            
            x = s;
            res = f(s);
            k = currentIt;
            return;
        end
        
        if f(a) * f(s) < 0
            
            b = s;
        else 
            a = s;
        end
    end
    
    x = NaN;
    res = NaN;
    k = currentIt;
end
