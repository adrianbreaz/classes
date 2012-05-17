clear all;
close all;
format short g;

% number of discretizations
N = 50;      % for x
M = 50;      % for y

% area [a, b]x[c, d]
a = [-2 2 -2 2];

% using the function
u = @(x, y) sin(x .* y);

% we can construct the system
%   | -(u_{xx} + u_{yy}) + u = f    (1)
%   | u = u_0                       (Dirichlet boundary condition)
%   | u_n = g                       (Neumann boundary condition)
% and deduce the following function:
f = @(x, y) -(-y.^2 .* sin(x .* y) - x.^2 .* sin(x .* y)) + sin(x .* y);

% DIRICHLET Only (functions are u = g)
%  gT = @(z) sin(z * a(4));        % top boundary
%  gR = @(z) sin(z * a(2));        % right boundary
%  gB = @(z) sin(z * a(3));        % bottom boundary
%  gL = @(z) sin(z * a(1));        % left boundary
%  bt = [0 0 0 0];                 % type of boundary (0 - D, 1 - vN)

% NEUMANN Only (the functions are u_x = g or u_y = g)
%  gT = @(z) z .* cos(z * a(4));        % top boundary
%  gR = @(z) z .* cos(z * a(2));        % right boundary
%  gB = @(z) z .* cos(z * a(3));        % bottom boundary
%  gL = @(z) z .* cos(z * a(1));        % left boundary
%  bt = [1 1 1 1];                      % type of boundary (0 - D, 1 - vN)

% Mixed
gT = @(z) z .* cos(z * a(4));       % top boundary
gR = @(z) sin(z * a(2));            % right boundary
gB = @(z) z .* cos(z * a(3));       % bottom boundary
gL = @(z) sin(z * a(1));            % left boundary
bt = [1 0 1 0];                     % type of boundary (0 - D, 1 - vN)

u_approx = SolveEq(f, a, gT, gR, gB, gL, bt, N, M);

% construct the intervals
dx = (a(2) - a(1)) / N;
dy = (a(4) - a(3)) / M;
x1 = a(1):dx:a(2) - dx;
y1 = a(3):dy:a(4) - dy;

% compute the exact function
[X, Y] = meshgrid(x1, y1);
U = u(X, Y);

% pretty pictures
subplot(1, 2, 1);
mesh(X, Y, U);
shading faceted;
title('Exact Solution');

subplot(1, 2, 2);
mesh(X, Y, u_approx);
shading faceted;
title('Approximation');

fprintf('max_error = %g\n', max(max(abs(U - u_approx))));
