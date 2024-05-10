clear;
close all;

regularMatrix = pascal(4);

[x, U] = gauss_elim(regularMatrix, [1; 1; 1; 1]);

x_alternative = regularMatrix \ [1; 1; 1; 1];
[~, U_alternative] = lu(regularMatrix);







