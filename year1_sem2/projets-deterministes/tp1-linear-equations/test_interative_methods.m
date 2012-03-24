clear all;
close all;
% Test script for the Jacobi, Gauss-Seidel and S.O.R methods. Plots for convergence
% and order of each method.
%
% % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

% data
n = 15;         % number of rows/columns
a = 2;          % an interval [a, b]
b = 5;

% a nice positive-definite tridiagonal matrix with a dominant diagonal. should work
% even in the trickiest of cases.
A = MatAleaTriSymDefPos(n, a, b);

% construct an easy solution for our system
x = rand(n, 1);
b = A*x;

% compute the omega for S.O.R. we know the exact formula for a tridiagonal matrix.
%       \omega_opt = \frac{2}{1 + \sqrt{1 - \rho^2(J)}}
% where J is the Jacobi matrix.
[D, E, F] = MatSplit(A);
eigs_jacobi = max(abs(eig(D^(-1) * (E + F))));
omega = 2 / (1 + sqrt(1 - eigs_jacobi ^ 2));

% get the results for all the tree methods
[x0, it0, err0] = Jacobi(A, b);
[x1, it1, err1] = GaussSeidel(A, b);
[x2, it2, err2] = Relaxation(A, b, b, omega);
it = min([it0, it1, it2]);      % no reason to draw further than the minimum

% compute order
% tested regress in octave. it should behave the same in matlab as far as the internet
% tells me. the difference to robustfit seems to be that robustfit handles stray points
% a lot better in it's calculations, while regress just does a normal linear regrassion.
orderj = regress(log2(err0(1:it - 1))', log2(err0(2:it))');
orderj = sprintf('order jac: %f', orderj);

ordergs = regress(log2(err1(1:it - 1))', log2(err1(2:it))');
ordergs = sprintf('order gs: %f', ordergs);

orderr = regress(log2(err2(1:it - 1))', log2(err2(2:it))');
orderr = sprintf('order sor: %f', orderr);

% pretty pictures
% plot the error with respect to the number of iterations for each method.
figure(1);
subplot(1, 2, 1);
hold on;
plot([1:it], err0(1:it));               % jacobi
plot([1:it], err1(1:it), 'r');          % gauss-seidel
plot([1:it], err2(1:it), 'g');          % s.o.r.
legend('jacobi', 'gs', 'sor');
hold off;

% find the order of each method by making a logarithmic plot of the error.
subplot(1, 2, 2);
hold on;
plot(log2(err0(1:it - 1)), log2(err0(2:it)));             % jacobi
plot(log2(err1(1:it - 1)), log2(err1(2:it)), 'r');        % gauss-seidel
plot(log2(err2(1:it - 1)), log2(err2(2:it)), 'g');        % s.o.r.
legend(orderj, ordergs, orderr);
hold off;
