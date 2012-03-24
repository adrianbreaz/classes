function [x] = NewtonSolver(f, dfdx, x0, tol, nmax)
    % The Newton Rhapson method for finding the roots of a real valued function
    % using the following formula with an initial value x_0:
    %   x_{n + 1} = x_n + \frac{f(x_n)}{f'(x_n)}.
    %
    % Arguments:
    %   f       a real valued function
    %   dfdx    the derivative of f
    %   x0      initial value
    %   tol     tolerance, i.e. min |x_n - x_{n - 1}| for all n
    %   nmax    maximum number of iterations
    %
    % Usage:
    %   [x] = NewtonSolver(f, dfdx, x0[, tol[, nmax]]);
    %
    % TODO: extend this to f: R^d -> R^d using jacobian matrices and stuff.
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

    % some defaults and precautions
    if nargin < 3
        error('Not enough arguments. Use help NewtonSolver.');
    end

    if nargin < 4
        tol = 1e-4;
    end

    if nargin < 5
        nmax = 10e+1;
    end

    % iterate !!!
    epsilon = tol;
    k = 1;
    while (epsilon >= tol) && (k <= nmax)
        % compute x_{n + 1}
        x = x0 - (f(x0) / dfdx(x0));

        % new error
        epsilon = norm(x - x0);

        k = k + 1;
        x0 = x;
    end