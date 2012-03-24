clear all;
close all;
% Represent the number of iterations necessary for the S.O.R method to converge
% in correlation with omega, using a tridiagonal matrix. Also, shows the number of
% iterations necessary for the Jacobi and Gauss-Seidel methods.
%
% Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2011


% set defaults
% bigger values should work. but my computer started dying at n = 20.
n = 5;
a = 1;
b = 7;
tol = 10e-3;
maxIt = 1000;
omega_array = linspace(0.001, 1.999, 300);

% test values
A = MatAleaTriSymDefPos(n, a, b);
x = ones(n, 1);
b = A * x;
x0 = b;
iterations = 0 * omega_array;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%          Computations
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[x, it_jacobi] = RSLJacobi(A, b, x0, tol, maxIt);
[x, it_gauss] = RSLGaussSeidelVec(A, b, x0, tol, maxIt);

for i = 1:length(omega_array)
    [x, it] = RSLRelaxationVec(A, b, x0, omega_array(i), tol, maxIt);
    iterations(i) = it;
end

% compute omega optimal and minimum number of iterations;
[it_optimal, i] = min(iterations);
omega_optimal = omega_array(i);

% strings. wee!
s = sprintf('# iterations: Jacobi(%d) Gauss-Seidel(%d)', it_jacobi, it_gauss);
omega_string = sprintf('%f', omega_optimal);
it_string = sprintf('%d', it_optimal);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Drawing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold('on');
title(s);

% plot (omega, nr_of_iterations)
xlabel('number of iterations');
ylabel('omega');
plot(omega_array, iterations, 'LineWidth', 1.5);

% plot lines to point (omega_optimal, it_optimal)
plot([omega_optimal, omega_optimal], [0, it_optimal], 'r--');
plot([0, omega_optimal], [it_optimal, it_optimal], 'r--');
text(-0.2, it_optimal, it_string, 'Color', 'r');
text(omega_optimal - 0.02, -0.03, omega_string, 'Color', 'r');

hold('off');
