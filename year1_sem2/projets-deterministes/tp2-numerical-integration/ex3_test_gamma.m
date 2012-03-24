clear all;
close all;
% Test script for the computation and representation of the \Gamma function.
%
% Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

% interval used for the numerical integration [0, a] where as is counted as 'infinity'
% because larger number would give bigger errors in the computation of the factorial.
a = 100;
n = 50;                 % number of discretizations

% compute the gamma function for m in {0, .., 10}
for m = 0:10
    gamma = @(x) x .^(m - 1) .* exp(-x);
    r = round(Simpson38(gamma, 0, a, n));
    fprintf('Gamma(%d) = %d = (%d)!\n', m, r, m - 1);
end
fprintf('etc..\n');

% to plot the Gamma function, especially in the negative half-plane we used a different
% function based on the lanczos approximation as defined in:
%       http://en.wikipedia.org/wiki/Lanczos_approximation
marr = [-5:0.01:5];
gamma_y = gammala(marr);

hold on;
grid('on');
plot(marr, gamma_y, 'r', 'LineWidth', 2);    % plot gamma
plot([-5 5], [0 0]);                            % plot the x axis
axis([-5 5 -10 10]);                            % re-center the graphic
hold off;