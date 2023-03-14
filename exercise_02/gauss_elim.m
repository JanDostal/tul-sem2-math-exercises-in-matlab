function [x, U] = gauss_elim(A, b)
    
    numberOfRows = size(A, 1);
    numberOfCols = size(A, 2);

    for diagonalLevel = 1:numberOfRows-1
        
        %test na singularitu
        [~, U, ~] = lu(A);
        determinant = prod(diag(U));

        if determinant == 0
        
            error('singular');
        end

        % pivotace
        [~, controlElementIndex] = max(abs(A(diagonalLevel:end, diagonalLevel)));
    
        tempA = A(diagonalLevel, :);
        tempB = b(diagonalLevel);
        A(diagonalLevel, :) = A(controlElementIndex, :);
        b(diagonalLevel) = b(controlElementIndex);
        A(controlElementIndex, :) = tempA;
        b(controlElementIndex) = tempB;
      
        % nasobeni a scitani radku
        for rowLevel = diagonalLevel + 1:numberOfRows
        
            if A(rowLevel, diagonalLevel) == 0
            
                continue;
            end

            for colLevel = diagonalLevel:numberOfCols
            
                A(rowLevel, colLevel) = A(diagonalLevel, colLevel) * ...
                    (- A(rowLevel, diagonalLevel) / A(diagonalLevel, diagonalLevel)) ...
                    + A(rowLevel, colLevel);
            end

            b(rowLevel) = b(diagonalLevel) * ...
                (- A(rowLevel, diagonalLevel) / A(diagonalLevel, diagonalLevel)) ...
                + b(rowLevel);
        end
    end

    U = A;
end