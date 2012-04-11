function u = SolvePoisson(f, area, border_func, border_type, N, M)
    % Simple solver for equations of the type:
    %   | -(u_{xx} + u_{yy}) = f
    %   | u = u_0                       (Dirichlet boundary condition)
    %   | u_n = g                       (Neumann boundary condition)
    % known as Poisson equations (for f = 0 we have Laplace equations).
    %
    % Notation:
    %   u_xx - second derivative on x
    %   u_n  - derivative with respect to the normal vector
    %
    % Arguments:
    %   f               given funtion as in the formula.
    %   area            rectangular area [a, b]x[c, d].
    %   border_func     4 functions for each border.
    %   border_type     type of border condition (0 for Dirichlet and 1 for Neumann).
    %   N               number of discretizations on the x axis
    %   M               number of discretizations on the y axis
    %
    % Returns:
    %   u               matrix with values approximated at (x_i, y_j)
    %
    % Usage:
    %   u = SolvePoisson(f, area, border_func, border_type, N, M);
    %
    % Notes:
    %   http://web.math.umt.edu/bardsley/courses/412_18/MatlabCode/Poisson2Db.m
    %   www.public.iastate.edu/~akmitra/aero361/design_web/Laplace.pdf
    %   www.fstm.ac.ma/labomac/Taik-cours1_AN3.pdf
    %   http://dissertations.ub.rug.nl/faculties/science/1971/h.j.van.linde/?pLanguage=en&pFullItemRecord=ON
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

    [g1, g2, g3, g4] = border_func;

    if nargin < 6
        error('Not enough arguments. Use help SolvePoisson.');
    end

    % loading documentation...