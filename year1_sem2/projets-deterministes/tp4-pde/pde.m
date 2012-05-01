function u = SolvePoisson(f, area, border_func, border_type, N, M)
    % Simple solver for equations of the type:
    %   | -(u_{xx} + u_{yy}) + u = f
    %   | u = u_0                       (Dirichlet boundary condition)
    %   | u_n = g                       (Neumann boundary condition)
    % that are a slight modification of Poisson equations.
    %
    % Notation:
    %   u_xx - second derivative on x
    %   u_n  - derivative with respect to the normal vector
    %
    % Arguments:
    %   f               given funtion as in the formula.
    %   area            rectangular area [a, b]x[c, d].
    %   border_func     four functions for each border
    %   border_type     type of border condition (0 for Dirichlet and 1 for Neumann).
    %   N               number of discretizations on the x axis
    %   M               number of discretizations on the y axis
    %
    % Returns:
    %   u               approximated function in the points (x_i, y_j)
    %
    % Usage:
    %   u = SolvePoisson(f, area, border_func, border_type, N, M);
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

    if nargin < 6
        error('Not enough arguments. Use help SolvePoisson.');
    end

    % needed values
    deltax = (area(2) - area(1)) / N;
    deltax2 = deltax^2;
    deltay = (area(4) - area(3)) / M;
    deltay2 = deltay^2;
    h = 2 * deltax2 + 2 * deltay2 - deltax2 * deltay2;

    % MATRIX NOTATION:
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

    % newly defined functions to make it easier to work with indices
    fn = @(k, l) f(area(1) + k * deltax, area(3) + l * deltay);
    gT = @(k, l) border_func(area(1) + k * deltax, area(3) + l * deltay)(1);
    gR = @(k, l) border_func(area(1) + k * deltax, area(3) + l * deltay)(2);
    gB = @(k, l) border_func(area(1) + k * deltax, area(3) + l * deltay)(3);
    gL = @(k, l) border_func(area(1) + k * deltax, area(3) + l * deltay)(4);

    % Fill in the respective borders and starting positions in case of Dirichlet
    % boundary types
    % TOP
    u = zeros(N, M)
    if border_type[1] == 0
        u(:, M) = border_func(area(1):deltax:area(2), area(4))(1)
        ej = M - 1
    else
        ej = M
    end

    % RIGHT
    if border_type[2] == 0
        u(N, :) = border_func(area(2), area(3):deltay:area(4))(2)
        ei = N - 1
    else
        ei = N
    end

    % BOTTOM
    if border_type[3] == 0
        u(:, 1) = border_func(area(1):deltax:area(2), area(3))(3)
        sj = 2
    else
        sj = 1
    end

    % LEFT
    if border_type[4] == 0
        u(1, :) = border_func(area(1), area(3):deltay:area(4))(4)
        si = 2
    else
        si = 1
    end

    % inits
    u_old = u;
    epsilon = tol;
    it = 0;

    while epsilon >= tol && it < it_max
        for i = si:ei
            for j = sj:ej
                % TODO: compute all the border derivatives for Neumann
                if j == M
                    % TOP Neumann border
                    u(i, j) = deltax2 * (u(i, j - 1) + u(i, j + 1));
                    u(i, j) = u(i, j) + deltay2 * (u(i - 1, j) + u(i + 1, j));
                    u(i, j) = u(i, j) + deltax2 * deltay2 * fn(i, j);
                    u(i, j) = u(i, j) / h;
                elseif i == N
                    % RIGHT Neumann border
                    u(i, j) = deltax2 * (u(i, j - 1) + u(i, j + 1));
                    u(i, j) = u(i, j) + deltay2 * (u(i - 1, j) + u(i + 1, j));
                    u(i, j) = u(i, j) + deltax2 * deltay2 * fn(i, j);
                    u(i, j) = u(i, j) / h;
                elseif j == 1
                    % BOTTOM Neumann border
                    u(i, 1) = deltax2 * (u(i, j - 1) + u(i, 2));
                    u(i, 1) = u(i, j) + deltay2 * (u(i - 1, 1) + u(i + 1, 1));
                    u(i, 1) = u(i, j) + deltax2 * deltay2 * fn(i, 1);
                    u(i, 1) = u(i, 1) / h;
                elseif i == 1
                    % LEFT Neumann border
                    u(1, j) = deltax2 * (u(1, j - 1) + u(1, j + 1));
                    u(1, j) = u(1, j) + deltay2 * (2 * u(2, j) + 2 * deltax * gL(1, j));
                    u(1, j) = u(1, j) + deltax2 * deltay2 * fn(1, j);
                    u(1, j) = u(1, j) / h;
                else
                    % MIDDLE
                    u(i, j) = deltax2 * (u(i, j - 1) + u(i, j + 1));
                    u(i, j) = u(i, j) + deltay2 * (u(i - 1, j) + u(i + 1, j));
                    u(i, j) = u(i, j) + deltax2 * deltay2 * fn(i, j);
                    u(i, j) = u(i, j) / h;
                end
            end
        end

        epsilon = norm(u - u_old);
        u_old = u;
        it = it + 1;
    end