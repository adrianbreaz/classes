close all;
clear all;

% Project 3.
%
% Students:
%   Adrian Breaz
%   Alexandru Fikl


n = 2500;
X = rand(n, 1);
Y = rand(n, 1);

disp('Exercise number format:');
disp(' - first digit: exercise number');
disp(' - second digit: subproblem number (none if it does not have one)');
exercise = input('Give exercise number: ');

switch exercise
    case 2
        lambda = 1;         % value for which c_{\lambda} is minimal

        cdfexp = @(x) lambda * exp(-lambda * x);
        icdfexp = @(x) -log(1 - x)/ lambda;
        cdfnorm = @(x) sqrt(pi/2) * exp(-x^2/2);
        c = sqrt(2 / pi) * exp(lambda^2 / 2) / lambda;

        % Create a random variable using the exponential and Thm 1
        for i = 1:n
            U = rand();
            x = icdfexp(rand());
            const = 2 * randi([0, 1]) - 1;
            j = 1;

            while cdfnorm(x) <= (U * c * cdfexp(x))
                U = rand();
                x = icdfexp(rand());
                j = j + 1;
            end

            Y(i) = x * const;
            I(i) = j;
        end

        fprintf('The mean is %d\n', mean(I));
        cdfplot(Y);
    case 3
        % Generate (X, Y) uniformly on a square [0, 1]x[0, 1]
        hold on;
        plot(X, Y, 'r*');
        plot([0 1 1 0 0], [0 0 1 1 0], 'LineWidth', 3);
        hold off;
    case 4
        % Generate (X, Y) uniformly on a triangle (0, 0), (1, 0), (0, 1)
        for i = 1:n
            x = rand();
            y = rand();

            while (x + y) > 1
                x = rand();
                y = rand();
            end

            X(i) = x;
            Y(i) = y;
        end

        hold on;
        plot(X, Y, 'r*');
        plot([0 1 0 0], [0 0 1 0], 'LineWidth', 3);
        hold off
    case 5
        % Generate (X, Y) uniformly on the unit disk
        % limits of x and y
        a = 1;
        b = -1;
        r = 1;      % radius

        for i = 1:n
            x = a + (b - a) * rand();
            y = a + (b - a) * rand();

            while (x^2 + y^2) > r
                x = a + (b - a) * rand();
                y = a + (b - a) * rand();
            end

            X(i) = x;
            Y(i) = y;
        end

        hold on;
        plot(X, Y, 'r*');
        plot(r * cos(0:pi/100:2 * pi), r * sin(0:pi/100:2 * pi), 'LineWidth', 3);
        hold off;
    case 6
        % Generate (X, Y) uniformly in the set:
        %   D_f = {(x, y) \in R^2: 0 <= y <= f(x)}
        % for a given f.
        f = @(x) 3 * x.^2;
        Z = linspace(0, 1, 100);

        % limits of x
        a = 1;
        b = 0;

        % limits of f(x)
        c = 3;
        d = 0;

        for i = 1:n
            x = a + (b - a) * rand();
            y = c + (d - c) * rand();

            while y > f(x)
                x = a + (b - a) * rand();
                y = c + (d - c) * rand();
            end

            X(i) = x;
            Y(i) = y;
        end

        hold on;
        plot(X, Y, 'r*');
        plot(Z, f(Z), 'LineWidth', 3);
        hold off;
     case 7
        % Generate X with the density f.
        f = @(x) 2 * sqrt(1 - x.^2) / pi;
        g = @(x) 0.5;

        c =  4/pi;

        % limits of x
        a = 1;
        b = -1;

        for i = 1:n
            U = rand();
            y = a + (b - a) * rand();
            j = 1;

            while f(y) <= (U * c * g(y))
                U = rand();
                y = a + (b - a) * rand();
                j = j + 1;
            end

            X(i) = y;
            Y(i) = j;
        end

        mean(y);
        subplot(2, 1, 1)
        hist(X, 20);
        subplot(2, 1, 2)
        plot(linspace(-1, 1, 100), f(linspace(-1, 1, 100)), 'LineWidth', 3);
    case 9
        % Generate X with the distribution:
        %   P(X = k) = 2/150    if k is even
        %              1/150    if k is odd
        % for k in {1, ..., 100}.
        n = 10000;
        X = zeros(n, 1);
        U = randi(100);
        c = 4/3;

        p = @(k) 1/100;
        q = @(k) (1 + mod(k + 1, 2)) / 150;     % the PDF

        for i = 1:n
            k = randi(100);
            U = rand(1, 1);

            while q(k) <= (U * c * p(k))
                k = randi(100);
                U = rand();
            end

            X(i) = k;
        end

        hist(X, 100);
    case 10
        % Generate (X, Y) unformly in the domain:
        % D =   {(x, y): -2 <= x <= -1, 0 <= y <= x + 2} U
        %       {(x, y): -1 <= x <= 0, 0 <= y <= -x + 1} U
        %       {(x, y): 0 <= x <= 1, 0 <= y <= x + 1} U
        %       {(x, y): 1 <= x <= 2, 0 <= y <= -x + 2}

        % limits of x for each shape
        xa = [-2 -1 0 1];
        xb = [-1 0 1 2];

        % limits of y
        ya = [0 0 0 0];
        yb = [1 2 2 1];

        % coefficient of x in 0 <= y <= a1 * x + a2
        a1 = [1 -1 1 -1];
        a2 = [2 1 1 2];

        % our shape is like:
        % 2           |-              -|
        %             |  -          -  |
        %             |    -      -    |
        %             |      -  -      |
        % 1           -----------------
        %           - |-      |       -| -
        %         -   |  -    |     -  |   -
        %       -     |    -  |   -    |     -
        %     -       |      -| -      |       -
        % 0 --------------------------------------
        %   -2       -1       0        1         2
        % We have 8 triangles that fit into our 4 shapes (for x in [-2 -1], [-1, 0],
        % [0, 1] and [1, 2]).
        q = [1/8 3/8 3/8 1/8]';

        % the probability of to be in one shape
        p = 1/4;

        % max of q/p
        c = 3/2;

        Z = zeros(n, 1);

        for i = 1:n
            k = randi(4);
            U = rand();

            while q(k) <= (U * c * p)
                k = randi(4);
                U = rand();
            end

            x = xa(k) + (xb(k) - xa(k)) * rand();
            y = ya(k) + (yb(k) - ya(k)) * rand();

            while y > (a1(k) * x + a2(k))
                x = xa(k) + (xb(k) - xa(k)) * rand();
                y = ya(k) + (yb(k) - ya(k)) * rand();
            end

            X(i) = x;
            Y(i) = y;
            Z(i) = k;
        end

        subplot(2, 1, 1)
        hist(Z, 4);
        subplot(2, 1, 2)
        hold on;
        plot(X, Y, 'r*');
        plot([-2 -1.009 -1.009 -2], [0 0 1 0], 'b', 'LineWidth', 3);
        plot([-1 0 0 -1 -1], [0 0 1 2 0], 'k', 'LineWidth', 3);
        plot([0.009 1 1 0.009 0.009], [0 0 2 1 0], 'b', 'LineWidth', 3);
        plot([1.009 2 1.009 1.009], [0 0 1 0], 'k', 'LineWidth', 3);
        hold off
    otherwise
        fprintf('Wrong exercise number.\n');
        fprintf('Available exercises are:\n');
        disp([2 3 4 5 6 7 9 10]);
end