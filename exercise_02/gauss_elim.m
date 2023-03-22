function [x, U] = gauss_elim(A, b)
   
    if size(A, 1) <= 1 || size(A, 2) <= 1
        
        error('input A not matrix');
    end

    if (size(b, 1) <= 1 && size(b, 2) <= 1) || (size(b, 1) > 1 && size(b, 2) > 1)
        
        error('input b not vector');
    end

    if size(b, 2) ~= 1
        
        b = b.';
    end

    if size(A, 1) ~= size(A, 2)
        
        error("input A not square matrix");
    end

    if length(b) ~= size(A, 1)

        error("input b not same length as matrix");
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
    
    x = zeros(numberOfRows, 1);

    for i = 1:numberOfRows
        
        x(i) = b(i) / A(i, i);
    end
end