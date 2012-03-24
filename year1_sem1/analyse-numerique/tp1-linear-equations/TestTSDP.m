%
% Test Suite for all iterative methods using a symmetric tridiagonal positive definite matrix.
%
% Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2011

% Parameters
n = 3;
a = 1;
b = 7;

% test values
A = MatAleaTriSymDefPos(n, a, b);
x = ones(n, 1);
b = A * x;
x0 = b;
%  A = [2, 1; 5, 7];
%  b = [11; 13];
%  x = [7.111; -3.222];
%  x0 = [1; 1];

UnitTest(A, b, x, x0);