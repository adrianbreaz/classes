clear all;
close all;
addpath('../projet-4');
addpath('../projet-3');

% Project 5: Variance reduction.
%
% Students:
%   Alexandru Fikl
%   Adrian Breaz
%
% Description: we try to make the variance of our sample using different methods.
% For example for a U[0, 1], Var[(g(U) + g(1 - U)) / 2] < Var[g(U)]. By reducing
% the variance we also decrease the approximation error.

n = 10000;

disp([2 3 41 42 43 44]);
exercise = input('Give exercise number: ');

switch exercise
    case 2
        % for g(x) = exp(x) and X ~ U[0, 1] compute E[g(X)] and
        % E[(g(x) + g(1 - x)) / 2].
        f = @(x) exp(x);
        g = @(x) (exp(x) + exp(1 - x)) / 2;

        If = montecarlo(f, @(x, y) 0, @(x) x, [0 1 0 1], n);
        Ig = montecarlo(g, @(x, y) 0, @(x) x, [0 1 0 1], n);

        fprintf('Exact:              %g.\n', exp(1) - 1);
        fprintf('Monte Carlo:        %g.\n', If);
        fprintf('Better Monte Carlo: %g.\n', Ig);
    case 3
        % We will try and approximate:
        %   \int_0^2 x^2 dx = 8/3
        % by different methods given that X ~ U[0, 2].
        %
        % Method 1: by computing E[2 * X^2].
        f = @(x, y) 2 * x.^2;

        [I, varf] = montecarlo(f, @(x, y) 0, @(x) x, [0 2 0 1], n);

        fprintf('Exact %g\n', 8/3);
        fprintf('1. Monte Carlo %g.\n', I);
        fprintf('   Variance: %g\n', varf);

        % Method 2: by computing E[2 * Y] where Y has the PDF:
        %       f(y) = y / 2 * 1_{[0, 2]}(y)
        % which means that the CDF is y^2 / 4 and its inverse:
        icdf1 = @(u) sqrt(4 * u);
        f = @(x, y) 2 * x;

        [I, varf] = montecarlo(f, @(x, y) 0, icdf1, [0 1 0 1], n);

        fprintf('2. Monte Carlo %g.\n', I);
        fprintf('   Variance: %g\n', varf);

        % Method 3: by computing E[X^2 + (2 - X)^2] where X ~ U[0, 2].
        f = @(x, y) x.^2 + (2 - x).^2;

        [I, varf] = montecarlo(f, @(x, y) 0, @(x) x, [0 1 0 1], n);

        fprintf('3. Monte Carlo %g.\n', I);
        fprintf('   Variance: %g\n', varf);
    case 41
        % We want to estimate p = P(X >= 2) where X ~ Cauchy(0, 1)
        % First try: p = E[1_{X >= 2}]
        icdf1 = @(u) tan(pi * (u - 0.5));
        f = @(x, y) x >= 2;

        [mux, varx] = montecarlo(f, @(x, y) 0, icdf1, [0 1 0 1], n);
        lower = mux - tinv(0.975, n - 1) * sqrt(varx / n);
        upper = mux + tinv(0.975, n - 1) * sqrt(varx / n);

        fprintf('mean:     %g.\n', mux);
        fprintf('variance: %g\n', varx);
        fprintf('p in      [%g, %g]\n', lower, upper);
    case 42
        % Second try: p = E[(1_{X >= 2} + 1_{X <= -2}) / 2]
        icdf1 = @(u) tan(pi * (u - 0.5));
        f = @(x, y) ((x >= 2) + (x <= -2)) / 2;

        [mux, varx] = montecarlo(f, @(x, y) 0, icdf1, [0 1 0 1], n);
        lower = mux - tinv(0.975, n - 1) * sqrt(varx / n);
        upper = mux + tinv(0.975, n - 1) * sqrt(varx / n);

        fprintf('mean       %g.\n', mux);
        fprintf('variance:  %g\n', varx);
        fprintf('p in       [%g, %g]\n', lower, upper);
    case 43
        % Third try: p = 0.5 - \int_0^2 f_{Cauchy(0, 1)} dx.
        f = @(x) 2 ./ (pi * (1 + x.^2));

        [I, varf] = montecarlo(f, @(x, y) 0, @(x) x, [0 2 0 1], n);
        fprintf('p =  %g.\n', 0.5 - I);
        fprintf('Var: %g\n', varf);
    case 44
        % Fourth try: p = \int_0^{0.5} x^-2 / (pi * (1 + x^-2)) dx
        f = @(x) 0.5 * x.^(-2) ./ (pi * (1 + x.^(-2)));

        [I, varf] = montecarlo(f, @(x, y) 0, @(x) x, [0 0.5 0 1], n);
        fprintf('p = %g.\n', I);
        fprintf('Var: %.10f\n', varf);
    otherwise
        fprintf('Wrong exercise number.\n');
end
