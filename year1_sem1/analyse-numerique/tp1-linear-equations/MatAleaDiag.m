function [A] = MatAleaDiag(n, a, b, invertible)
    % Description:
    %   Generate a random nxn diagonal matrix with values in [a, b] (default [0, 1])
    %   (default Not Invertible).
    % Arguments:
    %   n               (uint)          - matrix dimension.
    %   [a, b]          (double, double)- interval for values (optional).
    %   invertible      (bool)          - True if the matrix has to be invertible
    %   (i.e all diagonal elements are > 0) (optional).
    % Usage:
    %   A = MatAleaDiag(n[, a, b])
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

    if nargin < 4
        invertible = 0;
    end

    % initializations
    A = zeros(n, n);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                   ALGORITHM
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if invertible
        for i = 1:n
            while(abs(A(i, i)) < 1e-8)
                A(i, i) = a + (b - a) * rand;
            end
        end
    else
        for i = 1:n
            A(i, i) = a + (b - a) * rand;
        end
    end
