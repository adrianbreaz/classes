function x = ResolveUpper(U, b)
    % Solve a system of equations Ux = b where U is a upper triangular
    % matrix.
    %
    % Algorithm:
    %   - start by computing x_n directly by x_n = \frac{b_i}{U_{i, i}}
    %   - compute all other x_i by the formula:
    %           \x_i = \frac{(b_i - \sum_{j = i + 1}^n U_{i, j} * x_j)}{U_{i, i}}
    %
    % Arguments:
    %   - U     - a nxn upper triangular matrix
    %   - b     - a vector in R^n
    %
    % Usage:
    %   x = ResolveUpper(U, b)
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

    if nargin < 2
        error('usage: ResolveUpper(U, b).');
    end

    n = length(U);
    x = zeros(n, 1);

    for i = n:-1:1
        sum = 0;
        for j = i + 1:n
            sum = sum + U(i,j) * x(j);
        end
        if ( U(i,i) == 0 )
            error('matrix not invertible! :(');
        end
        x(i) = (b(i) - sum) / U(i,i);
    end