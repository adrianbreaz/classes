clear all;
close all;
format short g;
% This is a small test script for the SolveEq function. This fonction gives
% numberical solutions for equations of the type:
%   | -(u_{xx} + u_{yy}) + u = f    (1)
%   | u = u_0                       (Dirichlet boundary condition)
%   | u_n = g                       (Neumann boundary condition)
%
% Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

% Number of discretizations
N = 50;      % for x
M = 50;      % for y

% Domain [a, b]x[c, d]
a = [-2 2 -2 2];

% Construct the intervals and discretizations
dx = (a(2) - a(1)) / N;
dy = (a(4) - a(3)) / M;
x1 = a(1):dx:a(2) - dx;
y1 = a(3):dy:a(4) - dy;
[X, Y] = meshgrid(x1, y1);

% Function used for testing
u = @(x, y) sin(x .* y);

% We can construct the system using u as in (1) and deduce the following function:
f = @(x, y) -(-y.^2 .* sin(x .* y) - x.^2 .* sin(x .* y)) + sin(x .* y);

% DIRICHLET Only (functions are u = g)
%  gT = @(z) sin(z * a(4));        % top boundary
%  gR = @(z) sin(z * a(2));        % right boundary
%  gB = @(z) sin(z * a(3));        % bottom boundary
%  gL = @(z) sin(z * a(1));        % left boundary
%  bt = [0 0 0 0];                 % type of boundary (0 - D, 1 - vN), order: T R B L

% NEUMANN Only (the functions are u_n = g)
%  gT = @(z) z .* cos(z * a(4));
%  gR = @(z) z .* cos(z * a(2));
%  gB = @(z) z .* cos(z * a(3));
%  gL = @(z) z .* cos(z * a(1));
%  bt = [1 1 1 1];

% Mixed
gT = @(z) z .* cos(z * a(4));
gR = @(z) sin(z * a(2));
gB = @(z) z .* cos(z * a(3));
gL = @(z) sin(z * a(1));
bt = [1 0 1 0];

% Do all the heavy lifting
u_approx = SolveEq(f, a, gT, gR, gB, gL, bt, N, M);
u_exact = u(X, Y);

% Pretty pictures
subplot(1, 2, 1);
mesh(X, Y, u_exact);
shading faceted;
title('Exact Solution');

subplot(1, 2, 2);
mesh(X, Y, u_approx);
shading faceted;
title('Approximation');

fprintf('max_error = %g\n', max(max(abs(u_exact - u_approx))));
