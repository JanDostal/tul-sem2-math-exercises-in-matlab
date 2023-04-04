function [vec, lambda] = mocninna_metoda(A, y0, tol, maxit)
    
    if size(A, 1) <= 1 || size(A, 2) <= 1
        
        error('input A not matrix');
    end

    if (size(y0, 1) <= 1 && size(y0, 2) <= 1) || (size(y0, 1) > 1 && size(y0, 2) > 1)
        
        error('input b not vector');
    end

    if size(y0, 2) ~= 1
        
        error('input b not column vector');
    end

    if size(A, 1) ~= size(A, 2)
        
        error("input A not square matrix");
    end

    if length(y0) ~= size(A, 1)

        error("input b not same length as matrix");
    end
    
    if isempty(tol) || size(tol, 1) > 1 || size(tol, 2) > 1 || tol <= 0
        
        tol = 1e-6;
    end

    if isempty(maxit) || size(maxit, 1) > 1 || size(maxit, 2) > 1 || maxit <= 0
        
        maxit = 1000;
    end

    y0 = y0/norm(y0);

    for i = 1:maxit

        y = A * y0;
        lambda = y0' * y;
        y = y/norm(y);

        if norm(y - y0) < tol

            break;
        end

        y0 = y;
    end

    vec = y;
end