function [x] = Tchebycheff(a, b, n)
    % Description:
    %   Compute n points of Tchebycheff for a given interval [a, b] with the formula:
    %       x = \frac{a + b}{2} + \frac{b - a}{2} * cos(\frac{(2i + 1) * \pi}{2(n + 1)})
    % Arguments:
    %   [a, b] - interval bounds.
    %   n - number of points.
    % Usage:
    %   [x] = Tchebycheff(a, b, n)
    %
    % Copyleft Alexandru Fikl 2011 (c)

    if nargin < 3
        error('not enough input arguments');
    end

    Li = [0:n];
    x = (a + b) / 2 + ((b - a) / 2) .* cos((2 * Li + 1) * pi / (2 * (n + 1)));