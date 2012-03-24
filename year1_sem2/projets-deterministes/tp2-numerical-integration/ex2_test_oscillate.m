clear all
close all
% Test script for the Rectangle, Middle Point, Trapezoid, 1/3 Simpson and 3/8
% Simpson quadrature rules based on the Newton-Coates Formula. This script tests
% the accuracy for highly oscillating functions.
%
% Expected outcome:
%       - with a small number of points in the interval the quadrature rules
% with give very bad results, as the number of points increases the result will
% start to converge to the actual value of the integral.
%
% Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

% data
a = 0;                  % interval [a, b]
b = 5 * pi/2;
n = [10 50 300];        % array with number of discretizations

% a highly oscillating function
f = @(x) 7 * cos(x * 23);
fplot(f, [a, b]);

for i=n
    sol = quad(f, a, b);
    sol_rec = Rectangle(f, a, b, i);
    sol_mp = MiddlePoint(f, a, b, i);
    sol_trap = Trapezoid(f, a, b, i);
    sol_sim1 = Simpson13(f, a, b, i);
    sol_sim2 = Simpson38(f, a, b, i);

    fprintf('%d iterations\n', i);
    fprintf('real solution: %10.5f\n', sol);
    fprintf('   rec \t\t mp \t trap \t    sim1 \t sim2\n');
    fprintf('  %.5f %10.5f %10.5f %10.5f %10.5f\n\n', sol_rec, sol_mp, sol_trap,
                                                    sol_sim1, sol_sim2);
end