clear all;
close all;
format short g;

% number of discretizations
N = 30;      % for x
M = 30;      % for y

% area [a, b]x[c, d]
a = [-2 2 -2 2];

% exact solution
u = @(x, y) sin(x .* y);

% given the system
%   | -(u_{xx} + u_{yy}) + u = f    (1)
%   | u = u_0                       (Dirichlet boundary condition)
%   | u_n = g                       (Neumann boundary condition)
% we have the following data:
f = @(x, y) -(-y.^2 .* sin(x .* y) - x.^2 .* sin(x .* y)) + sin(x .* y);

% DIRICHLET Only
%  gT = @(z) sin(z * a(4));        % top boundary
%  gR = @(z) sin(z * a(2));        % right boundary
%  gB = @(z) sin(z * a(3));        % bottom boundary
%  gL = @(z) sin(z * a(1));        % left boundary
%  bt = [0 0 0 0];                 % type of boundary (0 - D, 1 - vN)

% NEUMANN Only
gT = @(z) z .* cos(z * a(4));        % top boundary
gR = @(z) z .* cos(z * a(2));        % right boundary
gB = @(z) z .* cos(z * a(3));        % bottom boundary
gL = @(z) z .* cos(z * a(1));        % left boundary
bt = [1 1 1 1];                      % type of boundary (0 - D, 1 - vN)

u_approx = SolveEq(f, a, gT, gR, gB, gL, bt, N, M);

dx = (a(2) - a(1)) / N;
dy = (a(4) - a(3)) / M;
x1 = a(1):dx:a(2) - dx;
y1 = a(3):dy:a(4) - dy;

[X, Y] = meshgrid(x1, y1);
U = u(X, Y);

figure(1)
mesh(X, Y, U);
shading faceted;

figure(2)
mesh(X, Y, u_approx);
shading faceted;

max(max(abs(U - u_approx)))
