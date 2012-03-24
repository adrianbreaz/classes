clear all;
close all;
%
% Test the Lagrange function on a given function (known to not produce good results).
%
% Copyleft Alexandru Fikl 2011 (c)

% Data
n = 11;
m = 300;

% function
a = -1;
b = 1;
alpha = -1;
beta = 1;
f = @(x) 1 ./ (1 + 25 * x.^2);

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
axis([alpha beta -0.2 1.2])
hold('off');
