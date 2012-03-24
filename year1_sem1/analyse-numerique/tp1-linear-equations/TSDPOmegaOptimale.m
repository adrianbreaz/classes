clear all;
close all;
% Represent the function 'omega --> p(L_omega)' (takes omega to the spectral
% radius of the S.O.R. matrix).
%
% The S.O.R matrix is defined by:
%       L_{omega} = (\frac{1}{omega} * D - E)^{-1} * (\frac{1 - omega}{omega} * D + F).
%
% Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2011

% set defaults
% bigger values should work. but my computer started dying at n = 20.
n = 15;
a = 1;
b = 7;
omega_array = linspace(0.001, 1.999, 300);

% test values
A = MatAleaTriSymDefPos(n, a, b);
[D, E, F] = MatSplit(A);
x = ones(n, 1);
b = A * x;
x0 = b;
sradius = 0 * omega_array;

% compute omega_optimal with the formula:
%       w_o = \frac{1}{1 + \sqrt{1 - \rho^2(J)}}
% where J is the Jacobi method matrix.
eigs_jacobi = max(abs(eig(D^(-1) *  (E + F))));
omega_optimal = 2 / (1 + sqrt(1 - eigs_jacobi ^ 2))

rho_optimal = (1 / omega_optimal * D - E)^(-1) * ((1 - omega_optimal) / omega_optimal * D + F);
rho_optimal = max(abs(eig(rho_optimal)))

% compute the number of iterations for omega
omega_computed = [1 ./ omega_array; (1 - omega_array) ./ omega_array];

for i = 1:length(omega_computed)
    lw = ( omega_computed(1, i) * D - E)^(-1) * (omega_computed(2, i) * D + F);
    sradius(i) = max(abs(eig(lw)));
end

hold('on');
s = sprintf('Omega Optimale: w_opt = %f', omega_optimal);
title(s);

% plot required function
plot(omega_array, sradius, 'LineWidth', 1.5);

% plot lines to point (omega_optimal, rho_optimal)
plot([omega_optimal, omega_optimal], [0, rho_optimal], 'r--');
plot([0, omega_optimal], [rho_optimal, rho_optimal], 'r--');
text(-0.2, rho_optimal, 'rho_opt', 'Color', 'r');
text(omega_optimal - 0.02, -0.03, 'w_opt', 'Color', 'r');

% Test Lemme 4.1 Chapter 4: rho(L_omega) >= |omega - 1|
% equality when omega == omega_optimal.
plot(omega_array, omega_array - 1, 'b--');

hold('off');
axis([0, 2.05, 0, 1.05]);
