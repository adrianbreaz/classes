function intf = Rectangle(f, a, b, n)
    % Rectangle rule for Numerical Integration. Uses the formula:
    %           I_i \approx h_i f(x_{i + 1})
    % where h_i = x_{i + 1} - x_i. The Rectangle rule is part of the Newton-Coates
    % quadrature rules.
    %
    % Arguments:
    %   f               - function to integrate
    %   [a, b]          - interval in which to integrate
    %   n               - number of discretizations
    %
    % Usage:
    %   intf = Rectangle(f, a, b, n);
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

    % compute the step
    h = (b - a) /n;
    % compute each x_i
    x = [a:h:b];

    % compute the integral using the composite Rectangle formula:
    %           I = h * \sum_{i = 0}^{n - 1} f(x_{i + 1})
    intf = h * sum(f(x(2:n)));