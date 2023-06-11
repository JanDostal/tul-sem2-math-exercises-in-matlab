function [t,y] = euler_imp(f,a,b,y0,h)
    
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

    maxit = 1000; % maximalni pocet iteraci (metoda secen)
    tol = 1e-3; % tolerance  (metoda secen)

    for i = 1:pocet_intervalu-1

        x0 = y(:, i); % pocatecni hodnota (metoda secen)
        x1 = y(:, i + 1); % nasledujici hodnota (metoda secen)
        k = 0; % aktualni iterace (metoda secen)
        
        while k < maxit
            g = @(x) x - x0 - h * f(t(i+1), x); % newtonova metoda (z pdf na classroom)
            x = x1 - g(x1) .* ((x1 - x0) ./ (g(x1) - g(x0))); % vzorec z metody secen
            k = k + 1;

            if norm(g(x)) < tol
                break;
            end
                
            x0 = x1;
            x1 = x;
        end
        
        if k > maxit
            x = NaN;
        end
        
        y(:, i + 1) = x; % aktualizace vsech hodnot y v danem intervalu
    end
end