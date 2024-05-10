clear;
close all;

% metoda pro vypocet vzdalenosti 3D bodu

d = @(a, b) sqrt((a(1) - b(1))^2 + (a(2) - b(2))^2 + (a(3) - b(3))^2);

% data

% pozice satelitu
x1 = [20180; 21800; 24600];
x2 = [25300; 21400; 23000];
x3 = [22200; 20200; 22600];

% vzdalenost satelitu
d1 = 3.853416925275540e+04;
d2 = 4.030272199244115e+04;
d3 = 3.753709365414429e+04;

% vypocet

% 1. sestavit soustavu nelinearnich rovnic

syms ax ay az;

F = [d([ax; ay; az], x1) - d1;
     d([ax; ay; az], x2) - d2;
     d([ax; ay; az], x3) - d3];

% 2. vytvorit jacobiho matici

J = jacobian(F, [ax, ay, az]);

% 3. prevest soustavu F na function handle

x_sym = [ax; ay; az];

F_handle = matlabFunction(F, 'Vars', {x_sym});

% 4. prevest jacobiho matici na function handle

J_handle = matlabFunction(J, 'Vars', {x_sym});

% 5. najit hledanou moji polohu pomoci newton_raphson

[x, k] = newton_raphson(F_handle, J_handle, ...
    [0; 0; 0], 1e-3, 300);


function [x, k] = newton_raphson(f,J,x0,tol,maxit)
%
% Newton-Raphson method for solution of system of nonlinear equations.
%
% Input:
% f ... multi-parametric function f(x), x being a column vector
% J ... Jacobi matrix
% x0 ... initial guess
% tol ... residuum tolerance
% maxit ... maximal number of iterations
%
% Output:
% x ... found solution
% k ... number iterations
%

    k = 0;
    x = x0;
    res = norm(f(x));

    fprintf('   k     |gradL|\n');
    while (res > tol && k < maxit)
        k = k + 1;
        fx = f(x);
        J(x)
        r = J(x)\fx;
        x = x - r;
        res = norm(fx);
        fprintf('%4d %10g\n', k, res);
    end
end