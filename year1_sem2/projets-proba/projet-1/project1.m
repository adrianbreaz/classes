clear all;
close all;
format short g;

% Project 1.
%
% Students:
%   Alexandru Fikl
%   Buchra Abouali


% global variables
a = 101;
c = 1;
m = 1024;
n = 20;

% used functions
f1 = @(x, b) mod(b * x + c, m);             % exercise 1
f2 = @(x, p) (floor(p * x) + 1) / p;        % exercise 2
f3 = @(x, b, p) mod(b * x, m);              % exercise 3

exercise = 44; % Format: first digit - exercise number, second digit - subproblem

switch exercise
    case 11
        % Pseudo-random number generator: using the function f and the arguments
        % a, c and m generate n random numbers and represent the results graphically.
        r = zeros(n, 1);    % generated numbers
        for i = 1:n - 1
            r(i + 1) = f1(r(i), a);
        end

        hold on;
        plot(r, 0 * r, 'r*');
        plot([0, m], [0, 0]);
        hold off;
    case 12
        % Find the period of our random number generator
        T1 = 0;     % period counter
        x0 = 0;     % initial value
        x1 = 1;     % next value

        while x1 ~= 0
            x1 = f1(x0, a);
            x0 = x1;
            T1 = T1 + 1;
        end

        fprintf('The period is: %d\n', T1);
    case 14
        % Test the correlation between our PRNG and a uniform distribution.
        x1 = randi(m - 1, 1, n);
        x2 = 0 * x1;
        j = 1;

        for a = 1:4:1021
            for i = 1:n - 1
                x2(i + 1) = f1(x2(i), a);
            end

            corrcoeff(j) = corr(x2, x1);
            j = j + 1;
        end

        [minc, ind] = min(abs(corrcoeff));
        fprintf('best a ever is %d\n', 1 + 4 * (ind - 1));

        plot(1:length(corrcoeff), corrcoeff, 'r*');
    case 21
        % Test convergence to a U[0, 1] using the discrete uniform distribution
        x = 0:0.01:0.99;

        hold on;
        plot([0, 1], [0, 1], 'r')
        plot(x, f2(x, 16));
        plot(x, f2(x, 32), 'g');
        plot(x, f2(x, 96), 'y');
        legend('uniform', 'm = 16', 'm = 32', 'm = 96', 'Location', 'NorthWest');
        hold off;
    case 33
        % RANDU algorithm
        n = 5000;
        a = 2^16 + 2 + 1;
        m = 2^31;
        x0 = 1;

        A = zeros(3, n);
        x = -10:0.1:10;
        y = 0 * x;

        for i = 1:n
            A(1, i) = f3(x0, a, m);
            A(2, i) = f3(A(1, i), a, m);
            A(3, i) = f3(A(2, i), a, m);
            x0 = A(3, i);
        end

        A = A / m;
        A = [9 -6 1] * A;
        cdfplot(A);               % for Octave
        % plot(ecdf(A));            % for MATLAB
    case 42
        % Test the Law of Large Numbers that says:
        %   \overline{X}_n \to E[X]
        n = 1024;

        xn = zeros(n, 1);
        xsum = 0;
        x0 = 0;

        for i = 1:n - 1
            x0 = f1(x0, a);
            xsum = xsum + x0;
            xn(i) = xsum / i;
        end

        hold on;
        plot([0, n], [m / 2, m / 2], 'LineWidth', 2);
        plot(xn, 'r*');
        hold off;
    case 43
        % Compute numerically Var(X) by using n * Var(X_n)
        n = 1024;

        xn = zeros(n, 1);
        xsum = 0;
        x0 = 0;

        for i = 1:n - 1
            x0 = f1(x0, a);
            xsum = xsum + x0;
            xn(i) = xsum / i;
        end

        % FIXME: they should be the same
        fprintf('Var(X1) = %g\n', (m^2 - 1) / 12);
        fprintf('n * Var(Xn) = %g\n', n * var(xn));
    case 44
        % Test the central limit theorem
        % TODO
        n = 10000;

        nn = zeros(n, 1);
        xsum = 0;
        x0 = 0;
        varx = (m^2 - 1) / 12;
        meanx = m / 2;

        for i = 1:n - 1
            x0 = f1(x0, a);
            xsum = xsum + x0;
            nn(i) = (xsum - i * meanx) / sqrt(i * varx);
        end

        hold on;
        plot(nn);
        hold off;
    otherwise
        error('Wrong exercise number.\n');
end