function [pn] = LagrangeOpt(X, Y, x)
    % Description:
    %   Compute the Lagrange Polynomial in a point x. The Lagrange Polynomial
    %   in a given point x is computed by the alternative formula:
    %           P_n(x) = \frac{\sum_{i = 0}^n\frac{Y(i)}{(x - X(i)) * v'(X(i))}}
    %                         {\sum_{i = 0}^n\frac{1}{(x - X(i)) * v'(X(i))}}
    % Arguments:
    %   X, Y - a set of points X(i) and Y(i) corresponding to a given function
    %   such that f(X(i)) = Y(i).
    %   x - point in which to compute the polynomial.
    % Usage:
    %   [Pn] = LagrangeOpt(X, x, i)
    %
    % Copyleft Alexandru Fikl 2011 (c)

    if nargin < 3
        error('not enough input arguments');
    end

    n = length(X);
    pn1 = 0;
    pn2 = 0;
    for i = 1:n
        lower = (x - X(i)) * ComputePi(X, i);
        pn1 = pn1 + (Y(i) / lower);
        pn2 = pn2 + (1 / lower);
    end

    pn = pn1 / pn2;