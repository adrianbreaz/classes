clear all;
close all;
format short g;

% number of discretizations
N = 5;      % for x
M = 5;      % for y

% area [a, b]x[c, d]
a = [-1 1 -1 1];

% exact solution
u = @(x, y) x;

% given the system
%   | (u_{xx} + u_{yy}) + u = f    (1)
%   | u = u_0                       (Dirichlet boundary condition)
%   | u_n = g                       (Neumann boundary condition)
% we have the following data:
f = @(x, y) x;
gT = @(z) z;        % top boundary
gR = @(z) area(4) * ones(length(z), 1);        % right boundary
gB = @(z) z;        % bottom boundary
gL = @(z) area(3) * ones(length(z), 1);        % left boundary
bt = [0 0 0 0];                 % type of boundary (0 - D, 1 - vN)

u_approx = SolveEq(f, a, gT, gR, gB, gL, bt, N, M);

dx = (area(2) - area(1)) / N;
dy = (area(4) - area(3)) / M;
x1 = area(1):dx:area(2) - dx;
y1 = area(3):dy:area(4) - dy;

[X, Y] = meshgrid(x1, y1);
U = u(X, Y);
size(X)
size(Y)
size(u_approx)
size(U)

figure(1)
shading flat;
mesh(X, Y, U);
figure(2)
mesh(X, Y, u_approx);
