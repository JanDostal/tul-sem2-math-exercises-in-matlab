function [x,res,k] = newton_diff(f,x0,x1,tol,maxit)
    
    if (size(x0, 1) ~= 1 || size(x0, 2) ~= 1)
        
        error("input x0 not number");
    end
    
    if (size(x1, 1) ~= 1 || size(x1, 2) ~= 1)
        
        error("input fp not number");
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

    k = 0;

    while abs(f(x1)) >= tol && k < maxit

        x = x1 - f(x1) * ((x1 - x0) / (f(x1) - f(x0))); 
        k = k + 1;

        res = (f(x));
        x0 = x1;
        x1 = x;
    end
    
    if k > maxit
        x = NaN;
        res = NaN;
    end
end
