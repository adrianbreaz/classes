function intf = Simpson38(f, a, b, n)
    % 3/8 Simpson rule for Numerical Integration. Uses the formula:
    %     I_i \approx \frac{h_i}{8} (f(x_i) + 3 * f(\frac{2x_i + x_{i + 1}}{3}) +
    %                                       + 3 * f(\frac{x_i + 2x_{i + 1}}{3}) +
    %                                       + f(x_{i + 1}))
    % where h_i = x_{i + 1} - x_i. The Simpson rule is part of the Newton-Coates
    % quadrature rules.
    %
    % Arguments:
    %   f               - function to integrate
    %   [a, b]          - interval in which to integrate
    %   n               - number of discretizations
    %
    % Usage:
    %   intf = Simpson38(f, a, b, n);
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

    % compute the step
    h = (b - a) / n;
    % compute each x_i
    x = a:h:b;
    % store the values for f(x_i) so we don't have to compute them twice
    y = f(x);

    % compute the integral using the composite 3/8 Simpson formula:
    %           I = (h / 8) * \sum_{i = 0}^{n - 1} ( f(x_i) +
    %                          + 3  * f(\frac{2x_i + x_{i + 1}}{3}) +
    %                          + 3  * f(\frac{x_i + 2x_{i + 1}}{3}) +
    %                          + f(x_{i + 1}))
    intf = h / 8 * sum(y(1:n) + 3 * f(x(1:n) + h / 3) + 3 * f(x(1:n) + 2 * h / 3) + y(2:n+1));