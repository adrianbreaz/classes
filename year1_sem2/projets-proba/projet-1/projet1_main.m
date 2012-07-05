clear all;
close all;
format short g;

% Project 1: Pseudorandom generators.
%
% Students:
%   Alexandru Fikl
%   Buchra Abouali
%
% Description: test linear congruencial generators that are defined as follows:
%   - given a function f(x) = a * x + c mod m and a starting value x_0
%   - iterate x_{n + 1} = f(x_n) for number of times.
%
% Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

% global variables
a = 101;
c = 1;
m = 1024;
n = 20;
x0 = 0;

disp([11 12 14 21 33 41 43 44]);
exercise = input('Give exercise number: ');

switch exercise
    case 11
        % Draw a plot with the first n values generated using a LCG
        R = lcg(x0, a, c, m, n);

        hold on;
        plot(R, 0 * R, 'r*');
        plot([0 m], [0 0]);
        axis([-1 1025 -5 5]);
        title('Linear pseudo-random number generator.');
        hold off;
    case 12
        % Find the period of our LCG
        p = 0;                      % period counter
        x1 = mod(a * x0 + c, m);    % next value

        while x1 ~= 0
            x1 = mod(a * x0 + c, m);
            x0 = x1;
            p = p + 1;
        end

        fprintf('For (x0 = %d, a = %d, c = %d, m = %d) ', x0, a, c, m);
        fprintf('the period of the LCG for is: %d\n', p);
    case 14
        % Test the correlation between the LCG and a uniform distribution.
        %
        % Local variables
        A = 1:4:1021;
        j = 1;

        % Initialize our random variables
        X1 = randi(m - 1, n, 1);
        X2 = 0 * X1;
        CORR = 0 * A;

        for a = A
            X2 = lcg(x0, a, c, m, n);
            CORR(j) = corr(X2, X1);
            j = j + 1;
        end

        % We want to find the `a` for which the two variables X1 and X2 are
        % the most decorrelated (the correlation is very close to 0).
        [minc, ind] = min(abs(CORR));
        fprintf('best a ever is %d with a corr of %g\n', A(ind), minc);

        hold on;
        plot(A, CORR, 'r*');
        plot([(A(1) - 1) (A(end) + 1)], [0 0]);
        xlabel('a');
        ylabel('Correlation');
        title('Correlation between a uniform distribution and our linear random number generator.')
        hold off;
    case 21
        % Test convergence to a U[0, 1] using a discrete uniform distribution
        %
        % Given X - a uniformly distributed discrete random variable on {0, ..., m - 1},
        % we can generator a random number on [0, 1] (continuous) using the PDF
        % of X/m which is:
        f = @(x, p) (floor(p * x) + 1) / p;

        X = 0:0.01:0.99;

        % For various values of m we can see how it converges to U[0, 1].
        hold on;
        plot([0, 1], [0, 1], 'r');
        plot(X, f(X, 16));
        plot(X, f(X, 32), 'g');
        plot(X, f(X, 96), 'y');
        legend('uniform', 'm = 16', 'm = 32', 'm = 96', 'Location', 'NorthWest');
        hold off;
    case 33
        % RANDU algorithm: same as LCG with special values of a, c, m.
        n = 5000;

        % Generate a variable
        %   T = 9 * X - 6 * Y + Z
        % where X, Y and Z are U[0, 1].
        T1 = [9 -6 1] * rand(3, n);
        T2 = [9 -6 1] * reshape(randu(1, 3 * n) / 2^31, 3, n);

        % Plot the resulting values => the CDFs of the two resulting variables are
        % the same-ish.
        hold on;
        h = cdfplot(T1);
        set(h, 'Color', 'r', 'LineWidth', 2);
        cdfplot(T2);
        legend('U[0, 1]', 'RANDU', 'Location', 'NorthWest');
        hold off
    case 41
        % Test the Law of Large Numbers that says:
        %   \overline{X}_n \to E[X_1]
        % where \overline{X}_n is the empiric mean.
        n = 1024;

        % Compute the empiric mean of a uniform random variable for different n.
        Xn_unif = cumsum(randi(m - 1, n, 1)) ./ [1:n]';

        % Compute the empiric mean of a variable generated using the LCG for different n.
        Xn_lcg = cumsum(lcg(x0, a, c, m, n)) ./ [1:n]';

        hold on;
        plot([0, n], [m / 2, m / 2], 'LineWidth', 2);
        plot(Xn_unif, 'r', 'LineWidth', 2);
        plot(Xn_lcg, 'k', 'LineWidth', 2);
        legend('exact mean', 'LCG', 'built-in randi', 'Location', 'SouthEast');
        title('Convergence to the uniform distribution mean');
        hold off;
    case 43
        % Compute Var(X) numerically where X is generated using the LCG
        n = 1024;
        X = lcg(randi(m), a, c, m, n);

        % As X is a U[0, 1] they should be the same-ish.
        fprintf('exact:  Var(X) = %g\n', (m^2 - 1) / 12);
        fprintf('approx: Var(X) = %g\n', var(X));
    case 44
        % Test the Central Limit Theorem:
        %   (X_1 + ... + X_n - n * E[X_1]) / \sqrt{n * Var[X]} --> N(0, 1)
        %
        % To test this we fix an `n`, and generate (X_1, ..., X_n) `p` times and see
        % if the results are normally distributed.
        n = 128;
        p = 512;

        % Precomputed fixed values
        nmeanx = n * m / 2;                 % n * E[X]
        nstdx = sqrt(n * (m^2 - 1) / 12);   % \sqrt{n * Var[X]}

        Z = zeros(p, 1);

        for i = 1:p
            x = sum(lcg(randi(m), a, c, m, n)); % generate an array from the LCG
            Z(i) = (x - nmeanx) / nstdx;        % normalize it
        end

        histfit(Z, 64);
    otherwise
        fprintf('Wrong exercise number.\n');
end
