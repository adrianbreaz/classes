clear all;
close all;
%
% Test the Lagrange function on a given function (known to not produce good results).
% using the points of Tchebycheff (supposed to give good results no matter the function).
%
% Copyleft Alexandru Fikl 2011 (c)

% Data
n = 11;
m = 300;

%function
a = -1;
b = 1;
alpha = -1;
beta = 1;
f = @(x) 1 ./ (1 + 25 * x.^2);

% init
X = Tchebycheff(a, b, n);
X_x = linspace(alpha + 0.0001, beta - 0.0001, m);
Y = f(X);

% construct stuff to draw
X_y = LagrangeVecOpt(X, Y, X_x);

% draw!
hold('on');
plot(X_x, X_y);
plot(X, Y, '*');
plot(X_x, f(X_x), 'r');
axis([alpha beta -0.2 1.2]);
hold('off');
