function [x, M] = find_int_roots(p)

    %ocekavany prvni prvek p jako nejvyssi mocnina

    if isempty(p) || (size(p, 1) > 1 && size(p, 2) > 1)
        
        error('input p not vector or scalar');
    end

    if size(p, 1) == 1 && size(p, 2) == 1
        
        x = [];
        M = [];
        return;
    end
    
    %veta o omezenosti korenu

    flippedP = flip(p);
    n = length(p);
    A = max(abs(flippedP(1:n-1)));
    upperBound = 1 + A/abs(flippedP(n));
    lowerBound = -upperBound;

    if isinf(upperBound)        
        x = [];
        M = [];
        return;
    end

    %veta o dělitelnosti absolutniho clenu

    divisorsCandidates = divisors(flippedP(1));
    negativeDivisors = divisorsCandidates(divisorsCandidates > 0) * -1;

    if isempty(negativeDivisors) == false
    
        divisorsCandidates(end + 1: end + length(negativeDivisors)) = negativeDivisors;
    end

    %kombinace dělitelnosti a omezenosti
    
    rootsBordersInterval = [];

    if lowerBound > 0
        
        rootsBordersInterval = upperBound:lowerBound;
    else
        rootsBordersInterval = lowerBound:upperBound;
    end

    candidates = divisorsCandidates(ismember(divisorsCandidates, rootsBordersInterval));
    candidates = [candidates, rootsBordersInterval(not(ismember(rootsBordersInterval, divisorsCandidates)))];

    %hornerovo schema
    
    candidatesCount = length(candidates);
    polynomialDegree = length(p) - 1;
    foundXCount = 0;
    currentCandidateIndex = 1;
    x = [];
    M = zeros(1 + polynomialDegree, length(p));
    M(1, :) = p;
    tempM = p;

    while foundXCount < polynomialDegree && currentCandidateIndex <= candidatesCount
    
        b = 0;
        candidate = candidates(currentCandidateIndex);

        for i = 1:length(tempM)
        
            b(end + 1) = b(end)*candidate + tempM(i);
        end

        b = b(2:end);

        if b(end) == 0
        
            b = b(1:end-1);
            currentCandidateIndex = currentCandidateIndex - 1;
            foundXCount = foundXCount + 1;

            M(1 + foundXCount, 1:length(b)) = b;
            tempM = b;
            x(end + 1) = candidate;
        end

        currentCandidateIndex = currentCandidateIndex + 1;
    end
    
    x = x.';
    M(not(any(M,2)), :) = [];
end

