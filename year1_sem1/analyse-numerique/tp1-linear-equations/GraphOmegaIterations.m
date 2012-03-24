clear all;
close all;
%
% Represent the number of iterations of the S.O.R. method in relation to the value
% of omega using a symmetric positive definite matrix.
%
% Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2011

% set defaults
% bigger values should work. but my computer started dying at n = 20.
n = 10;
a = 1;
b = 7;
tol = 10e-3;
maxIt = 500;
omega_array = linspace(0.001, 1.999, 300);

% test values
A = MatAleaSymDefPos(n, a, b);
x = ones(n, 1);
b = A * x;
x0 = b;
its = 0 * omega_array;

% compute the number of iterations for omega
for i = 1:length(omega_array)
    [x0, it] = RSLRelaxationVec(A, b, x0, omega_array(i), tol, maxIt);
    its(i) = it;
end

plot(omega_array, its);
