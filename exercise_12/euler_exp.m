function [t,y] = euler_exp(f,a,b,y0,h)
    
     if (size(a, 1) ~= 1 || size(a, 2) ~= 1)
        
        error("input a not number");
    end

    if (size(b, 1) ~= 1 || size(b, 2) ~= 1)
        
        error("input b not number");
    end

    if (size(y0, 1) > 1 && size(y0, 2) > 1) || ...
        size(y0, 1) == 0 || size(y0, 2) == 0
        
        error("input y0 not vector or scalar");
    end

    if (size(h, 1) ~= 1 || size(h, 2) ~= 1)
        
        error("input h not number");
    end

    if (isa(f, "function_handle") == false)
        
        error("input f not function handle");
    end

    if (nargin(f) ~= 2)
        
        error("input f must have exactly two parameters");
    end
    
    t = a:h:b; % rozdeleni na intervaly

    pocet_intervalu = length(t); % n/pocet intervalu

    y = zeros(length(y0), pocet_intervalu); % vysledny y
    % pocet radku podle poctu pocatecnich y
    % pocet sloupcu podle poctu intervalu

    y(:, 1) = y0; % prirazeni pocatecnich hodnot y0
    
    % vypocet
    for i = 1:pocet_intervalu-1

        y(:, i+1) = y(:, i) + h*f(t(i), y(:, i)); % aproximace doprednou diferenci
    end    
end