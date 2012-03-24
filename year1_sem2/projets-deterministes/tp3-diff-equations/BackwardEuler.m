function [y] = BackwardEuler(f, dfdx, y0, n, T)
    % The Backward (Implicit) Euler method for solving ordinary differential
    % equations such as:
    %   | y'(t) = f(t, y(t))
    %   | y(0) = y_0
    % using the formula:
    %   y_{n + 1} = y_n + h f(t_{n + 1}, y_{n + 1}).                        (1)
    %
    % Arguments:
    %   f       function given in the ODE
    %   dfdx    derivative of f
    %   y0      given initial value
    %   n       number of discretizations
    %   T       upper limit of the time interval [0, T]
    %
    % Usage:
    %   y = BackwardEuler(f, dfdx, y0[, n[, T]])
    %
    % Example:
    %   y = BackwardEuler(inline('sin(x)'), inline('cos(x)'), 0, 100, 0.5)
    %
    % NOTE: not very accurate.
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

    % some default values and precautions
    if nargin < 2
        error('Not enough arguments. Use help BackwardEuler');
    end

    if nargin < 3
        n = 100;
    end

    if nargin < 4
        T = 1;
    end

    % compute discretization step
    h = T / n;

    % time discretizations
    tn = 0:h:T;

    % init approximations
    y = zeros(1, n + 1);
    y(1) = y0;

    % compute using (1)
    % seeing as we could have nonlinear equations in y_{n+1} we're rewriting (1)
    % as a function in z = y_{n + 1}:
    %       F(z) = z - y_n - h * f(t_n, z)
    % and use the Newton Rhapson method to find a zero.
    % NOTE: Could have problems with this because:
    %       - the Newton method is famously dependent on its initial value
    %       - there may be multiple zeros and we're finding a 'wrong' one
    %       - should be interesting when F'(z) = 0
    i = 1;
    while i <= n
        % construct the functions needed for the Newton method
        F = @(z) z - y(i) - h * f(tn(i), z);
        dF = @(z) 1 - h * dfdx(tn(i), z);

        % use the Newton method to find a zero and continue
        y(i + 1) = NewtonSolver(F, dF, y(i));
        i = i + 1;
    end