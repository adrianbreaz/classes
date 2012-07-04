clear all;
close all;

% Project 4.
%
% Students:
%   Alexandru Fikl
%   Adrian Breaz

disp('Exercise number format:');
disp(' - first digit: exercise number');
disp(' - second digit: subproblem number (none if it does not have one)');
exercise = input('Give exercise number: ');

switch exercise
    case 15
        p = 0.7;
        q = 1 - p;
        
        limit1 = @(epsilon) min(2, p * q ./ epsilon.^2);
        limit2 = @(epsilon) 2 * exp(-2 * epsilon.^2);
        limit3 = @(epsilon) 2 * normcdf(epsilon / sqrt(p * q)) - 1;
        
        e = linspace(0, 3, 512);
        
        hold on;
        plot(e, limit1(e));
        plot(e, limit2(e), 'r');
        plot(e, limit3(e), 'k');
        hold off;
    case 4
        n = 100;
        meanexact = 0;
        conf_interval = @(x, xmean, alpha) [mean(x) abs(xmean - mean(x)) (mean(x) - normcdf(1 - alpha/2) * sqrt(var(x)/length(x))) (mean(x) + normcdf(1 - alpha/2) * sqrt(var(x)/length(x)))];
        
        xrand = randn(n, 1);
        
        fprintf('Mean\t\tError\t\tLower\t\tUpper\tConfidance\n');
        for a = [0.05 0.025 0.01 0.005 0.0005]
            ci = conf_interval(xrand, 0.5, a);
            fprintf('%10g%10g%10g%10g%10g\n', ci(1), ci(2), ci(3), ci(4), 1 - a);
        end
        
        a = 0.005;
        narr = 1000:500:10000;
        lower = zeros(length(narr), 1);
        upper = zeros(length(narr), 1);
        meanx = zeros(length(narr), 1);
        i = 1;
        for n = narr
            ci = conf_interval(randn(n, 1), meanexact, a);
            meanx(i) = ci(1);
            lower(i) = ci(3);
            upper(i) = ci(4);
            i = i + 1;
        end
        
        hold on;
        errorbar(narr, meanx, meanx - lower, upper - meanx, 'o');
        plot(narr, meanx, 'r', 'LineWidth', 2);
        plot([narr(1) narr(end)], [meanexact meanexact], 'k');
        hold off;
    case 5        
        meanexact1 = 1;
        meanexact2 = 0.94281;
        meanexact3 = -0.30685;
        conf_interval = @(x, xmean, alpha) [mean(x) abs(xmean - mean(x)) (mean(x) - normcdf(1 - alpha/2) * sqrt(var(x)/length(x))) (mean(x) + normcdf(1 - alpha/2) * sqrt(var(x)/length(x)))];
        
        a = 0.05;
        narr = 1000:500:10000;
        lower = zeros(length(narr), 1);
        upper = zeros(length(narr), 1);
        meanx = zeros(length(narr), 1);
        i = 1;
        for n = narr
            ci = conf_interval(2 * rand(n, 1), meanexact1, a);
            meanx(i) = ci(1);
            lower(i) = ci(3);
            upper(i) = ci(4);
            i = i + 1;
        end
        
        subplot(3, 1, 1);
        hold on;
        errorbar(narr, meanx, meanx - lower, upper - meanx, 'o');
        plot(narr, meanx, 'r', 'LineWidth', 2);
        plot([narr(1) narr(end)], [meanexact1 meanexact1], 'k');
        title('Mean of X');
        hold off;
        
        i = 1;
        for n = narr
            ci = conf_interval(sqrt(2 * rand(n, 1)), meanexact2, a);
            meanx(i) = ci(1);
            lower(i) = ci(3);
            upper(i) = ci(4);
            i = i + 1;
        end
        
        subplot(3, 1, 2);
        hold on;
        errorbar(narr, meanx, meanx - lower, upper - meanx, 'o');
        plot(narr, meanx, 'r', 'LineWidth', 2);
        plot([narr(1) narr(end)], [meanexact2 meanexact2], 'k');
        title('Mean of sqrt(X)');
        hold off;
        
        i = 1;
        for n = narr
            ci = conf_interval(log(2 * rand(n, 1)), meanexact3, a);
            meanx(i) = ci(1);
            lower(i) = ci(3);
            upper(i) = ci(4);
            i = i + 1;
        end
        
        subplot(3, 1, 3);
        hold on;
        errorbar(narr, meanx, meanx - lower, upper - meanx, 'o');
        plot(narr, meanx, 'r', 'LineWidth', 2);
        plot([narr(1) narr(end)], [meanexact3 meanexact3], 'k');
        title('Mean log(X)');
        hold off;
    case 6
        n = 10000;
        X = 2 * rand(n, 1);
        Y = 8 * rand(n, 1) + 2;
        
        f = @(x, y) 16 ./ (y.^2 + cos(x).^2);
        fprintf('value of the first integral is %g.\n', mean(f(X, Y)));
        
        icdfexp = @(u) -log(1 - u) / 2;
        X = icdfexp(rand(n, 1));
        Y = 2 * rand(n, 1) + 1;
        g = @(x, y) 1 ./ (2 * (Y + cos(X.*Y)));
        fprintf('value of the second integral is %g.\n', mean(g(X, Y)));
    case 7
        n = 10000;
        X = zeros(n, 1);
        Y = zeros(n, 1);
        
        f = @(x) 0.5 - x;
        g = @(x) 1 - x;
        h = @(x, y) 2.6666 * exp((x - y) ./ (x + y));
        a = 0;
        b = 1;
        c = 0;
        d = 1;
        
        for i = 1:n
            x = a + (b - a) * rand();
            y = c + (d - c) * rand();

            while y < f(x) || y > g(x)
                x = a + (b - a) * rand();
                y = c + (d - c) * rand();
            end

            X(i) = x;
            Y(i) = y;
        end
        
        fprintf('value of the integral is %g\n', mean(h(X, Y)));
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
        fprintf('Available exercises are:\n');
        disp([15 2 4 5 6 7 8]);
end
