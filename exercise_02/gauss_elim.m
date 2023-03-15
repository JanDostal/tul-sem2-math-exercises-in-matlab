function [x, U] = gauss_elim(A, b)
    
    % transponovat vektor b, pokud spatny format
    
    numberOfRows = size(A, 1);
    numberOfCols = size(A, 2);

    for diagonalLevel = 1:numberOfRows-1
       
        
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

    %test na singularitu
    [~, U, ~] = lu(A);
    determinant = prod(diag(U));

    if determinant == 0
        
        error('singular');
    end

    U = A;

    %zpetny chod

    for diagonalLevel = numberOfRows:-1:2
        
        % nasobeni a scitani radku
        for rowLevel = diagonalLevel-1:-1:1
        
            if A(rowLevel, diagonalLevel) == 0
            
                continue;
            end

            for colLevel = diagonalLevel:-1:1
            
                A(rowLevel, colLevel) = A(diagonalLevel, colLevel) * ...
                    (- A(rowLevel, diagonalLevel) / A(diagonalLevel, diagonalLevel)) ...
                    + A(rowLevel, colLevel);
            end

            b(rowLevel) = b(diagonalLevel) * ...
                (- A(rowLevel, diagonalLevel) / A(diagonalLevel, diagonalLevel)) ...
                + b(rowLevel);
        end
    end
    end
end