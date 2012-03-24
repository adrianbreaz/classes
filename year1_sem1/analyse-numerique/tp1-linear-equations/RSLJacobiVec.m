function [x0, it] = RSLJacobiVec(A, b, x0, tol, maxIt)
    % Description:
    %   Solve the system of equations A * x = b using the Jacobi method. (vectorial variant)
    % Arguments:
    %   A       (M_(n, n))      - matrix.
    %   b       (R^n)           - vector.
    %   x0      (R^n)           - initial value for the system. (optional)
    %   tol     (double)        - minimum tolerance for norm(x_(k + 1) - x_k). (optional)
    %   maxIt   (uint)          - maximum number of iterations. (optional)
    % Usage:
    %   [x, iterations] = RSLJacobiVec(A, b[, x0[, tol[, maxIt]]])
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2011

    % check assertions
    if nargin < 2
        error('not enough input arguments');
    end

    [n, m] = size(A);
    if n ~= m
        error('matrix not square');
    end

    if length(b) ~= n
        error('vector b is the wrong size');
    end

    % save ourselves some trouble by making sure the vectors are column vectors.
    if size(b, 1) == 1
        b = b';
    end

    if nargin > 2
        if length(x0) ~= n
            error('vector x0 is the wrong size');
        end

        if size(x0, 1) == 1
            x0 = x0';
        end
    else
        x0 = b;
    end

    if nargin < 4
        tol = 1e-8;
    end

    if nargin < 5
        maxIt = 100;
    end

    % initializations
    [D, E, F] = MatSplit(A);
    it = 0;
    epsilon = tol;
    N = E + F;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                   ALGORITHM
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    while epsilon >= tol && it < maxIt
        % compute x1
        x1 = RSLDiag(D, N * x0 + b);

        % compute || x0 - x1 ||
        epsilon = norm(x0 - x1);
        it = it + 1;
        x0 = x1;
    end