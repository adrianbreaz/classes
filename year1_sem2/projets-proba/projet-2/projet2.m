clear all;
close all;

% Project 2.
%
% Students:
%   Alexandru Fikl

n = 10000;                  % number or random numbers
urand = rand(n, 1);         % random numbers

disp('Exercise number format:');
disp(' - first digit: exercise number');
disp(' - second digit: subproblem number (none if it does not have one)');
exercise = input('Give exercise number: ');

switch exercise
    case 31
        % Test the inversion method on the exponential distribution.
        fprintf('Test for the exponential distribution.\n');
        n = input('Give n: ');
        lambda = input('Give lambda: ');
        urand = rand(n, 1);
        y = 0:0.01:10;

        cdf1 = @(x) 1 - exp(-lambda * x);       % comulative distribution function
        icdf1 = @(u) -log(1 - u) / lambda;      % inverse of the cdf
        pdf1 = @(x) lambda * exp(-lambda * x);  % probability density function

        X = icdf1(urand);

        subplot(1, 3, 1);
        hist(X / n, 64);                        % empiric PDF
        subplot(1, 3, 2);
        plot(y, pdf1(y), 'r', 'LineWidth', 2);  % exact PDF
        subplot(1, 3, 3);
        hold on;
        cdfplot(X);                             % empiric CDF
        plot(y, cdf1(y), 'r-.');                % exact CDF
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

        lambda
        alpha
        figure(1)
        subplot(1, 3, 1);
        hist(X / n);
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
        disp('Test for the Cauchy distribution.');
        n = input('Give n: ');
        gamma = input('Give gamma: ');
        x0 = input('Give x0: ');
        urand = rand(n, 1);
        y = -4:0.01:4;

        cdf1 = @(x) 1/pi * atan((x - x0) / gamma) + 0.5;
        icdf1 = @(u) x0 + gamma * tan(pi * (u - 0.5));
        pdf1 = @(x) 1 ./ (pi * gamma * (1 + ((x - x0) / gamma).^2));

        X = icdf1(urand);

        subplot(1, 3, 1);
        hist(X / n, 64);
        axis([-0.04 0.04 0 600]);
        subplot(1, 3, 2);
        plot(y, pdf1(y), 'r', 'LineWidth', 2);
        subplot(1, 3, 3);
        hold on;
        cdfplot(X);
        plot(y, cdf1(y), 'r-.');
        axis([-4 4 0 1]);
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
        % Generate a geometric random variable using Bernoulli random variables.
        disp('Not Implemented.');
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
        disp('See exercise 31 for values of n = 100, 5000 and lambda = 1.');
    case 92
        % Test if the values obtained from our generator belong to the exponential
        % distribution
        lambda = 1;

        icdf1 = @(u) -log(1 - u) / lambda;
        cdf1 = @(x) 1 - exp(-lambda * x);

        X = icdf1(urand);
        Xsorted = sort(X);
        Xcdf = cdf1(Xsorted);

        [pval, ks] = kolmogorov_smirnov_test(X, 'exp', lambda); % Octave
        % [ks, pval] = kstest(X, [Xsorted' Xcdf']); % Matlab

        fprintf('The p-value is: %g (accepted if > 0.05)\n', pval);
    case 93
        % Test if the values obtained from our generator belong to the Cauchy
        % distribution
        disp('For the comparison regarding the Cauchy generator see exercise 36.');
        gamma = 1;
        x0 = 0;

        icdf1 = @(u) x0 + gamma * tan(pi * (u - 0.5));
        cdf1 = @(x) 1/pi * atan((x - x0) / gamma) + 0.5;

        X = icdf1(urand);
        Xsorted = sort(X);
        Xcdf = cdf1(Xsorted);

        [pval, ks] = kolmogorov_smirnov_test(X, 'cauchy_', x0, gamma); % Octave
        % [ks, pval] = kstest(X, [Xsorted' Xcdf']); % Matlab

        fprintf('The p-value is: %g (accepted if > 0.05)\n', pval);
    case 94
        % Test if the values obtained from our generator belong to the geometric
        % distribution
        p = 0.5;

        icdf1 = @(u) ceil(log(1 - u) / log(1 - p));
        cdf1 = @(x) 1 - (1 - p).^x;

        X = icdf1(urand);
        Xsorted = sort(X);
        Xcdf = cdf1(Xsorted);

        [pval, ks] = kolmogorov_smirnov_test(X, 'geo', p); % Octave
        % [ks, pval] = kstest(X, [Xsorted' Xcdf']); % Matlab

        % NOTE: the p-value should be 0 because the distribution is not continuous.
        fprintf('The p-value is: %g (accepted if > 0.05)\n', pval);
    case 10
        % Compare the random variable:
        %       X_n = \frac{U_1 + .. + U_n - n/2}{\sqrt{n/12}}
        % with a N(\mu, \sigma^2) distribution, where U_i is a U[0, 1].
        % More exactly compare their CDFs.
        mu = 0;
        sigma = 1;

        y = -3:0.01:3;

        n = 12;
        X1 = (sum(rand(n, n)) - n/2) / sqrt(n/12);

        n = 6;
        X2 = (sum(rand(n, n)) - n/2) / sqrt(n/12);

        subplot(2, 1, 1)
        hold on;
        cdfplot(X2);
        plot(y, normcdf(y, mu, sigma), 'r-.');
        hold off;
        title('n = 6');
        subplot(2, 1, 2)
        hold on;
        cdfplot(X1);
        plot(y, normcdf(y, mu, sigma), 'r-.');
        hold off;
        title('n = 12');
    otherwise
        fprintf('Wrong exercise number.\n');
        fprintf('Available exercises are:\n');
        disp([31 32 33 34 35 36 41 42 43 52 6  91 92 93 94 10]);
end
