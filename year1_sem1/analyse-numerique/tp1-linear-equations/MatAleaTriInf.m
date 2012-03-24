function [A] = MatAleaTriInf(n, a, b)
    % Description:
    %   Generate a random nxn invertible lower triangular matrix with values in [a, b]
    %   (default [0, 1])
    % Arguments:
    %   n       (int)           - matrix dimension.
    %   [a, b]  (double, double)- interval for values (optional).
    % Usage:
    %   A = MatAleaTriInf(n[, a, b])
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
    % create a invertible diagonal matrix to make our lower triangular is also invertible
    A = MatAleaDiag(n, a, b, 1);
    for i = 2:n
        for j = 1:i - 1
            A(i, j) = a + (b - a)  * rand;
        end
    end
