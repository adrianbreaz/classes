function u = SolveEq(f, area, border_func, border_type, N, M)
    % Simple solver for equations of the type:
    %   | -(u_{xx} + u_{yy}) + u = f    (1)
    %   | u = u_0                       (Dirichlet boundary condition)
    %   | u_n = g                       (Neumann boundary condition)
    %
    % Notation:
    %   u_{xx}  - second derivative on x
    %   u_n     - derivative with respect to the normal vector
    %
    % Arguments:
    %   f               given funtion as in the formula.
    %   area            an array [a, b, c, d] that forms the rectangle: [a, b]x[c, d].
    %   border_func     four functions for each border arranged in clockwise order
    %                   starting from the top.
    %   border_type     type of border condition (0 for Dirichlet and 1 for Neumann),
    %                   arranged in the same way as border_func.
    %   N               number of discretizations on the x axis.
    %   M               number of discretizations on the y axis.
    %
    % Returns:
    %   u               approximated function in the points (x_i, y_j)
    %
    % Usage:
    %   u = SolveEq(f, area, border_func, border_type, N, M);
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

    if nargin < 6
        error('Not enough arguments. Use help SolveEq.');
    end

    % The final u matrix:
    %   (x_1, y_M)                                              (x_N, y_M)
    %     1, M                       Top                           N, M
    %       ------------------------------------------------------
    %       |                                                    |
    %       |                                                    |
    %       |                                                    |
    %       |                                                    |
    %  Left |                                                    |  Right
    %       |                                                    |
    %       |                                                    |
    %       |                                                    |
    %       |                                                    |
    %       |                                                    |
    %       ------------------------------------------------------
    %   1, 1                        Bottom                       N, 1
    % (x_1, y_1)                                              (x_N, y_1)

    % function shortcuts
    gT = @(x, y) border_func(x, y)(1);      % top
    gR = @(x, y) border_func(x, y)(2);      % right
    gB = @(x, y) border_func(x, y)(3);      % bottom
    gL = @(x, y) border_func(x, y)(4);      % left

    % needed values
    deltax = (area(2) - area(1)) / N;
    deltax2 = deltax^2;
    deltay = (area(4) - area(3)) / M;
    deltay2 = deltay^2;
    n_ones = ones(N, 1);

    % we make a discretization of (1) as follows:
    %   u_{xx} ~= (u_{i - 1, j} + u_{i + 1, j} - 2 * u{i, j}) / deltax^2    (2)
    %   u_{yy} ~= (u_{i, j - 1} + u_{i, j + 1} - 2 * u{i, j}) / deltay^2    (3)
    % where u_{i, j} is an approximation of u(x_i, y_j). Using (2) and (3) we can
    % express (1) as follows:
    %   (u_{i - 1, j} + u_{i + 1, j} - 2 * u{i, j}) / deltax^2 +
    %   (u_{i, j - 1} + u_{i, j + 1} - 2 * u{i, j}) / deltay^2 +
    %   u_{i, j} = f_{i, j}
    % where f_{i, j} = f(x_i, y_j). From this equation we can extract the coeff
    % of each term:
    ui = 1 / deltax2;          % coeff of u_{i - 1, j} and u_{i + 1, j}
    uj = 1 / deltay2;          % coeff of u_{i, j - 1} and u_{i, j + 1}
    uij = (deltax2 * deltay2 - 2 * deltax2 - 2 * deltay2) / (deltax2 * deltay2);

    % The goal is to obtain a A * U = b system where:
    %   U = [u_11, ..., u_N1, u_12, ..., u_N2, ..., u_1M, ..., u_NM]
    % and the matrix A is:
    %       [ D_1   -I_1      0     ...     0  ]
    %       [-I_2   D_2     -I_1            .  ]
    %       [  0   .      .       .         .  ]
    %  A=   [  .     .      .       .       .  ]
    %       [  .       .      .       .     .  ]
    %       [  .         .      .       .   0  ]
    %       [  .         -I_2     D_2     -I_1 ]
    %       [  0     ...   0     -I_2      D_3 ]
    % where D_1, D_2, D_3, I_1 and I_2 are NxN matrices defined as follow:
    % TODO: this only works for dirichlet conditions.
    D_1 = diag(n_ones);
    D_3 = diag(n_ones);
    D_2 = full(spdiags([ui * n_ones uij * n_ones ui * n_ones], [-1 0 1], N, N));
    I_1 = -uj * diag(n_ones);
    I_2 = -uj * diag(n_ones);

    % take care of conditions on the left and right boundaries. (this is gonna
    % be interesting for von Neumann conditions. probably gonna have to rework
    % the assembley of A because each D_1(1, 1) and D_(N, N) is different.)
    D_2(1, 1) = 1;
    D_2(N, N) = 1;

    A = blktridiag(D_2, -I_2, -I_1, M);
    A(1:N, 1:N) = D_1;
    A((N - 1) * M: N * M, (N - 1) * M: N * M) = D_3;
    full(A)