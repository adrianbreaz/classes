function [D, E, F] = MatSplit(A)
    % Description:
    %   Split the matrix A into 3 matrices D, E, F such that A = D - E - F, where
    %   D is diagonal, E is lower triangular and F upper triangular.
    % Arguments:
    %   A       (M_(n, n))      - matrix.
    % Usage:
    %   [D, E, F] = MatSplit(A)
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2011

    % check assertions
    if nargin == 0
        error('not enough input arguments');
    end

    [n, m] = size(A);
    if n ~= m
        error('matrix not square');
    end

    % initializations
    D = diag(diag(A));
    E = zeros(n, n);
    F = zeros(n, n);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                   ALGORITHM
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 1:n
        for j = 1:i - 1
            E(i, j) = -A(i, j);
            F(j, i) = -A(j, i);
        end
    end