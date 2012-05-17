function u = SolveEq(f, area, gT, gR, gB, gL, bt, N, M)
    % Simple solver for equations of the type:
    %   | -(u_{xx} + u_{yy}) + u = f    (1)
    %   | u = u_0                       (Dirichlet boundary condition)
    %   | u_n = g                       (von Neumann boundary condition)
    %
    % Notation:
    %   u_{xx}  - second derivative on x
    %   u_n     - derivative with respect to the normal vector
    %
    % Arguments:
    %   f               given funtion as in the formula.
    %   area            an array [a, b, c, d] that forms the rectangle:
    %                   [a, b]x[c, d].
    %   gT              function for top border.
    %   gR              function for right border.
    %   gB              function for bottom border.
    %   gL              function for lft border.
    %   bt              type of border condition (0 for Dirichlet and 1
    %                   for von Neumann).
    %                   arranged in the same way as border_func.
    %   N               number of discretizations on the x axis.
    %   M               number of discretizations on the y axis.
    %
    % Returns:
    %   u               approximated function in the points (x_i, y_j)
    %
    % Usage:
    %   u = SolveEq(f, area, gT, gR, gB, gL, bt, N, M);
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

    if nargin < 9
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

    % needed values
    deltax = (area(2) - area(1)) / N;
    deltax2 = deltax^2;
    deltay = (area(4) - area(3)) / M;
    deltay2 = deltay^2;
    n_ones = diag(ones(N, 1));
    DIRICHLET = 0;  % NEUMANN = 1;

    x = area(1):deltax:area(2) - deltax;
    y = area(3):deltay:area(4) - deltay;
    [X, Y] = meshgrid(x, y);

    % we make a discretization of (1) as follows:
    %   u_{xx} ~= (u_{i - 1, j} + u_{i + 1, j} - 2 * u{i, j}) / deltax^2    (2)
    %   u_{yy} ~= (u_{i, j - 1} + u_{i, j + 1} - 2 * u{i, j}) / deltay^2    (3)
    % where u_{i, j} is an approximation of u(x_i, y_j). Using (2) and (3) we can
    % express (1) as follows:
    %   -(u_{i - 1, j} + u_{i + 1, j} - 2 * u{i, j}) / deltax^2 +
    %   -(u_{i, j - 1} + u_{i, j + 1} - 2 * u{i, j}) / deltay^2 +
    %   u_{i, j} = f_{i, j}
    % where f_{i, j} = f(x_i, y_j). From this equation we can extract the coeff
    % of each term:
    ui = (-1 / deltax2) * ones(N, 1);          % coeff of u_{i - 1, j} and u_{i + 1, j}
    uj = (-1 / deltay2) * ones(N, 1);          % coeff of u_{i, j - 1} and u_{i, j + 1}
    uij = (1 + 2 * 1 / deltax2 + 2 * 1 / deltay2) .* ones(N, 1);

    % For the Dirichlet boundary conditions we already know the values of u_{i, j},
    % but in the case of von Neumann we also have derivatives and need to
    % approximate. As an example of this we take the bottom boundary (j = 1) where
    % we are given a condition of the type:
    %       u_n = -u_y = -g_B,
    % we can approximate u_y in the point (i, 1) using:
    %       u_y = (u_{i, 2} - u_{i, 0}) / 2 * deltay = g^B,
    % and obtain a value of u_{i, 0}:
    %       u_{i, 0} = u_{i, 2} + 2 * deltax * g^B_i.         (2)
    % From this we can give an approximation of u_{yy} on the bottom boundary (j = 1)
    % by replacing u_{i, 0} with (2). We get:
    %   -(u_{i - 1, 1} + u_{i + 1, 1} - 2 * u{i, 1}) / deltax^2 +
    %   -(2 * u_{i, 2} - 2 * u{i, 1}) / deltay^2 +
    %   u_{i, 1} = f_{i, 1} - 2 / deltay * g^B_i
    % The same procedure can be used to obtain formulae for the other boundaries.

    % The goal is to obtain an A * U = b system where:
    %   U = [u_11, ..., u_N1, u_12, ..., u_N2, ..., u_1M, ..., u_NM]
    % and the matrix A is:
    %
    %       [ D_1   -I_2      0      ...    0  ]
    %       [-I_1    D_2    -I_1            .  ]
    %       [  0   .      .       .         .  ]
    %  A =  [  .     .      .       .       .  ]
    %       [  .       .      .       .     .  ]
    %       [  .         .      .       .   0  ]
    %       [  .         -I_1     D_2     -I_1 ]
    %       [  0    ...    0     -I_3      D_3 ]
    %
    % where D_2 and I_1 are NxN matrices defined as follows (all matrices
    % are dependent on what conditions are imposed at the limits):
    D_2 = full(spdiags([ui uij ui], [-1 0 1], N, N));
    I_1 = -diag(uj);

    % The conditions imposed at the limits of our domain (given by the area vector)
    % can be of two types: Dirichlet or von Neumann conditions.
    %
    % For Dirichlet the following changes are necessary to the matrices defined
    % above:
    %   == D_1 is the identity matrix. this matrix is used for the bottom of our
    %   domain (j = 1) and all the values of u_{i, j} are known.
    %   == D_2 contains both the right and the left boundaries (at i = 1 and
    %   i = N) so the positions (1, 1) and (N, N) become 1 and (1, 2) and (N, N - 1)
    %   become 0.
    %   == D_3 is identical to D_1 and coresponds to the top of our domain (j = M).
    %   == I_1 is an identity matrix with the (1, 1) and (N, N) positions
    %   equal to 0 as a result of the left and right boundary conditions.
    %   == I_2 and I_3 are both the zero matrix.
    %
    % For von Neumann:
    %   == D_1 and D_3 are equal to D_2 as stated above.
    %   == D_2 doubles it's (1, 2) and (N, N - 1) positions as a result of
    %   the left and right boundary conditions
    %   == I_1 doesn't change
    %   == I_3 and I_2 double the value of the diagonal as a result of the top and
    %   bottom conditions.
    %
    % NOTE: these conditions can be applied any number of boundaries mixing and
    % twisting all we want.
    if bt(2) == DIRICHLET   % right
        D_2(N, N) = 1;
        D_2(N, N - 1) = 0;
        I_1(N, N) = 0;
    else   % == NEUMANN
        D_2(N, N - 1) = -2 / deltax2;
    end

    if bt(4) == DIRICHLET    % left
        D_2(1, 1) = 1;
        D_2(1, 2) = 0;
        I_1(1, 1) = 0;
    else   % == NEUMANN
        D_2(1, 2) = -2 / deltax2;
    end

    % construct the matrix A
    A = blktridiag(D_2, -I_1, -I_1, M);

    % fix the diagonal (A_11 and A_MM)
    if bt(3) == DIRICHLET
        A(1:N, 1:N) = n_ones;
    end
    if bt(1) == DIRICHLET
        A((N - 1) * M + 1: N * M, (N - 1) * M + 1: N * M) = n_ones;
    end

    % Fix the upper and lower parts (A12 and A_{M, M - 1})
    if bt(3) == DIRICHLET   % bottom
        A(1:N, N + 1:2 * N) = zeros(N);
    else   % == NEUMANN
        A(1:N, N + 1:2 * N) = 2 * I_1;
    end

    if bt(1) == DIRICHLET   % top
        A((N - 1) * M + 1: N * M, (N - 2) * M + 1:(N - 1) * M) = zeros(N);
    else   % == NEUMANN
        A((N - 1) * M + 1: N * M, (N - 2) * M + 1:(N - 1) * M) = 2 * I_1;
    end

    % construct the result array
    b = reshape(f(X, Y), N * M, 1);

    % fix values for borders when y is constant
    if bt(1) == DIRICHLET   % top
        b((N - 1) * M + 1: N * M) = gT(x);
    else   % == NEUMANN
        b((N - 1) * M + 1: N * M) = b((N - 1) * M + 1: N * M) + 2 / deltay * gT(x)';
    end

    if bt(3) == DIRICHLET   % bottom
        b(1:N) = gB(x);
    else    % == NEUMANN
        b(1:N) = b(1:N) - 2 / deltay * gB(x)';
    end

    % fix right and left
    if bt(2) == DIRICHLET   % right
        b(N:N:N * M) = gR(y);
    else   % == NEUMANN
        b(N:N:N * M) = b(N:N:N * M) + 2 / deltax * gR(y)';
    end

    if bt(4) == DIRICHLET   % left
        b(1:N:N * (M - 1) + 1) = gL(y);
    else   % == NEUMANN
        b(1:N:N * (M - 1) + 1) = b(1:N:N * (M - 1) + 1) - 2 / deltax * gL(y)';
    end

    u = A \ b;

    u = reshape(u, N, M)';
