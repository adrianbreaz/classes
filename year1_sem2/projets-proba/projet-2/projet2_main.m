clear all;
close all;

% Project 2: Simulation of real random variables using the method of inversion.
%            The Kolmogorov-Smirnov Test.
%
% Students:
%   Alexandru Fikl
%   Adrian Breaz
%
% Description: the inversion method works as follows:
%   - suppose we have a variable X with the CDF F and it's inverse F^{-1}
%   - suppose we have a variable U that is U[0, 1]
%   - F^{-1}(U) has the same distribution as X.
%
% Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

disp([31 32 33 34 35 36 41 42 43 52 6 92 93 94 10]);
exercise = input('Give exercise number: ');

switch exercise
    case 31
        % Test the inversion method on the exponential distribution generator.
        lambda = 1;

        cdf1 = @(x) 1 - exp(-lambda * x);       % comulative distribution function
        icdf1 = @(u) -log(1 - u) / lambda;      % inverse of the cdf
        pdf1 = @(x) lambda * exp(-lambda * x);  % probability density function

        plot_variable_f(cdf1, icdf1, pdf1, 'Exponential', 0:0.01:10);
    case 32
        % Test the Laplace distribution generator.
        lambda = 1;
        mu = 0;

        cdf1 = @(x) 0.5 * (1 + sign(x - mu) .* (1 - exp(-abs(x - mu)/lambda)));
        icdf1 = @(u) mu - lambda * sign(u - 0.5) .* log(1 - 2 * abs(u - 0.5));
        pdf1 = @(x) 1 / (2 * lambda) * exp(-abs(x - mu)/lambda);

        plot_variable_f(cdf1, icdf1, pdf1, 'Laplace', -10:0.01:10);
    case 33
        % Test the Weibull distribution generator.
        alpha = 1.5;
        lambda = 1;

        cdf1 = @(x) 1 - exp(-lambda * x.^alpha);
        icdf1 = @(u) (-log(1 - u) / lambda).^(1/alpha);
        pdf1 = @(x) alpha * lambda * x.^(alpha - 1) .* exp(-lambda * x.^alpha);

        plot_variable_f(cdf1, icdf1, pdf1, 'Weibull', 0:0.01:3);;
    case 34
        % Test the Beta distribution generator.
        alpha = 2;
        betaa = 2;

        cdf1 = @(x) betainc(x, alpha, betaa);
        icdf1 = @(u) betainv(u, alpha, betaa);
        pdf1 = @(x) x.^(alpha - 1) .* (1 - x).^(betaa - 1) / beta(alpha, betaa);

        plot_variable_f(cdf1, icdf1, pdf1, 'Beta', 0:0.01:1);
    case 35
        % Test the Pareto distribution generator.
        alpha = 3;
        lambda = 1;

        cdf1 = @(x) 1 - lambda^alpha * x.^(-alpha);
        icdf1 = @(u) lambda ./ ((1 - u).^(1/alpha));
        pdf1 = @(x) alpha * lambda^alpha * x.^(-alpha-1);

        plot_variable_f(cdf1, icdf1, pdf1, 'Pareto', lambda:0.01:5);
    case 36
        % Test the Cauchy distribution generator.
        gamma = 2;
        x0 = 0;

        cdf1 = @(x) 1/pi * atan((x - x0) / gamma) + 0.5;
