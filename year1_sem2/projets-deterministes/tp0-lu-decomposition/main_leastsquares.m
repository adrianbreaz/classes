clear all;
close all;

% Test script for Least Squares method. Testing approximations by a line, a parabola
% and a cubic spline.
%
% Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012
%%%

% data
n = 45;                         % number of points
X = -5 + 10 * rand(n, 1);       % x coord of the points

% approximate using a line
figure(1);
% y coord of the points, made as a small deviation to x
Y = rand(n, 1) .* X + 2 * rand() - 1;
testLeastSquares(X, Y, 0);

% approximate using a parabola
figure(2);
Y = rand(n, 1) .* X.^2 + rand(n, 1) .* X + 2 * rand() - 1;
testLeastSquares(X, Y, 1);

% approximate using a cubic spline
figure(3)
Y = rand(n, 1) .* X.^3 + rand(n, 1) .* X.^2 + rand(n, 1) .* X + 2 * rand() - 1;
testLeastSquares(X, Y, 2);

