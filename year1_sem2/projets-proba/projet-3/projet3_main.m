close all;
clear all;

% Project 3: Acceptance-rejection method.
%
% Students:
%   Adrian Breaz
%   Alexandru Fikl
%
% Description: http://en.wikipedia.org/wiki/Rejection_sampling :
%   - sample x from g(x) and u from U[0, 1]
%   - check if f(x) < u * M * g(x)
%   - if yes, accept x as a realisation of f
%   - if not, try again
%
% Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012


n = 2500;

disp([2 3 4 5 6 7 9 10]);
exercise = input('Give exercise number: ');

switch exercise
    case 2
        % Simulate a normal variable using an exponential variable which we
        % know how to generate using the inverse method.
        %
        % g(x) = lambda * exp(-lambda * x) and the best lambda is:
        lambda = 1;

        % the required c (minimizes f/g)
        c = sqrt(2 / pi) * exp(lambda^2 / 2) / lambda;

        % get an array of normally distributed variables on [0, inf]
        reject_func = @(x, y) normcdf(x) < c * y * expcdf(x, lambda);
        icdfexp = @(x) expinv(x, lambda);
        X = acceptreject(reject_func, icdfexp, [0 1 0 1], n);

        % with a probability of 0.5 make it symmetric
        X = (-1).^(randi([0, 1], n, 1)) .* X;

        % plot the result
        hold on;
        cdfplot(X);
        h = cdfplot(norminv(rand(n, 1)));
        set(h, 'Color', 'r');
        legend('Approximation', 'Normal Distribution');
        title('Simulate a normally distributed variable');
        hold off
    case 3
        % Generate (X, Y) uniformly on a square [0, 1]x[0, 1]
        reject_func = @(x, y) (x + y) > 2
        [X, Y] = acceptreject(reject_func, @(x) x, [0 1 0 1], n);

        hold on;
        plot(X, Y, 'r*');
        plot([0 1 1 0 0], [0 0 1 1 0], 'LineWidth', 3); % draw the square boundaries
        hold off;
    case 4
        % Generate (X, Y) uniformly on a triangle (0, 0), (1, 0), (0, 1)
        reject_func = @(x, y) (x + y) > 1;
        [X, Y] = acceptreject(reject_func, @(x) x, [0 1 0 1], n);

        hold on;
        plot(X, Y, 'r*');
        plot([0 1 0 0], [0 0 1 0], 'LineWidth', 3); % draw the triangle boundaries
        hold off
    case 5
        % Generate (X, Y) uniformly on the unit disk
        % limits of x and y
        a = 1;
        b = -1;
        r = 1;      % radius

        reject_func = @(x, y) x.^2 + y.^2 > r;
        [X, Y] = acceptreject(reject_func, @(x) x, [a b a b], n);

        hold on;
        plot(X, Y, 'r*');
        plot(r * cos(linspace(0, 2 * pi, 100)), r * sin(linspace(0, 2 * pi, 100)), 'LineWidth', 3);
        hold off;
    case 6
        % Generate (X, Y) uniformly in the set:
        %   D_f = {(x, y) \in R^2: 0 <= y <= f(x)}
        % for a given f(x) = 3 * x^2;
        f = @(x) 3 * x.^2;

        % limits of x
        a = 1;
        b = 0;

        % limits of f(x)
        c = 3;
        d = 0;

        reject_func = @(x, y) f(x) < y;
        [X, Y] = acceptreject(reject_func, @(x) x, [a b c d], n);

        Z = linspace(0, 1, 100);

        hold on;
        plot(X, Y, 'r*');
        plot(Z, f(Z), 'LineWidth', 3);   % draw the function
        hold off;
     case 7
        % Generate X with the density f.
        f = @(x, y) 2 * sqrt(1 - x.^2) / pi;
        c =  4/pi;

        % limits of x
        a = 1;
        b = -1;

        reject_func = @(x, y) f(x) < c * y.^2 / 2;
        [X, Y] = acceptreject(reject_func, @(x) x, [a b 0 1], n);

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
        f = @(x, y) (1 + mod(x + 1, 2)) / 150;
        c = 4/3;

        reject_func = @(x, y) f(x) < c * y / 100;
        X = acceptreject(reject_func, @(x) round(99 * x + 1), [0 1 0 1], n);

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

        % generate indexes of the regions with the required probabilities.
        reject_func = @(x, y) q(x) <= (c * p * y);
        randg = @(x) randi(4);
        Z= acceptreject(reject_func, randg, [0 1 0 1], n);

        % generate the required number of points in each region.
        X = [];
        Y = [];
        for i = 1:4
            % get number of points to be added to region i
            ncoeff = length(find(Z == i));

            % generate the points
            reject_func = @(x, y) y > (a1(i) * x + a2(i));
            [X1, Y1] = acceptreject(reject_func, @(x) x, [xa(i) xb(i) ya(i) yb(i)], ncoeff);

            % add to the final vectors.
            X = vertcat(X, X1);
            Y = vertcat(Y, Y1);
        end

        subplot(2, 1, 1)
        hist(Z, 4);
        subplot(2, 1, 2)
        hold on;
        plot(X, Y, 'r*');
        plot([-2 -1 -1 -2], [0 0 1 0], 'b', 'LineWidth', 3);
        plot([-1 0 0 -1 -1], [0 0 1 2 0], 'k', 'LineWidth', 3);
        plot([0 1 1 0 0], [0 0 2 1 0], 'b', 'LineWidth', 3);
        plot([1 2 1 1], [0 0 1 0], 'k', 'LineWidth', 3);
        hold off
    otherwise
        fprintf('Wrong exercise number.\n');
end
