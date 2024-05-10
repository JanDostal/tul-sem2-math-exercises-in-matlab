clear;
close all;

roots1 = roots([1 -4 2 2 1 6]);
[x1, M1] = find_int_roots([1 -4 2 2 1 6]);

roots2 = roots([1 -3 3 -1]);
[x2, M2] = find_int_roots([1 -3 3 -1]);

roots3 = roots([1, 37]);
[x3, M3] = find_int_roots([1, 37]);

roots4 = roots([10, -120]);
[x4, M4] = find_int_roots([10, -120]);

roots5 = roots([1 4 -15 -70 -16 96]);
[x5, M5] = find_int_roots([1 4 -15 -70 -16 96]);

roots6 = roots([1 1 -3 -7 -40 -60]);
[x6, M6] = find_int_roots([1 1 -3 -7 -40 -60]);

roots7 = roots([7 7 -21 -49 -280 -420]);
[x7, M7] = find_int_roots([7 7 -21 -49 -280 -420]);

roots8 = roots([1 1 -3 -7 -40 -60 0 0]);
[x8, M8] = find_int_roots([1 1 -3 -7 -40 -60 0 0]);