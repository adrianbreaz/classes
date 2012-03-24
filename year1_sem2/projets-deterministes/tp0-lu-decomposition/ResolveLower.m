function x = ResolveLower(L, b)
    % Solve a system of equations Lx = b where L is a lower triangular
    % matrix.
    %
    % Algorithm:
    %   - start by computing x_1 directly by x_1 = \frac{b_1}{L_{1, 1}}
    %   - compute all other x_i by the formula:
    %           \x_i = \frac{(b_i - \sum_{j = i + 1}^n L_{i, j} * x_j)}{L_{i, i}}
    %
    % Arguments:
    %   - L     - a nxn lower triangular matrix
    %   - b     - a vector in R^n
    %
    % Usage:
    %   x = ResolveLower(U, b)
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

    if nargin < 2
        error('usage: ResolveLower(L, b).');
    end

    n = length(L);
    x = zeros(n, 1);

    for i = 1:n
        sum = 0;
        for j = 1:i - 1
            sum = sum + L(i,j) * x(j);
        end
        if ( L(i,i) == 0 )
            error('matrix not invertible! :(');
        end
        x(i) = (b(i) - sum) / L(i,i);
    end