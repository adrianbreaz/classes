function [A] = MatAleaTri(n, a, b)
    % Description:
    %   Generate a random nxn tridiagonal matrix with values in [a, b] (default [0, 1])
    % Arguments:
    %   n       (int)           - matrix dimension.
    %   [a, b]  (double, double)- interval for values (optional).
    % Usage:
    %   A = MatAleaTri(n[, a, b])
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2011

    % check assertions
    if nargin == 0
        error('not enough input arguments');
    end

    % set defaults
    if nargin < 3
        a = 0;
        b = 1;
    elseif b < a
        error('wrong interval (b < a)');
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                   ALGORITHM
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    A = MatAleaDiag(n, a, b);
    for i = 2:n
        A(i, i - 1) = a + (b - a) * rand;
        A(i - 1, i) = a + (b - a) * rand;
    end

