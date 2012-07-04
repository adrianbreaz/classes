clear all;
close all;

% Project 5.
%
% Students:
%   Alexandru Fikl
%   Adrian Breaz

disp('Exercise number format:');
disp(' - first digit: exercise number');
disp(' - second digit: subproblem number (none if it does not have one)');
exercise = input('Give exercise number: ');

switch exercise
    case 2
        n = 10000;
        X = rand(n, 1);
        
        f = @(x) exp(x);
        g = @(x) (exp(x) + exp(1 - x)) / 2;
        
        fprintf('Exact %g.\n', exp(1) - 1)
        fprintf('Monte Carlo %g.\n', mean(f(X)));
        fprintf('Better Monte Carlo %g.\n', mean(g(X)));
    case 3
        n = 10000;
        X = 2 * rand(n, 1);
        
        f = @(x) 2 * x.^2;
        
        fprintf('Exact %g\n', 8/3);
        fprintf('1. Monte Carlo %g.\n', mean(f(X)));
        fprintf('   Variance: %g\n', var(2 * X.^2));
        
        Y = rand(n, 1);
        
        pdf1 = @(x) x / 2;
        cdf1 = @(x) x.^2 / 4;
        icdf1 = @(u) sqrt(4 * u);
        
        Y = icdf1(Y);
        f = @(x) 2 * x;
        
        fprintf('2. Monte Carlo %g.\n', mean(f(Y)));
        fprintf('   Variance: %g\n', var(2 * Y));
        
        X = rand(n, 1);
        
        f = @(x) x.^2 + (2 - x).^2;
        
        fprintf('3. Monte Carlo %g.\n', mean(f(X)));
        fprintf('   Variance: %g\n', var(X.^2 + (2 - X).^2));
    case 41
        gamma = 1;
        x0 = 0;
        n = 10000;
        X = rand(n, 1);
        
        icdf1 = @(u) x0 + gamma * tan(pi * (u - 0.5));
        
        X = icdf1(X);
        f = @(x) x >= 2;
        meanx = mean(f(X));
        varx = var(f(X));
        lower = meanx - normcdf(0.95) * sqrt(varx / n);
        upper = meanx + normcdf(0.95) * sqrt(varx / n);
        
        fprintf('E[X] %g.\n', meanx);
        fprintf('Var[X]: %g\n', varx);
        fprintf('p in [%g, %g]\n', lower, upper);
    case 42
        gamma = 1;
        x0 = 0;
        n = 10000;
        X = rand(n, 1);
        
        icdf1 = @(u) x0 + gamma * tan(pi * (u - 0.5));
        f = @(x) ((x >= 2) + (x <= -2)) / 2;
        
        X = icdf1(X);
        meanx = mean(f(X));
        varx = var(f(X));
        lower = meanx - normcdf(0.95) * sqrt(varx / n);
        upper = meanx + normcdf(0.95) * sqrt(varx / n);
        
        fprintf('E[X] %g.\n', meanx);
        fprintf('Var[X]: %g\n', varx);
        fprintf('p in [%g, %g]\n', lower, upper);
    case 43
        n = 10000;
        X = 2 * rand(n, 1);
        f = @(x) 2 ./ (pi * (1 + x.^2));
        
        fprintf('p = %g.\n', 0.5 - mean(f(X)));
        fprintf('Var[X]: %g\n', var(f(X)));
    case 44
        n = 10000;
        X = 0.5 * rand(n, 1);
        f = @(x) 0.5 * x.^(-2) ./ (pi * (1 + x.^(-2)));
        
        fprintf('p = %g.\n', mean(f(X)));
        fprintf('Var[X]: %.10f\n', var(f(X)));
    otherwise
        fprintf('Wrong exercise number.\n');
        fprintf('Available exercises are:\n');
        disp([2 3 4]);
end
