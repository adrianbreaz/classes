function intf = MiddlePoint(f, a, b, n)
    % Middle Point rule for Numerical Integration. Uses the formula:
    %           I_i \approx h_i f(\frac{x_i + x_{i + 1}}{2})
    % where h_j = x_{i + 1} - x_i. The Middle Point rule is part of the Newton-Coates
    % quadrature rules.
    %
    % Arguments:
    %   f               - function to integrate
    %   [a, b]          - interval in which to integrate
    %   n               - number of discretizations
    %
    % Usage:
    %   intf = MiddlePoint(f, a, b, n);
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2011-2012

    % compute the step
    h = (b - a) / n;
    % compute each (x_i + x_{i + 1}) / 2 in that interval
    x = [a:h:b] + h / 2;

    % compute the integral using the composite Middle Point formula:
    %           I = h * \sum_{i = 0}^{n - 1} f(\frac{x_i + x_{i + 1}}{2})
    intf = h * sum(f(x(1:n)));