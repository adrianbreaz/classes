clear all;
close all;
%
% Test the Lagrange function on a given function (known to produce good results).
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
X_y = 0 * X_x;
Y = f(X);

% construct stuff to draw
for i = 1:m
    X_y(i) = Lagrange(X, Y, X_x(i));
end

% draw!
hold('on');
plot(X_x, X_y);
plot(X, Y, '*');
plot(X_x, f(X_x), 'r');
axis([alpha beta -1.2 1.2])
hold('off');
