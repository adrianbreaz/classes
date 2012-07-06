function [X, Y] = acceptreject(rejected, randg, domain, n)
    % Uses the acception-rejection method to generate realizations of an arbitrary
    % PDF f(x) using another distribution described by the PDF g(x) for which
    % the generator is known. The relation between the two is usually:
    %       f(x) < c * g(x).
    % but can be more complex (given by the `rejected` function).
    %
    % Arguments:
    %   - rejected (function): a comparison function that returns 1 if the values are
    %   not in the domain and 0 otherwise.
    %   - randg   (function): generates variables in the distribution described by g.
    %   - n       (integer): number of samples.
    %
    % Usage: This will generate a normal distribution on [0, 1]:
    %   c = sqrt(2 / pi) * exp(lambda^2 / 2) / lambda;
    %   reject_func = @(x, y) normcdf(x) < c * y * expcdf(x);
    %   x = rejectaccept(reject_func, expinv, c, [0 1 0 1], 10000);
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

    X = rand(n, 1);
    Y = rand(n, 1);

    xa = domain(1);
    xb = domain(2);
    ya = domain(3);
    yb = domain(4);

    for i = 1:n
        x = xa + (xb - xa) * randg(rand());
        y = ya + (yb - ya) * rand();

        while rejected(x, y)
            x = xa + (xb - xa) * randg(rand());
            y = ya + (yb - ya) * rand();
        end

        X(i) = x;
        Y(i) = y;
    end