function [x,res,k] = newton(f,fp,x0,tol,maxit)
    
    if (size(x0, 1) ~= 1 || size(x0, 2) ~= 1)
        
        error("input x0 not number");
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

    if (isa(fp, "function_handle") == false)
        
        error("input fp not function handle");
    end

    if (nargin(f) ~= 1)
        
        error("input f must have exactly one parameter");
    end

    if (nargin(fp) ~= 1)
        
        error("input fp must have exactly one parameter");
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

    x = x0;
    k = 0;

    while abs(f(x)) >= tol && k < maxit
        
        x = x - f(x) / fp(x); 
        k = k + 1;
        res = f(x);
    end
    
    if k > maxit
        x = NaN;
        res = NaN;
    end
end