%          icdf1 = @(u) x0 + gamma * tan(pi * (u - 0.5));
        icdf1 = @(u) cauchy_inv(u, x0, gamma);
        pdf1 = @(x) 1 ./ (pi * gamma * (1 + ((x - x0) / gamma).^2));

        plot_variable_f(cdf1, icdf1, pdf1, 'Cauchy', -4:0.01:4);
    case 41
        % Test the Bernoulli distribution generator.
        p = 0.7;

        cdf1 = @(x) (1 - p) * (x > 0 & x < 1) + (x >= 1);
        icdf1 = @(u) floor(p + u);
        pdf1 = @(x) (1 - p) * ( x == 0) + p * (x == 1);

        plot_variable_f(cdf1, icdf1, pdf1, 'Bernoulli', -1:0.01:2);
    case 42
        % Test the geometric distribution generator.
        p = 0.7;

        cdf1 = @(x) 1 - (1 - p).^x;
        icdf1 = @(u) ceil(log(1 - u) / log(1 - p));
        pdf1 = @(x) (1 - p).^(x - 1) * p;

        plot_variable_f(cdf1, icdf1, pdf1, 'Geometric', 1:10);
    case 43
        % Generate a geometric random variable using Bernoulli random variables.
        n = 10000;
        q = 0.3;     % q = 1 - p; p = 0.7
        X = zeros(n, 1);

        for i = 1:n
            counter = 0;
            a = 0;

            % wait for first success
            while a < q
                a = rand();
                counter = counter + 1;
            end
            X(i) = counter;
        end

        cdfplot(X);
    case 52
        % Given a discrete distribution with the following probabilities
        % (P(X = k_i) = p_i), generate a variable X who has the distribution p.
        k = [1 3 8];
        p = [0.1 0.1 0.8];
        pc = cumsum(p);
        y = 0:0.05:9;

        cdf1 = @(x) 0;
        icdf1 = @(u) k(1) * (u <= pc(1)) + k(2) * (u <= pc(2) & u > pc(1)) + k(3) * (u > pc(2));
        pdf1 = @(x) p(1) * (x == k(1)) + p(2) * (x == k(2)) + p(3) * (x == k(3));

        plot_variable_f(cdf1, icdf1, pdf1, 'Custom', 0:0.05:9);
    case 6
        % Test the Poisson distribution generator.
        lambda = 4;

        cdf1 = @(x) poisscdf(x, lambda);
        icdf1 = @(u) poissinv(u, lambda);
        pdf1 = @(x) lambda.^x ./ factorial(x) * exp(-lambda);

        plot_variable_f(cdf1, icdf1, pdf1, 'Poisson', 1:20);
    case 92
        % Test if the values obtained using the inverse CDF of the exponential
        % CDF actually belong to the exponential distribution using the KS test.
        lambda = 1;
        icdf1 = @(u) -log(1 - u) / lambda;
        cdf1 = @(x) 1 - exp(-lambda * x);

        X = icdf1(rand(10000, 1));
        Xsorted = sort(X);
        CDF = [Xsorted cdf1(Xsorted)];

        [pval, ks] = kolmogorov_smirnov_test(X, 'exp', lambda);

        fprintf('The p-value is: %g\n', pval);
    case 93
        % Test if the values obtained using the inverse CDF of the Cauchy
        % CDF actually belong to the Cauchy distribution using the KS test.
        gamma = 1;
        x0 = 0;

        cdf1 = @(x) 1/pi * atan((x - x0) / gamma) + 0.5;
        icdf1 = @(u) x0 + gamma * tan(pi * (u - 0.5));

        X = icdf1(rand(10000, 1));
        Xsorted = sort(X);
        CDF = [Xsorted cdf1(Xsorted)];
        [pval, ks] = kolmogorov_smirnov_test(X, 'cauchy_', x0, gamma);

        fprintf('The p-value is: %g\n', pval);
    case 94
        % Test if the values obtained using the inverse CDF of the geometric
        % CDF actually belong to the geometric distribution using the KS test.
        p = 0.5;

        cdf1 = @(x) 1 - (1 - p).^x;
        icdf1 = @(u) ceil(log(1 - u) / log(1 - p));

        X = icdf1(rand(10000, 1));
        Xsorted = sort(X);
        CDF = [Xsorted cdf1(Xsorted)];

        [pval, ks] = kolmogorov_smirnov_test(X, 'geo', p);

        % NOTE: the p-value should be 0 because the distribution is not continuous.
        fprintf('The p-value is: %g\n', pval);
    case 10
        % Compare the random variable:
        %       X_n = \frac{U_1 + .. + U_n - n/2}{\sqrt{n/12}}
        % with a N(\mu, \sigma^2) distribution, where U_i is a U[0, 1].
        % More exactly compare their CDFs. (Test for the CLT).
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
end