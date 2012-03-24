function [y] = CrankNicolson(f, dfdx, y0, n, T)
    % The Crank-Nicolson method for solving ordinary differential
    % equations such as:
    %   | y'(t) = f(t, y(t))
    %   | y(0) = y_0
    % using the formula:
    %   y_{n + 1/2} = y_n + \frac{h}{2} * f(t_n + \frac{h}{2}, y_{n + 1/2})
    %   y_{n + 1} = y_n + h * f(t_n + \frac{h}{2}, y_{n + 1/2})                 (1)
    %
    % Arguments:
    %   f       function given in the ODE
    %   dfdx    derivative of f
    %   y0      given initial value
    %   n       number of discretizations
    %   T       upper limit of the time interval [0, T]
    %
    % Usage:
    %   y = CrankNicolson(f, y0[, n[, T]])
    %
    % Example:
    %   y = CrankNicolson(inline('cos(x)'), 1, 100, 0.5)
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

    % some default values and precautions
    if nargin < 2
        error('Not enough arguments. Use help CrankNicolson');
    end

    if nargin < 3
        n = 100;
    end

    if nargin < 4
        T = 1;
    end

    % compute discretization step
    h = T / n;

    % get discretizations of time interval
    tn = 0:h:T;

    % init approximations
    y = zeros(1, n + 1);
    y(1) = y0;

    % compute using (1)
    % seeing as we could have nonlinear equations in y_{n+1/2} we're rewriting (1)
    % as a function in z = y_{n + 1/2}:
    %       F(z) = z - y_n - h * f(t_n + h / 2, z) / 2
    % and use the Newton Rhapson method to find a zero.
    % NOTE: Could have problems with this because:
    %       - the Newton method is famously dependent on its initial value
    %       - there may be multiple zeros and we're finding a 'wrong' one
    %       - should be interesting when F'(z) = 0
    i = 1;
    while i <= n
        % construct the functions needed for the Newton method
        F = @(z) z - y(i) - h * f(tn(i) + h / 2, z) / 2;
        dF = @(z) 1 - h * dfdx(tn(i) + h / 2, z) / 2;

        % use the Newton method to find a zero, thus a value of y_{n + 1/2}
        y12 = NewtonSolver(F, dF, y(i));

        % once we have y_{n + 1/2} compute y_{n + 1} directly
        y(i + 1) = y(i) + h * f(tn(i) + h / 2, y12);
        i = i + 1;
    end