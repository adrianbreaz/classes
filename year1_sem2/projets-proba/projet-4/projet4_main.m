clear all;
close all;
addpath('../projet-3');

% Project 4: Monte Carlo and Confidence Intervals.
%
% Students:
%   Alexandru Fikl
%   Adrian Breaz
%
% Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

disp([15 4 5 6 7 8]);
exercise = input('Give exercise number: ');

switch exercise
    case 15
        % Given X_i ~ Bernoulli(p) and S_n = sum(X)
        p = 0.7;
        q = 1 - p;

        % By the Bienaime-Chebychev Inequality we have:
        %       P(|S_n - E[S_n]| >= sqrt(n) * epsilon) <= p * q / epsilon^2
        limitbc = @(epsilon) min(2, p * q ./ epsilon.^2);

        % By Hoeffding's Inequality we have:
        %       P(|S_n - E[S_n]| >= sqrt(n) * epsilon) <=  2 * exp(-2 * epsilon^2)
        limith = @(epsilon) 2 * exp(-2 * epsilon.^2);

        % By the CLT we have:
        %       P(|S_n - E[S_n]| >= sqrt(n) * epsilon) <= 2 * F(epsilon / sqrt(p * q)) - 1
        limitclt = @(epsilon) 2 * normcdf(epsilon / sqrt(p * q)) - 1;

        e = linspace(0, 3, 512);

        % Each of the 3 limits provides a upper boundary for some interval of epsilon.
        hold on;
        plot(e, limitbc(e));
        plot(e, limith(e), 'r');
        plot(e, limitclt(e), 'k');
        legend('Chebychev', 'Hoeffding', 'CLT');
        hold off;
    case 41
        % Determine the confidence interval for different values of alpha
        n = 100;        % number of samples
        emu = 0.5;      % exact mean of U[0, 1]

        xrand = rand(n, 1);

        fprintf('%15s%15s%15s%15s%15s\n', 'Mean', 'Error', 'Lower', 'Upper', 'Confidence');
        for a = [0.05 0.025 0.01 0.005 0.0005]
            [lower, upper, mu] = confidenceint(xrand, a);
            fprintf('%15g%15g%15g%15g%15g\n', mu, emu - mu, lower, upper, 1 - a);
        end
    case 42
        % Plot the confidence interval for different values of n
        a = 0.05;
        emean = 0.5;

        plot_ci(a, 1000:500:10000, @(x) x, emean);
        title(sprintf('alpha = %g', a));
    case 5
        % Given X ~ U[0, 2]. Estimate the means of X, sqrt(X) and log(X)

        % Exact means of those variables
        meanx = 1;
        meansqrtx = 0.94281;
        meanlogx = -0.30685;

        a = 0.05;
        nvalues = 1000:500:10000;

        subplot(3, 1, 1);
        plot_ci(a, nvalues, @(x) 2 * x, meanx);
        title('Mean of X');
        subplot(3, 1, 2);
        plot_ci(a, nvalues, @(x) sqrt(2 * x), meansqrtx);
        title('Mean of sqrt(X)');
        subplot(3, 1, 3);
        plot_ci(a, nvalues, @(x) log(2 * x), meanlogx);
        title('Mean of log(X)');
    case 6
        n = 10000;

        % First integral
        f = @(x, y) 16 ./ (y.^2 + cos(x).^2);

        reject_func = @(x, y) 0;
        [X, Y] = acceptreject(reject_func, @(x) x, [0 2 2 10], n);

        fprintf('value of the first integral is %g.\n', mean(f(X, Y)));

        % Second integral
        % FIXME: should give 0.26...
        g = @(x, y) 1 ./ (2 * (Y + cos(X .* Y)));

        reject_func = @(x, y) 0;
        icdfexp = @(x) -log(1 - x) / 2;
        [X, Y] = acceptreject(reject_func, icdfexp, [0 1 1 2], n);
        fprintf('value of the second integral is %g.\n', mean(g(X, Y)));
    case 7
        % Compute the integral of e^{(x - y) / (x + y)} on the domain:
        %   D = { (x, y): x, y > 0, 0.5 < x + y < 1 }
        % using the Monte Carlo method.
        n = 1000;
        f = @(x, y) 2.6666 * exp((x - y) ./ (x + y));

        reject_func = @(x, y) y < (0.5 - x) || y > (1 - x);
        [X, Y] = acceptreject(reject_func, @(x) x, [0 1 0 1], n);

        fprintf('value of the integral is %g\n', mean(f(X, Y)));
    case 8
        n = 10000;
        X = zeros(n, 1);
        Y = zeros(n, 1);

        fprintf('Proposed formula: pi / (5 * a * b).\n');
        for v = [1 1; 2 1; 0.5 1; 1 2; 1 0.5; 2 2; 0.5 0.5]'
            a = v(1);
            b = v(2);
            f = @(x, y) x.^2 / a^2 + y.^2 / b^2;
            g = @(x, y) 1 ./ ( pi * a * b * sqrt(1 - x.^2 / a^2 - y.^2 / b^2));
            xa = -a;
            xb = a;
            ya = -b;
            yb = b;

            for i = 1:n
                x = xa + (xb - xa) * rand();
                y = ya + (yb - ya) * rand();

                while f(x, y) > 1
                    x = xa + (xb - xa) * rand();
                    y = ya + (yb - ya) * rand();
                end

                X(i) = x;
                Y(i) = y;
            end

            fprintf('=== (a, b) = (%.3g, %.3g) ===\n', a, b);
            fprintf('integral %.5g | exact = %.5g\n', mean(g(X, Y)), pi / (5 * a * b));
        end
    otherwise
        fprintf('Wrong exercise number.\n');
end
