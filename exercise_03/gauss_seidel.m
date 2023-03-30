function [x,flag,rr,it,rv] = gauss_seidel(A,b,tol,maxit)
    
    if size(A, 1) <= 1 || size(A, 2) <= 1
        
        error('input A not matrix');
    end

    if (size(b, 1) <= 1 && size(b, 2) <= 1) || (size(b, 1) > 1 && size(b, 2) > 1)
        
        error('input b not vector');
    end

    if size(b, 2) ~= 1
        
        error('input b not column vector');
    end

    if size(A, 1) ~= size(A, 2)
        
        error("input A not square matrix");
    end

    if length(b) ~= size(A, 1)

        error("input b not same length as matrix");
    end
    
    
    if isempty(tol)
        
        tol = 1e-6;
    elseif size(tol, 1) > 1 || size(tol, 2) > 1

        tol = 1;
    elseif tol <= 0

        tol = 2.2e-16;
    end
    
    if isempty(maxit)
        
        maxit = min(size(A, 1), 20);
    elseif size(maxit, 1) > 1 || size(maxit, 2) > 1

        error("maxit must be scalar");
    elseif maxit < 0

        maxit = 0;
    end
    
    x = b;
    bNorm = norm(b);
    rv = norm(b-A*x);
    rr = rv / bNorm;

    k = 1;
    it = 0;

    while k <= maxit && rr > tol
        
        x0 = x;
        it = k;

        for i = 1:1:size(A, 1)
            
            firstSum = A(i, 1:i-1) * x(1:i-1);
            secondSum = A(i, i + 1:size(A, 1)) * x0(i + 1:size(A, 1));

            x(i) = 1/A(i, i) * (b(i) - firstSum - ...
                secondSum);
        end
        
        rv(end + 1) = norm(b-A*x);
        rr = rv(end) / bNorm;

        if isnan(rr) || isinf(rr) 
            
            flag = 4;
            rv = rv.';
            return;
        end

        k = k + 1;
    end

    if rr <= tol
        
        flag = 0;
    else

        flag = 1;
    end

    rv = rv.';
end