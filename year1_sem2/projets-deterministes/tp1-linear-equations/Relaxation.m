function [x0, it, err] = Relaxation(A, b, x0, omega, tol, maxIt)
    % Description:
    %   Solve the system of equations A * x = b using the Succesive over-relaxation
    %   (S.O.R.) method.
    % Arguments:
    %   A       (M_(n, n))      - matrix.
    %   b       (R^n)           - vector.
    %   x0      (R^n)           - initial value for the system. (optional)
    %   omega   (double)        - relaxation factor. (optional)
    %   tol     (double)        - minimum tolerance for norm(x_(k + 1) - x_k). (optional)
    %   maxIt   (uint)          - maximum number of iterations. (optional)
    % Usage:
    %   [x, iterations] = Relaxation(A, b[, x0[, omega[, tol[, maxIt]]]])
    % Warning:
    %   The relaxation factor is chosen at random from [0, 2] if not provided.
    %   Wikipedia says that if omega < 1 it could make a divergent process converge and
    %   if omega > 1 it could make a convergent process converge faster.
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2011-2012

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
        omega = 2 * rand;
    end

    if nargin < 5
        tol = 1e-8;
    end

    if nargin < 6
        maxIt = 100;
    end

    % initializations
    it = 0;
    epsilon = tol;
    x1 = zeros(n, 1);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                   ALGORITHM
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    while epsilon >= tol && it < maxIt
        % compute x1
        for i = 1:n
            % compute x1(i) as in Gauss-Seidel
            sum = b(i);
            for j = 1:i - 1
                sum = sum - A(i, j) * x1(j);
            end

            for j = i + 1:n
                sum = sum - A(i, j) * x0(j);
            end

            % x1(i) for SOR = omega * x1(i) for GS + (1 - w) * x0(i);
            x1(i) = omega * sum / A(i, i) + (1 - omega) * x0(i);
        end

        % compute || x0 - x1 ||
        epsilon = norm(x0 - x1, 2);
        err(it + 1) = epsilon;
        it = it + 1;
        x0 = x1;
    end
