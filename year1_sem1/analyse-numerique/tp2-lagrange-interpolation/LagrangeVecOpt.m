function [y] = LagrangeVecOpt(X, Y, x)
    % Description:
    %   Compute the Lagrange Polynomial in a vector of points x using the alternative formula.
    % Arguments:
    %   X, Y - a set of points X(i) and Y(i) corresponding to a given function
    %   such that f(X(i)) = Y(i).
    %   x - a vector of points in which to compute the Lagrange Polynomial.
    % Usage:
    %   [y] = LagrangeVecOpt(X, Y, x)
    %
    % Copyleft Alexandru Fikl 2011 (c)

    if nargin < 3
        error('not enough input arguments');
    end

    m = length(x);
    y = zeros(m, 1);
    for i = 1:m
        y(i) = LagrangeOpt(X, Y, x(i));
    end