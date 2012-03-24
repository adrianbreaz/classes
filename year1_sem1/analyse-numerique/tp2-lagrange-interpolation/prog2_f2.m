clear all;
close all;
%
% Test the LagrangeVec function on a given function (known to produce good results).
%
% Copyleft Alexandru Fikl 2011 (c)

% Data
n = 11;
m = 300;

% function
a = 0;
b = pi;
alpha = 0;
beta = 4;
f = @(x) cos(x);

% init
X = linspace(a, b, n + 1);
X_x = linspace(alpha, beta, m);
Y = f(X);

% construct stuff to draw
X_y = LagrangeVec(X, Y, X_x);

% draw!
hold('on');
plot(X_x, X_y);
plot(X, Y, '*');
plot(X_x, f(X_x), 'r');
axis([alpha beta -1.2 1.2])
hold('off');
