function [p] = ComputePi(X, i)
    % Description:
    %   Compute the term v'(X(i)) required for the Lagrange Polynomial in its second
    %   form. v'(X(i)) is given by the formula:
    %       v'(X(i)) = \prod_{j = 0\\j \neq i}^n(X(i) - X(j))
    % Arguments:
    %   X - a set of points X(i).
    %   i - the indice of the term to leave out.
    % Usage:
    %   [pi] = ComputePi(X, i)
    %
    % Copyleft Alexandru Fikl 2012 (c)

    if nargin < 2
        error('not enough input arguments');
    end

    n = length(X);
    p = 1;
    for j = [1:i - 1, i + 1:n]
        p = p * (X(i) - X(j));
    end