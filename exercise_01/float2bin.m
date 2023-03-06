function b = float2bin(number, dec_length)
    
	numberIntegerPart = floor(number);
    numberFloatPart = number - numberIntegerPart;
    stringBinaryNumber = "";
    
    if numberIntegerPart ~= 0
    
        index = 0;
        
        while numberIntegerPart ~= 0
        	
            index = index + 1;
            
            binaryNumberIntegerPart(index) = mod(numberIntegerPart, 2);
            numberIntegerPart = floor(numberIntegerPart / 2);
        end
        
        binaryNumberIntegerPart = fliplr(binaryNumberIntegerPart);
    else
    
        binaryNumberIntegerPart(1) = 0;
    end
    
    stringBinaryNumber = stringBinaryNumber + ...
        sprintf("%d", binaryNumberIntegerPart);
    
	if numberFloatPart ~= 0
        
		index = 0;
        
        while numberFloatPart ~= 0 && index < dec_length
        
            index = index + 1;

            numberFloatPart = numberFloatPart * 2;
            partialIntegerPart = floor(numberFloatPart);
            binaryNumberFloatPart(index) = partialIntegerPart;
            numberFloatPart = numberFloatPart - partialIntegerPart;
        end

        stringBinaryNumber = stringBinaryNumber + ...
            "." + sprintf("%d", binaryNumberFloatPart);
    end
    
    b = char(stringBinaryNumber);
end
