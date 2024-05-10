clear;
close all;

dataset0 = load("data0.mat", '-ascii');
dataset1 = load("data1.mat", '-ascii');
dataset2 = load("data2.mat", '-ascii');
dataset3 = load("data3.mat", '-ascii');

figure0 = figure(1);

xq_0 = min(dataset0(:, 1)):0.03:max(dataset0(:, 1));
xq_0 = setdiff(xq_0, dataset0(:, 1));

y0_linear = interp1(dataset0(:, 1), dataset0(:, 2), xq_0, "linear");
y0_spline = interp1(dataset0(:, 1), dataset0(:, 2), xq_0, "spline");
y0_pchip = interp1(dataset0(:, 1), dataset0(:, 2), xq_0, "pchip");
y0_makima = interp1(dataset0(:, 1), dataset0(:, 2), xq_0, "makima");
y0_lagrange = lagrange(dataset0(:, 1), dataset0(:, 2), xq_0);

plot(xq_0, y0_linear, "g");
title("Data 0");


hold on;

plot(xq_0, y0_spline, "c");
plot(xq_0, y0_pchip, "b");
plot(xq_0, y0_makima, "m");
plot(xq_0, y0_lagrange, "y");
plot(dataset0(:, 1), dataset0(:, 2),'s','MarkerSize',10,...
    'MarkerEdgeColor','red',...
    'MarkerFaceColor',[1 .6 .6]);

legend('linearní metoda', 'spline metoda', 'pchip metoda', 'makima metoda', 'lagrange metoda', 'Location', 'northeastoutside');
xlabel("interpolanti");
ylabel("hodnoty interpolantů");


figure1 = figure(2);

xq_1 = min(dataset1(:, 1)):0.03:max(dataset1(:, 1));
xq_1 = setdiff(xq_1, dataset1(:, 1));

y1_linear = interp1(dataset1(:, 1), dataset1(:, 2), xq_1, "linear");
y1_spline = interp1(dataset1(:, 1), dataset1(:, 2), xq_1, "spline");
y1_pchip = interp1(dataset1(:, 1), dataset1(:, 2), xq_1, "pchip");
y1_makima = interp1(dataset1(:, 1), dataset1(:, 2), xq_1, "makima");
y1_lagrange = lagrange(dataset1(:, 1), dataset1(:, 2), xq_1);

plot(xq_1, y1_linear, "g");
title("Data 1");

hold on;

plot(xq_1, y1_spline, "c");
plot(xq_1, y1_pchip, "b");
plot(xq_1, y1_makima, "m");
plot(xq_1, y1_lagrange, "y");
plot(dataset1(:, 1), dataset1(:, 2),'s','MarkerSize',10,...
    'MarkerEdgeColor','red',...
    'MarkerFaceColor',[1 .6 .6]);

legend('linearní metoda', 'spline metoda', 'pchip metoda', 'makima metoda', 'lagrange metoda', 'Location', 'northeastoutside');
xlabel("interpolanti");
ylabel("hodnoty interpolantů");

figure2 = figure(3);

xq_2 = min(dataset2(:, 1)):0.03:max(dataset2(:, 1));
xq_2 = setdiff(xq_2, dataset2(:, 1));

y2_linear = interp1(dataset2(:, 1), dataset2(:, 2), xq_2, "linear");
y2_spline = interp1(dataset2(:, 1), dataset2(:, 2), xq_2, "spline");
y2_pchip = interp1(dataset2(:, 1), dataset2(:, 2), xq_2, "pchip");
y2_makima = interp1(dataset2(:, 1), dataset2(:, 2), xq_2, "makima");
y2_lagrange = lagrange(dataset2(:, 1), dataset2(:, 2), xq_2);

plot(xq_2, y2_linear, "g");
title("Data 2");

hold on;

plot(xq_2, y2_spline, "c");
plot(xq_2, y2_pchip, "b");
plot(xq_2, y2_makima, "m");
% plot(xq_2, y2_lagrange, "y"); nevykresluje se, vysvětleno v
% conclusion.txt
plot(dataset2(:, 1), dataset2(:, 2),'s','MarkerSize',10,...
    'MarkerEdgeColor','red',...
    'MarkerFaceColor',[1 .6 .6]);

legend('linearní metoda', 'spline metoda', 'pchip metoda', 'makima metoda', 'Location', 'northeastoutside');
xlabel("interpolanti");
ylabel("hodnoty interpolantů");


figure3 = figure(4);

xq_3 = min(dataset3(:, 1)):0.03:max(dataset3(:, 1));
xq_3 = setdiff(xq_3, dataset3(:, 1));

y3_linear = interp1(dataset3(:, 1), dataset3(:, 2), xq_3, "linear");
y3_spline = interp1(dataset3(:, 1), dataset3(:, 2), xq_3, "spline");
y3_pchip = interp1(dataset3(:, 1), dataset3(:, 2), xq_3, "pchip");
y3_makima = interp1(dataset3(:, 1), dataset3(:, 2), xq_3, "makima");
y3_lagrange = lagrange(dataset3(:, 1), dataset3(:, 2), xq_3);

plot(xq_3, y3_linear, "g");
title("Data 3");

hold on;

plot(xq_3, y3_spline, "c");
plot(xq_3, y3_pchip, "b");
plot(xq_3, y3_makima, "m");
% plot(xq_3, y3_lagrange, "y"); nevykresluje se, vysvětleno v
% conclusion.txt
plot(dataset3(:, 1), dataset3(:, 2),'s','MarkerSize',10,...
    'MarkerEdgeColor','red',...
    'MarkerFaceColor',[1 .6 .6]);

legend('linearní metoda', 'spline metoda', 'pchip metoda', 'makima metoda', 'Location', 'northeastoutside');
xlabel("interpolanti");
ylabel("hodnoty interpolantů");


saveas(figure0, "graph_data0.png");
saveas(figure1, "graph_data1.png");
saveas(figure2, "graph_data2.png");
saveas(figure3, "graph_data3.png");
