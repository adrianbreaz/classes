function [li] = ComputeLi(X, x, i)
    % Description:
    %   Compute the term L_i(x) required for the Lagrange Polynomial. L_i(x) is given
    %   by the formula:
    %       L_i(x) = \prod_{j = 0\\j \neq i}^n\frac{(x - X(j))}{(X(i) - X(j))}
    % Arguments:
    %   X - a set of points X(i).
    %   x - point in which the polynomial is being computed.
    %   i - the indice of the term to leave out.
    % Usage:
    %   [Li] = ComputeLi(X, x, i)
    %
    % Copyleft Alexandru Fikl 2011 (c)

    if nargin < 3
        error('not enough input arguments');
    end

    n = length(X);
    li = 1;
    for j = [1:i - 1, i + 1:n]
        li = li * (x - X(j)) / (X(i) - X(j));
    end