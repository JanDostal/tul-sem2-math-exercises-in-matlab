function [candidates] = absolute_divisibility(p)
% Funkce pro nalezení vhodných kandidátů na kořeny polynomu pomocí dělitelnosti absolutního členu
% Vstup: 
%   p - vektor koeficientů polynomu
% Výstup:
%   candidates - pole vhodných kandidátů

% Nalezení absolutní hodnoty koeficientu při nejvyšší mocnině
a = abs(p(end));
% Nalezení všech čísel, kterými je absolutní hodnota koeficientu dělitelná
factors = factor(a);

% Inicializace pole kandidátů
candidates = [];

% Pro každý nalezený dělitel se provede kontrola, zda jím je kořen polynomu
for i = 1:length(factors)
    candidate = -factors(i);
    if polyval(p, candidate) == 0
        candidates = [candidates, candidate];
    end
    
    candidate = factors(i);
    if polyval(p, candidate) == 0
        candidates = [candidates, candidate];
    end
end