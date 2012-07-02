clear all;
close all;

% Project 2.
%
% Students:
%   Alexandru Fikl

n = 10000;                  % number or random numbers
urand = rand(n, 1);         % random numbers

disp('Exercise number format:');
disp(' - first digit - exercise number');
disp(' - second digit - subproblem number');
exercise = input('Give exercise number: ');

switch exercise
    case 31
        % Test the inversion method on the exponential distribution.
        lambda = 1.5;
        y = 0:0.01:10;

        cdf1 = @(x) 1 - exp(-lambda * x);       % comulative distribution function
        icdf1 = @(u) -log(1 - u) / lambda;      % inverse of the cdf
        pdf1 = @(x) lambda * exp(-lambda * x);  % probability density function

        X = icdf1(urand);

        subplot(1, 3, 1);
        hist(X / n, 64);
        subplot(1, 3, 2);
        plot(y, pdf1(y), 'r', 'LineWidth', 2);
        subplot(1, 3, 3);
        hold on;
        cdfplot(X);
        plot(y, cdf1(y), 'r-.');
        hold off;
    case 32
        % Test the Laplace distribution
        lambda = 1;
        mu = 0;
        y = -10:0.01:10;

        cdf1 = @(x) 0.5 * (1 + sign(x - mu) .* (1 - exp(-abs(x - mu)/lambda)));
        icdf1 = @(u) mu - lambda * sign(u - 0.5) .* log(1 - 2 * abs(u - 0.5));
        pdf1 = @(x) 1 / (2 * lambda) * exp(-abs(x - mu)/lambda);

        X = icdf1(urand);

        figure(1)
        subplot(1, 3, 1);
        hist(X / n, 64);
        subplot(1, 3, 2);
        plot(y, pdf1(y), 'r', 'LineWidth', 2);
        subplot(1, 3, 3);
        hold on;
        cdfplot(X);
        plot(y, cdf1(y), 'r-.');
        hold off;
    case 33
        % Test the Weibull distribution
        alpha = 1.5;
        lambda = 1;
        y = 0:0.01:3;

        cdf1 = @(x) 1 - exp(-lambda * x.^alpha);
        icdf1 = @(u) (-log(1 - u) / lambda).^(1/alpha);
        pdf1 = @(x) alpha * lambda * x.^(alpha - 1) .* exp(-lambda * x.^alpha);

        X = icdf1(urand);

        figure(1)
        subplot(1, 3, 1);
        hist(X / n, 64);
        subplot(1, 3, 2);
        plot(y, pdf1(y), 'r', 'LineWidth', 2);
        subplot(1, 3, 3);
        hold on;
        cdfplot(X);
        plot(y, cdf1(y), 'r-.');
        hold off;
    case 34
        % Test the Beta distribution
        alpha = 2;
        betaa = 2;
        y = 0:0.01:1;

        cdf1 = @(x) betainc(x, alpha, betaa);
        icdf1 = @(u) betainv(u, alpha, betaa);
        pdf1 = @(x) x.^(alpha - 1) .* (1 - x).^(betaa - 1) / beta(alpha, betaa);

        X = icdf1(urand);

        figure(1)
        subplot(1, 3, 1);
        hist(X / n, 64);
        subplot(1, 3, 2);
        plot(y, pdf1(y), 'r', 'LineWidth', 2);
        subplot(1, 3, 3);
        hold on;
        cdfplot(X);
        plot(y, cdf1(y), 'r-.');
        hold off;
    case 35
        % Test the Pareto distribution
        alpha = 3;
        lambda = 1;
        y = lambda:0.01:5;

        cdf1 = @(x) 1 - lambda^alpha * x.^(-alpha);
        icdf1 = @(u) lambda ./ ((1 - u).^(1/alpha));
        pdf1 = @(x) alpha * lambda^alpha * x.^(-alpha-1);

        X = icdf1(urand);

        figure(1)
        subplot(1, 3, 1);
        hist(X / n);
        axis([0 5 0 3]);
        subplot(1, 3, 2);
        plot(y, pdf1(y), 'r', 'LineWidth', 2);
        subplot(1, 3, 3);
        hold on;
        cdfplot(X);
        plot(y, cdf1(y), 'r-.');
        axis([0 5 0 1]);
        hold off;
    case 36
        % Test the Cauchy distribution
        gamma = 1;
        x0 = 0;
        y = -4:0.01:4;

        cdf1 = @(x) 1/pi * atan((x - x0) / gamma) + 0.5;
        icdf1 = @(u) x0 + gamma * tan(pi * (u - 0.5));
        pdf1 = @(x) 1 ./ (pi * gamma * (1 + ((x - x0) / gamma).^2));

        X = icdf1(urand);

        subplot(1, 3, 1);
        hist(X / n, 64);
        subplot(1, 3, 2);
        plot(y, pdf1(y), 'r', 'LineWidth', 2);
        subplot(1, 3, 3);
        hold on;
        cdfplot(X);
        plot(y, cdf1(y), 'r-.');
        hold off;
    case 41
        % Test the Bernoulli distribution
        p = 0.7;
        y = -1:0.01:2;

        cdf1 = @(x) (1 - p) * (x > 0 & x < 1) + (x >= 1);
        icdf1 = @(u) floor(p + u);
        pdf1 = @(x) (1 - p) * ( x == 0) + p * (x == 1);

        X = icdf1(urand);

        subplot(1, 3, 1);
        hist(X / n, 64);
        subplot(1, 3, 2);
        plot(y, pdf1(y), 'r', 'LineWidth', 2);
        subplot(1, 3, 3);
        hold on;
        cdfplot(X);
        plot(y, cdf1(y), 'r-.');
        hold off;
    case 42
        % Test the geometric distribution
        p = 0.7;
        y = 1:10;

        cdf1 = @(x) 1 - (1 - p).^x;
        icdf1 = @(u) ceil(log(1 - u) / log(1 - p));
        pdf1 = @(x) (1 - p).^(x - 1) * p;

        X = icdf1(urand);

        subplot(1, 3, 1);
        hist(X / n, 64);
        subplot(1, 3, 2);
        hold on;
        plot(y, pdf1(y), 'r*')
        plot(y, pdf1(y), 'r', 'LineWidth', 1);
        hold off
        subplot(1, 3, 3);
        hold on;
        cdfplot(X);
        plot(y, cdf1(y), 'r*');
        hold off;
    case 43
        % Test the geometric distribution using the Bernoulli distribution.
        % TODO
        p = 0.7;
        y = 1:0.01:10;

        cdf1 = @(x) 1 - (1 - p).^x;
        icdf1 = @(u) ceil(log(1 - u) / log(1 - p));
        pdf1 = @(x) (1 - p).^(x - 1) * p;

        X = icdf1(urand);

        subplot(1, 3, 1);
        hist(X / n, 64);
        subplot(1, 3, 2);
        hold on;
        plot(1:10, pdf1(1:10), 'r*')
        plot(y, pdf1(y), 'r', 'LineWidth', 1);
        hold off
        subplot(1, 3, 3);
        hold on;
        cdfplot(X);
        plot(y, cdf1(y), 'r*');
        hold off;
    case 52
        p = [0.1 0.1 0.8];
        pc = cumsum(p);
        y = 0:0.05:9;

        icdf1 = @(u) 1 * (u <= pc(1)) + 3 * (u <= pc(2) & u > pc(1)) + 8 * (u > pc(2));
        pdf1 = @(x) p(1) * (x == 1) + p(2) * (x == 3) + p(3) * (x == 8);

        X = icdf1(urand);

        subplot(1, 3, 1);
        hist(X / n, 64);
        subplot(1, 3, 2);
        hold on;
        plot(y, pdf1(y), 'r', 'LineWidth', 1);
        hold off
        subplot(1, 3, 3);
        hold on;
        cdfplot(X);
        hold off;
    case 6
        % Test the Poisson distribution
        lambda = 4;
        y = 0:20;

        cdf1 = @(x) gammainc(floor(x + 1), lambda) / factorial(floor(x));
        icdf1 = @(u) poissinv(u, lambda);
        pdf1 = @(x) lambda.^x ./ factorial(x) * e^(-lambda);

        X = icdf1(urand);

        subplot(1, 3, 1);
        hist(X / n, 64);
        subplot(1, 3, 2);
        hold on;
        plot(y, pdf1(y), 'r', 'LineWidth', 1);
        hold off
        subplot(1, 3, 3);
        hold on;
        cdfplot(X);
        plot(y, cdf1(y), 'r');
        hold off;
    case 91
        disp('Not Implemented');
    case 92
        disp('Not Implemented');
    case 93
        disp('Not Implemented');
    case 94
        disp('Not Implemented');
    case 10
        disp('Not Implemented');
    otherwise
        fprintf('Wrong exercise number.\n');
        fprintf('Available exercises are:\n');
        disp([31 32 33 34 35 36 41 42 43 51 52 6  91 92 93 94 10]);
end
