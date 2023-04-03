webPagesLinks = [0 1 1 1 1;
                 1 0 1 0 0;     
                 1 1 0 0 1;     
                 1 0 1 0 1;     
                 0 0 1 0 0];

webPagesNumber = size(webPagesLinks, 1);
M = zeros(webPagesNumber, webPagesNumber);

for page = 1:webPagesNumber
    
    linksNumber = sum(webPagesLinks(:, page));
    webPageLinks = webPagesLinks(:, page);
    webPageLinks(webPageLinks == 1) = 1 /linksNumber;

    M(:, page) = webPageLinks;
end

[vec, lambda] = mocninna_metoda(M, ones(webPagesNumber, 1), 1e-6, 1000);

websNames = ['A', 'B', 'C', 'D', 'E'];
[~, indeces] = sort(abs(vec));

webs = websNames(indeces);





