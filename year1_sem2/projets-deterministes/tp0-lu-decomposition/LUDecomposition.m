function [L, U] = LUDecomposition(A)
    % LU decomposition of a matrix A.
    %
    % Algorithm:
    %   - compute by columns
    %   - fix j and compute U_{i, j} using the formula:
    %           U_{i, j} = A_{i, j} - \sum_{k = 1}^{i - 1} L_{i, k} * U_{k, j}
    %   - fix j and compute L_{j, i} using the formula:
    %          L_{j, i} = \frac{A_{j, i} - \sum_{j = i + 1}^n L_{j, k} * U_{k, i}}{U_{i, i}}
    %
    % Arguments:
    %   - A     - a nxn matrix.
    %
    % Usage:
    %   [L, U] = LUDecomposition(A);
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

    if nargin < 1
        error('usage: [L, U] = LUDecomposition(A).');
    end

    n = length(A);
    L = eye(n);
    U = zeros(n, n);

    for i = 1:n
        % compute U_{i, j}
        for j = i:n
            sum = 0;
            for k = 1:i - 1
                sum = sum + L(i, k) * U(k, j);
            end
            U(i, j) = A(i, j) - sum;
        end

        % compute L_{j, i}
        for j = i + 1:n
            sum = 0;
            for k = 1:i - 1
                sum = sum + L(j, k) * U(k, i);
            end
            L(j, i) = (A(j, i) - sum) / U(i, i);
        end
    end