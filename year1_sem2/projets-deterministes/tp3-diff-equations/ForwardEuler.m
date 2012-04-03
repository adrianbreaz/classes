function [y] = ForwardEuler(f, y0, n, T)
    % The Forward (Explicit) Euler method for solving ordinary differential
    % equations such as:
    %   | y'(t) = f(t, y(t))
    %   | y(0) = y_0
    % using the formula:
    %   y_{n + 1} = y_n + h f(t_n, y_n).                        (1)
    %
    % Arguments:
    %   f       function given in the ODE
    %   y0      given initial value
    %   n       number of discretizations
    %   T       upper limit of the time interval [0, T]
    %
    % Usage:
    %   y = ForwardEuler(f, y0[, n[, T]])
    %
    % Example:
    %   y = ForwardEuler(inline('cos(x)'), 1, 100, 0.5)
    %
    % NOTE: not very stable or very accurate.
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

    % some default values and precautions
    if nargin < 2
        error('Not enough arguments. Use help ForwardEuler');
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
    y = zeros(length(y0), n + 1);
    y(:, 1) = y0;

    % compute for each t_n using (1)
    i = 1;
    while i <= n
        y(:, i + 1) = y(:, i) + h * f(tn(i), y(:, i));
        i = i + 1;
    end
