clear all;
close all;
% Test script for the 3/8 Simpson rule (could choose any quadrature rule, but this
% one is expected to give the best results). This script computes:
%       - the integral of exp(-x^2) between [0, 1]
%       - the integral of exp(-x^2) between [0, \infty)
%       - the integral of 1/(1 + x^2) between [-\infty, \infty]
%       - 1/x^{\gamma} for \gamma < 1
%
% Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

% data
a = 0;                  % an interval [a, b]
b = 100;
c = 1000;              % c and -c is out \infty and -\infty
n = 10;

f = @(x) exp(-x.^2);

% function exp(-x^2) between [0, 1]
sol1 = quad(f, 0, 1);
r1 = Simpson38(f, 0, 1, n * 10);
fprintf('integral of e^(-x^2) between [0, 1]\n');
fprintf('solution: %e, Simpson: %e\n\n', sol1, r1);

% function exp(-x^2) between [0, \infty): split in two intervals [0, b] and [b, c]
% to vary the number of discretizations. if x > 50 exp(-x^2) becomes really small.
sol2 = quad(f, 0, c);
r2 = Simpson38(f, a, b, n * 10) + Simpson38(f, b, c, n);
fprintf('integral of e^(-x^2) between [0, infty]\n');
fprintf('solution: %e, Simpson: %e\n\n', sol2, r2);

% function 1/(1 + x^2) between [-\infty, \infty]: split in three intervals because
% the function gets very close to 0 in [-\infty, -b] and [b, \infty].
g = @(x) 1 ./ (1 + x.^2);
sol3 = quad(g, -c, c);
r3 = Simpson38(g, -c, -b, n) + Simpson38(g, -b, b, n * 10) + Simpson38(g, b, c, n);
fprintf('integral of 1/(1 + x^2) between [-infty, infty]\n');
fprintf('solution: %e, Simpson: %e\n\n', sol3, r3);

% 1/x^{\gamma} between [0, 1] with \gamma < 1
fprintf('integral of 1/x^gamma between [0, 1]\n');
gamma = [0:0.1:0.9 2 3];
for g=gamma
    h = @(x) 1 ./ x.^g;
    sol = quad(h, 0.001, 1);
    result = Simpson38(h, 0.001, 1, n * 100);

    % for some reason quad returns negative numbers instead of infinity
    % and Simpson38 just returns really big numbers that might as well count as
    % infinity, so for the sake of a nice output we're helping them out.
    % NOTE: the negative seems to only be in octave.
    if sol < 0 || sol > 1e+3
        sol = Inf;
    end
    if result > 1e+3
        result = Inf;
    end
    fprintf('gamma = %f\nsolution: %e, Simpson: %e\n', g, sol, result);
end