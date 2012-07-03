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

disp('Exercise number format:');
disp(' - first digit - exercise number');
disp(' - second digit - subproblem number (none if it does not have one)');
exercise = input('Give exercise number: ');

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
        title('Linear pseudo-random number generator.');
        hold off;
    case 12
        % Find the period of our random number generator
        T = 0;             % period counter
        x0 = 0;             % initial value
        x1 = f1(x0, a);      % next value

        while x1 ~= 0
            x1 = f1(x0, a);
            x0 = x1;
            T = T + 1;
        end

        fprintf('The period of our generator for ');
        fprintf('(x0, a, c, m) = (%d, %d, %d, %d) ', x0, a, c, m);
        fprintf('is: %d\n', T);
    case 14
        % Test the correlation between our PRNG and a uniform distribution.
        x1 = randi(m - 1, 1, n);                % random variable from {0, .., m-1}
        x2 = 0 * x1;                            % our test variable

        ad = 1:4:1021;
        corrc = zeros(length(ad), 1);
        j = 1;

        for a = ad
            for i = 1:n - 1
                x2(i + 1) = f1(x2(i), a);
            end

            corrc(j) = corr(x2, x1);          % octave
%              corr = corrcoef(x1, x2);          % matlab
%              corrc(j) = corr(1, 2);
            j = j + 1;
        end

        [minc, ind] = min(abs(corrc));
        fprintf('best a ever is %d with a corr of %g\n', ad(ind), corrc(ind));

        hold on;
        plot(ad, corrc, 'r*');
        plot([0, 1025], [0, 0]);
        hold off;
        title('Correlation between a uniform distribution and our linear random number generator.')
    case 21
        % Test convergence to a U[0, 1] using a discrete uniform distribution
        x = 0:0.01:0.99;

        hold on;
        plot([0, 1], [0, 1], 'r');
        plot(x, f2(x, 16));
        plot(x, f2(x, 32), 'g');
        plot(x, f2(x, 96), 'y');
        legend('uniform', 'm = 16', 'm = 32', 'm = 96', 'Location', 'NorthWest');
        hold off;
    case 33
        % RANDU algorithm
        n = 5000;
        a = 2^16 + 2 + 1;   % special values for a and m
        m = 2^31;
        x0 = 1;

        A = zeros(3, n);

        for i = 1:n
            A(1, i) = f3(x0, a, m);
            A(2, i) = f3(A(1, i), a, m);
            A(3, i) = f3(A(2, i), a, m);
            x0 = A(3, i);
        end

        A = A / m;
        A = [9 -6 1] * A;
        cdfplot(A);
    case 41
        % Test the Law of Large Numbers that says:
        %   \overline{X}_n \to E[X]
        n = 1024;

        xn = randi(m - 1, n, 1);
        xn2 = zeros(n, 1);
        xn = cumsum(xn) ./ [1:n]';

        for i = 1:n - 1
            xn2(i + 1) = f1(xn2(i), a);
        end

        xn2 = cumsum(xn2) ./ [1:n]';

        hold on;
        plot([0, n], [m / 2, m / 2], 'LineWidth', 2);
        plot(xn, 'r', 'LineWidth', 2);
        plot(xn2, 'k', 'LineWidth', 2);
        legend('exact mean', 'our PRNG', 'randi', 'Location', 'SouthEast');
        title('Convergence to the uniform distribution mean');
        hold off;
    case 43
        % Compute numerically Var(X) where X is generated using our PRNG
        n = 1024;

        x = zeros(n, 1);
        x(1) = randi(m);

        for i = 1:n - 1
            x(i + 1) = f1(x(i), a);
        end

        fprintf('exact:  Var(X1) = %g\n', (m^2 - 1) / 12);
        fprintf('approx: Var(X1) = %g\n', var(x));
    case 44
        % Test the central limit theorem
        n = 128;
        p = 512;
        nmeanx = n * m / 2;
        nstdx = sqrt(n * (m^2 - 1) / 12);

        xhist = zeros(p, 1);
        x = zeros(n, 1);

        for i = 1:p
            x(1) = randi(m);

            for j = 1:n - 1
                x(j + 1) = f1(x(j), a);
            end
            xhist(i) = (sum(x) - nmeanx) / nstdx;
        end

        histfit(xhist, 64);
    case 50
        % Test something regarding the Mersenne Twister
        T = 2^19937 - 1;
        mean = 25e+06 * 60 * 60 * 24 * 365;

        fprintf('%.16f\n', mean / T);
    otherwise
        fprintf('Wrong exercise number.\n');
        fprintf('Available exercises are:\n');
        disp([11 12 14 21 33 41 43 44 50]);
end
