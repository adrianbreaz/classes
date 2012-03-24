function intf = Trapezoid(f, a, b, n)
    % Trapezoid rule for Numerical Integration. Uses the formula:
    %     I_i \approx \frac{h_i}{2} (f(x_i) + f(x_{i + 1}))
    % where h_i = x_{i + 1} - x_i. The Simpson rule is part of the Newton-Coates
    % quadrature rules.
    %
    % Arguments:
    %   f               - function to integrate
    %   [a, b]          - interval in which to integrate
    %   n               - number of discretizations
    %
    % Usage:
    %   intf = Trapezoid(f, a, b, n);
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2011-2012

    % compute the step
    h = (b - a) / n;
    % compute each x_i
    x = a:h:b;
    % store the values for f(x_i) so we don't have to compute them twice
    y = f(x);

    % compute the integral using the composite Trapezoid formula:
    %           I = (h / 2) * \sum_{i = 0}^{n - 1} ( f(x_i) + f(x_{i + 1}))
    intf = h / 2 * sum(y(1:n) + y(2:n+1));