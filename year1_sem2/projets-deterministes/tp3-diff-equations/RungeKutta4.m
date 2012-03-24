function [y] = RungeKutta4(f, y0, n, T)
    % The Runge Kutta 4 method for solving ordinary differential
    % equations such as:
    %   | y'(t) = f(t, y(t))
    %   | y(0) = y_0
    % using the formula:
    %    k_1^n = f(t_n, y_n);
    %    k_2^n = f(t_n + \frac{h}{2}, y_n + \frac{h}{2} * k_1^n);
    %    k_3^n = f(tn(i) + h / 2, y(i) + \frac{h}{2} * k2);
    %    k_4^n = f(tn(i + 1), y(i) + h * k3);
    %    y(i + 1) = y(i) + h * (k1 + 2 * k2 + 2 * k3 + k4) / 6;         (1)
    %
    % Arguments:
    %   f       function given in the ODE
    %   y0      given initial value
    %   n       number of discretizations
    %   T       upper limit of the time interval [0, T]
    %
    % Usage:
    %   y = RungeKutta4(f, y0[, n[, T]])
    %
    % Example:
    %   y = RungeKutta4(inline('cos(x)'), 1, 100, 0.5)
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

    % some default values and precautions
    if nargin < 2
        error('Not enough arguments. Use help RungeKutta4');
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

    % compute for each t_n using (1)
    i = 1;
    while i < n
        k1 = f(tn(i), y(i));
        k2 = f(tn(i) + h / 2, y(i) + h * k1 / 2);
        k3 = f(tn(i) + h / 2, y(i) + h * k2 / 2);
        k4 = f(tn(i + 1), y(i) + h * k3);
        y(i + 1) = y(i) + h * (k1 + 2 * k2 + 2 * k3 + k4) / 6;
        i = i + 1;
    end