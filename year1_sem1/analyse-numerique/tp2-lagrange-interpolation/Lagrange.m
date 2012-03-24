function [pn] = Lagrange(X, Y, x)
    % Description:
    %   Compute the Lagrange Polynomial in a point x. The Lagrange Polynomial
    %   in a given point x is computed by the formula:
    %           P_n(x) = \sum_{j = 0}^nY(i) * L_i(x)
    % Arguments:
    %   X, Y - a set of points X(i) and Y(i) corresponding to a given function
    %   such that f(X(i)) = Y(i).
    %   x - point in which to compute the polynomial.
    % Usage:
    %   [Pn] = Lagrange(X, Y, x)
    %
    % Copyleft Alexandru Fikl 2011 (c)

    if nargin < 3
        error('not enough input arguments');
    end

    n = length(X);
    pn = 0;
    for i = 1:n % n
        pn = pn + Y(i) * ComputeLi(X, x, i);
    end
