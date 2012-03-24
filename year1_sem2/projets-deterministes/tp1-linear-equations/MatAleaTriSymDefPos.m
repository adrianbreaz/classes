function [A] = MatAleaTriSymDefPos(n, a, b)
    % Description:
    %   Generate a random nxn tridiagonal symmetric positive definite matrix
    %   with a dominant diagonal and values in [a, b]. (default [0, 1])
    % Arguments:
    %   n       (uint)          - matrix dimension.
    %   [a, b]  (double, double)- interval for values (optional).
    % Usage:
    %   A = MatAleaTriSymDefPos(n[, a, b])
    % Warning:
    %   [a, b] is not the actual interval for the elements in the matrix due
    %   to the way it is constructed: A * A' where A is a lower triangular matrix.
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2011-2012

    % TODO: figure out if shrinking it to back to [a, b] ruines any other properties.
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
    A = zeros(n, n);
    for i = 2:n
        A(i, i - 1) = a + (b - a) * rand;
    end

    % Idea:
    %   - compute the sum of the elements on each column and add one to make it
    %   strictly dominant.
    %   - the last element receives the value of the previous one seeing as the
    %   last column is always 0.
    %   - add this diagonal to the matrix.
    %   - compute a tridiagonal symmetric positive definite matrix. (inverse of the
    %   Cholesky method)
    x = 2 * sum(A) + 1;
    x(n) = x(n - 1);
    A = A + diag(x);
    A = A * A';