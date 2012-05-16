clear all;
close all;
format short g;

% number of discretizations
N = 60;      % for x
M = 60;      % for y

% area [a, b]x[c, d]
a = [-1 1 -1 1];

% exact solution
u = @(x, y) x.^2 + y.^2;

% given the system
%   | -(u_{xx} + u_{yy}) + u = f    (1)
%   | u = u_0                       (Dirichlet boundary condition)
%   | u_n = g                       (Neumann boundary condition)
% we have the following data:
f = @(x, y) -4 + x.^2 + y.^2;
gT = @(z) z.^2 + a(4).^2;        % top boundary
gR = @(z) z.^2 + a(2).^2;        % right boundary
gB = @(z) z.^2 + a(3).^2;        % bottom boundary
gL = @(z) z.^2 + a(1).^2;        % left boundary
bt = [0 0 0 0];                  % type of boundary (0 - D, 1 - vN)

u_approx = SolveEq(f, a, gT, gR, gB, gL, bt, N, M);

dx = (a(2) - a(1)) / N;
dy = (a(4) - a(3)) / M;
x1 = a(1):dx:a(2) - dx;
y1 = a(3):dy:a(4) - dy;

[X, Y] = meshgrid(x1, y1);
U = u(X, Y);

figure(1)
mesh(X, Y, U);

figure(2)
mesh(X, Y, u_approx);
max(max(abs(U - u_approx)))
