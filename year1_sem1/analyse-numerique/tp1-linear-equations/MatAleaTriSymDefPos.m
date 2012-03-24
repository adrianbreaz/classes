function [A] = MatAleaTriSymDefPos(n, a, b)
    % Description:
    %   Generate a random nxn tridiagonal symmetric positive definite matrix
    %   with values in [a, b] (default [0, 1])
    % Arguments:
    %   n       (uint)          - matrix dimension.
    %   [a, b]  (double, double)- interval for values (optional).
    % Usage:
    %   A = MatAleaTriSymDefPos(n[, a, b])
    % Warning:
    %   [a, b] is not the actual interval for the elements in the matrix due
    %   to the way it is constructed: A * A' where A is a lower triangular matrix.
    %   The actual interval is [2 * a^2, 2 * b^2].
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
    % create a invertible diagonal matrix to make sure our tridiagonal is also invertible
    A = MatAleaDiag(n, a, b, 1);
    for i = 2:n
        A(i, i - 1) = a + (b - a) * rand;
    end
    A = A * A';