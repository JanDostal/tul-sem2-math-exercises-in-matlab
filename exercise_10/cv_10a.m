clear;
close all;

syms x_sym;

a = 16;
f_druha_odmocnina = @(x) x.^2 - a;

fp_druha_odmocnina = diff(f_druha_odmocnina(x_sym));
fp_druha_odmocnina = matlabFunction(fp_druha_odmocnina);

% newton

tol = 1e-5;
maxit = 20;

[x_1, res_1, k_1] = newton(f_druha_odmocnina, fp_druha_odmocnina, 2, tol, maxit);

disp(['Výsledek newton pro druhou odmocninu: x = ', num2str(x_1)]);
disp(['Relativní reziduum newton pro druhou odmocninu: res = ', num2str(res_1)]);
disp(['Počet iterací newton pro druhou odmocninu: k = ', num2str(k_1)]);

% newton_diff
[x_2, res_2, k_2] = newton_diff(f_druha_odmocnina, 2, 1, tol, maxit);

disp(['Výsledek newton_diff pro druhou odmocninu: x = ', num2str(x_2)]);
disp(['Relativní reziduum newton_diff pro druhou odmocninu: res = ', num2str(res_2)]);
disp(['Počet iterací newton_diff pro druhou odmocninu: k = ', num2str(k_2)]);

% bisection

[x_3, res_3, k_3] = bisection(@(x) 5.*x - 10, -1, 5, tol, maxit);

disp(['Výsledek bisection pro 5x - 10: x = ', num2str(x_3)]);
disp(['Relativní reziduum bisection pro 5x - 10: res = ', num2str(res_3)]);
disp(['Počet iterací bisection pro 5x - 10: k = ', num2str(k_3)]);

% uloha

axe_a = 1;
axe_b = 0.5;
max_iter = 50;
tolerance = 1e-8;

g = @(x) log(x + 0.5); % g(x)le
ellipse = @(x) sqrt(axe_b^2 * (1 - (x/axe_a).^2)); % muze byt +-, protoze odmocnina,
% odvozeno z (x/a)^2 + (y/b)^2 = 1

ellipse_above_g = @(x) ellipse(x) - g(x); % situace +, elipsa je nad g(x) funkci
ellipse_under_g = @(x) - ellipse(x) - g(x); %situace -, elipsa je pod g(x) funkci

equation_non_linear = @(x) ellipse_above_g(x) + ellipse_under_g(x); % nelinearni funkce, spojim 
% obe situace ellipse_above_g a ellipse_under_g

fp_non_linear = diff(equation_non_linear(x_sym));
fp_non_linear = matlabFunction(fp_non_linear);

fp_ellipse_above_g = diff(ellipse_above_g(x_sym));
fp_ellipse_above_g = matlabFunction(fp_ellipse_above_g);

fp_ellipse_under_g = diff(ellipse_under_g(x_sym));
fp_ellipse_under_g = matlabFunction(fp_ellipse_under_g);

% vykresleni

theta = linspace(0, 2*pi, 25);
x = axe_a * cos(theta); %parametricke vyjadreni elipsy
y = axe_b * sin(theta); %parametricke vyjadreni elipsy

fig = figure(1);
plot(x, y, 'b', 'LineWidth', 2); % Elipsa
hold on;
plot(-1:0.1:1, g(-1:0.1:1), 'r', 'LineWidth', 2);  % Funkce g(x)
plot(-2:0.1:1, equation_non_linear(-2:0.1:1) ,"g", 'LineWidth', 2); %nelinearni funkce
xlabel('x');
ylabel('y');
title('Graf elipsy a funkce g(x)');

pocatecni_x0_prusecik_X1 = 0.09; % dolni cast elipsy
pocatecni_x1_prusecik_X1 = 0.1; % dolni cast elipsy
pocatecni_x0_prusecik_X2 = 0.85; %horni cast elipsy
pocatecni_x1_prusecik_X2 = 0.9; %horni cast elipsy
    
[x1_newton, res_x1_newton, iter_x1_newton] = ...
newton(ellipse_under_g, fp_ellipse_under_g, ...
    pocatecni_x0_prusecik_X1, tolerance, max_iter);

[x2_newton, res_x2_newton, iter_x2_newton] = ...
newton(ellipse_above_g, fp_ellipse_above_g, ...
    pocatecni_x0_prusecik_X2, tolerance, max_iter);

[x1_diff, res_x1_diff, iter_x1_diff] = newton_diff(ellipse_under_g, pocatecni_x0_prusecik_X1, pocatecni_x1_prusecik_X1, tolerance, max_iter);
[x2_diff, res_x2_diff, iter_x2_diff] = newton_diff(ellipse_above_g, pocatecni_x0_prusecik_X2, pocatecni_x1_prusecik_X2, tolerance, max_iter);

lowerBound_a_x1 = 0.08; %dolni cast elipsy
upperBound_b_x1 = 0.12; %dolni cast elipsy
lowerBound_a_x2 = 0.78; %horni cast elipsy
upperBound_b_x2 = 0.83; %horni cast elipsy

[x1_bisection, res_x1_bisection, iter_x1_bisection] = bisection(ellipse_under_g, lowerBound_a_x1, upperBound_b_x1, tolerance, max_iter);
[x2_bisection, res_x2_bisection, iter_x2_bisection] = bisection(ellipse_above_g, lowerBound_a_x2, upperBound_b_x2, tolerance, max_iter);

x1 = x1_bisection; %nalezene pruseciky funkce g(x) a elipsy
x2 = x2_bisection; %nalezene pruseciky funkce g(x) a elipsy

plot(x1, -ellipse(x1), '-s','MarkerSize',10,...
    'MarkerEdgeColor','red',...
    'MarkerFaceColor', 'red'); % pruseciky elipsy s g(x) - dolni cast elipsy
% - jelikoz v ramci elipsy x muze mit vice y, vyberu to
% dolni y

plot(x2, ellipse(x2), '-s','MarkerSize',10,...
    'MarkerEdgeColor','yellow',...
    'MarkerFaceColor', 'yellow'); % pruseciky elipsy s g(x) - 
% horni cast elipsy - jelikoz v ramci elipsy x muze mit vice y, vyberu to
% horni y

intersection_non_linear_x_roots = solve(equation_non_linear(x_sym) == 0); % nalezeni pruseciku 
% nelinearni funkce a na ose y = 0

plot(intersection_non_linear_x_roots, equation_non_linear(intersection_non_linear_x_roots), '-s','MarkerSize',10,...
    'MarkerEdgeColor','blue',...
    'MarkerFaceColor', 'blue'); % vykresleni techto pruseciku

legend('Elipsa', 'g(x)', 'Nelinearni funkce', 'x1', 'x2', 'pruseciky nelinearni funkce');
grid on;
xlim([-2, 2]);
ylim([-2, 2]);

saveas(fig, "graph.png");