function [x, U] = gauss_elim(A, b)
    
    if (size(b, 2) ~= 1)
        
        b = b.';
    end
    
    numberOfRows = size(A, 1);
    numberOfCols = size(A, 2);

    for diagonalLevel = 1:numberOfRows-1
               
        [~, controlElementIndex] = max(abs(A(diagonalLevel:end, diagonalLevel)));

        controlElementIndex = controlElementIndex + (diagonalLevel - 1);
    
        tempA = A(diagonalLevel, :);
        tempB = b(diagonalLevel);
        A(diagonalLevel, :) = A(controlElementIndex, :);
        b(diagonalLevel) = b(controlElementIndex);
        A(controlElementIndex, :) = tempA;
        b(controlElementIndex) = tempB;
      
        for rowLevel = diagonalLevel + 1:numberOfRows
            
            elementForZeroChange = (- A(rowLevel, diagonalLevel));

            if A(rowLevel, diagonalLevel) == 0
            
                continue;
            end

            for colLevel = diagonalLevel:numberOfCols
            
                A(rowLevel, colLevel) = A(diagonalLevel, colLevel) * ...
                    (elementForZeroChange / A(diagonalLevel, diagonalLevel)) ...
                    + A(rowLevel, colLevel);
            end

            b(rowLevel) = b(diagonalLevel) * ...
                (elementForZeroChange / A(diagonalLevel, diagonalLevel)) ...
                + b(rowLevel);
        end
    end

    norm = cond(A);

    if norm >= 1e16
        
        error('singular');
    end

    U = A;

    for diagonalLevel = numberOfRows:-1:2
        
        for rowLevel = diagonalLevel-1:-1:1
            
            elementForZeroChange = (- A(rowLevel, diagonalLevel));

            if A(rowLevel, diagonalLevel) == 0
            
                continue;
            end

            for colLevel = diagonalLevel:-1:1
            
                A(rowLevel, colLevel) = A(diagonalLevel, colLevel) * ...
                    (elementForZeroChange / A(diagonalLevel, diagonalLevel)) ...
                    + A(rowLevel, colLevel);
            end

            b(rowLevel) = b(diagonalLevel) * ...
                (elementForZeroChange / A(diagonalLevel, diagonalLevel)) ...
                + b(rowLevel);
        end
    end

    x = A \ b;
end