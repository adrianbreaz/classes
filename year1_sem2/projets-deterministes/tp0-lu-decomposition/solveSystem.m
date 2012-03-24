function x = solveSystem(A, b)
    % Solve a system Ax = b using LU decomposition.
    %
    % Algorithm:
    %   - decompose A into L and U, where L is lower triangular and U is upper
    %   triangular
    %   - Solve Ly = b and Ux = y.
    %
    % Arguments:
    %   - A     - a nxn matrix
    %   - b     - a vector in R^n
    %
    % Usage:
    %   x = solveSystem(A, b)
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

    if nargin < 2
        error('Usage: x = solveSystem(A, b).');
    end

    [L, U] = LUDecomposition(A);
    x = ResolveUpper(U, ResolveLower(L, b));