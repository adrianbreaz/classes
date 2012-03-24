function testLeastSquares(X, Y, type)
    % Test fonction for the least squares algorithm.
    %
    % Algorithm:
    %   - construct the matrix A.
    %   - solve the system A'*A*x = A'*b using LU decomposition.
    %   - draw the line/parabola/spline using the solution to the previous system.
    %
    % Arguments:
    %   - (X_i, Y_i)    - points in the plane
    %   - type          - 0 - line, 1 - parabola, 2 - spline.
    %
    % Usage:
    %   testLeastSquares(X, Y, type);
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

    if nargin < 3
        error('Usage: testLeastSquares(X, Y, type).');
    end

    n = length(X);

    % for each type we have a different matrix A and a different fonction that computes
    % the approximation.
    switch(type)
        case 0
            % line
            % solves y = a * x + b
            A = [ X ones(n, 1) ];
            f = @(c, x) c(1) .* x + c(2);
        case 1
            % parabola
            % solves y = a * x^2 + b * x + c
            A = [ X.^2 X ones(n, 1)];
            f = @(c, x) c(1) .* x.^2 + c(2) .* x + c(3);
        case 2
            % spline
            % solves y = a * x^3 + b * x^2 + c * x + d
            A = [ X.^3 X.^2 X ones(n, 1) ];
            f = @(c, x) c(1) .* x.^3 + c(2) .* x.^2 + c(3) .* x + c(4);
        otherwise
            error('unknown type given.');
    end

    % solve the system
    c = solveSystem(A' * A, A' * Y);
    x_line = linspace(min(X) - 1, max(X) + 1, 200);

    % draw the pretty pictures
    hold('on');
    plot(X, Y, 'r*');                   % draw the points
    plot(x_line, f(c, x_line));         % draw the approximation 'line'
    hold('off');
