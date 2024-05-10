clear;
close all;

testMatrix1 = [1 1 0; 1 1 1; 0 1 1];
testMatrix2 = [1.5 -6.5 6.5; 1 -6 6.5; 1 -1 1.5];

[v1, l1] = mocninna_metoda(testMatrix1, [1; 1; 1], 1e-15, 1500);
[v2, l2] = mocninna_metoda(testMatrix2, [1; 1; 1], 1e-15, 1500);

tM11 = v1*l1;
tM12 = testMatrix1*v1;

tM21 = v2*l2;
tM22 = testMatrix2*v2;

[v11, l11] = eig(testMatrix1);
[l11, index1] = max(diag(l11));
v11 = v11(:, index1);

[v21, l21] = eig(testMatrix2);
[l21, index2] = max(diag(l21));
v21 = v21(:, index2);



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

[vec, lambda] = mocninna_metoda(M, [1; 1; 1; 1; 1], 1e-15, 1500);

[vec2, lambda2] = eig(M);
[lambda2, index3] = max(diag(lambda2));
vec2 = vec2(:, index3);

websNames = ['A', 'B', 'C', 'D', 'E'];
[~, indeces] = sort(abs(vec));

webs = websNames(indeces);



