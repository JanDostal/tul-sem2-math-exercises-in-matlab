function [x, M] = find_int_roots(p)
 n = length(p) - 1; 
x = [];
M = []; 

candidates = [];
if p(1) == 0
    candidates = [candidates, 0];
end
for i = 1:abs(p(n+1))
    if mod(p(n+1), i) == 0
        candidates = [candidates, i, -i];
    end
end


A = max(abs(p(1:n))) / abs(p(n+1));
lb = -1 - A/abs(p(n+1));
ub = 1 + A/abs(p(n+1));
discr = length(find(p(2:end) .* p(1:end-1) < 0)) - 2*mod(n-1, 2);
for i = floor(lb):ceil(ub)
    if sum(p.*i.^[n:-1:0]) == 0
        candidates = [candidates, i];
    end
end


for i = 1:length(candidates)
    k = candidates(i);
    q = p;
    r = q(1);
    M_tmp = zeros(n, 2); 
    for j = 2:n+1
        r = r*k + q(j);
        q(j) = q(j) + q(j-1)*k;
        if j <= n
           
            M_tmp(j-1, :) = [q(j), r];
        end
    end
    if r == 0
        x = [x, k]
        M = [M; M_tmp];
    end
end