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

    % function shortcuts
    gT = @(x, y) border_func(x, y)(1);
    gR = @(x, y) border_func(x, y)(2);
    gB = @(x, y) border_func(x, y)(3);
    gL = @(x, y) border_func(x, y)(4);
    
    A = zeros(N * M, N * M);
    
 
    