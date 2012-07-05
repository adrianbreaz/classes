function [X, Y] = acceptreject(f, g, grand, c, domain, n)
    % Compute a number of realizations of f(X) using the acceptance-rejection
    % algorithm.
    %
    % Arguments:
    %   - f     (function): arbitrary probability distribution function
    %   - g     (function): an intrumental distribution such that f < c * g.
    %   - grand (function): the inverse of g, that generates variables for it
    %   - c     (integer): the constant that makes the relation f < c * g true.
    %   - n     (integer): number of samples.
    %
    % Usage:
    %   c = sqrt(2 / pi) * exp(lambda^2 / 2) / lambda;
    %   x = rejectaccept(normcdf, expcdf, expinv, c, [0, 1]);
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

    X = rand(n, 1);
    Y = rand(n, 1);

    xa = domain(1);
    xb = domain(2);
    ya = domain(3);
    yb = domain(4);

    for i = 1:n
        x = xa + (xb - xa) * grand(rand());
        y = ya + (yb - ya) * rand();

        while f(x, y) < (c * g(x, y))
            x = xa + (xb - xa) * grand(rand());
            y = ya + (yb - ya) * rand();
        end

        X(i) = x;
        Y(i) = y;
    end