function [x, U] = gauss_elim(A, b)
    
    [controlElement, controlElementIndex] = max(A(:, 1));
    
    temp = A(1, :);
    A(1, :) = A(controlElementIndex, :);
    A(controlElementIndex, :) = temp;

    [~, U, ~] = lu(M);
    determinantTest = prod(diag(U));
end