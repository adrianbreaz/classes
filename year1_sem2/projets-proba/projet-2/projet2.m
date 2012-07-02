clear all;
close all;

n = 10000;
urand = rand(n, 1);

disp('Exercise number format:');
disp(' - first digit - exercise number');
disp(' - second digit - subproblem number');
exercise = input('Give exercise number: ');

switch exercise
    case 31
        lambda = 1.5;
        y = 0:0.01:10;

        cdf1 = @(x) 1 - exp(-lambda * x);
        icdf1 = @(u) -log(1 - u) / lambda;
        pdf1 = @(x) lambda * exp(-lambda * x);

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
        b = 1;
        mu = 0;
        y = -10:0.01:10;
        
        cdf1 = @(x) 0.5 * (1 + sign(x - mu) .* (1 - exp(-abs(x - mu)/b)));
        icdf1 = @(u) mu - b * sign(u - 0.5) .* log(1 - 2 * abs(u - 0.5));
        pdf1 = @(x) 1 / (2 * b) * exp(-abs(x - mu)/b);
        
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
    case 33
        disp('Not Implemented.');
    case 34
        disp('Not Implemented.');
    case 35
        disp('Not Implemented.');
    case 36
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
    otherwise
        error('Wrong exercise number.');
end
