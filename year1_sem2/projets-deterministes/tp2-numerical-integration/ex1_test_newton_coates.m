close all
clear all
% Test script for the Rectangle, Middle Point, Trapezoid, 1/3 Simpson and 3/8
% Simpson quadrature rules based on the Newton-Coates Formula. This script computes
% the integral for various monomials to test the accuracy of each method.
%
% Each method is supposed to be accurate until a certain degree:
%       - Regtangle: degree < 2
%       - middle point and trapezoid: degree < 3
%       - simpson: degree < 4
%
% Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

% data
a = 0;          % interval [a, b]
b = 1;
n = 200;         % number of discretizations

for d = 0:5
    f = @(x) x.^d;
    sol = quad(f, a, b);
    diffRec = abs(sol - Rectangle(f, a, b, n));
    diffMP = abs(sol - MiddlePoint(f, a, b, n));
    diffTrap = abs(sol - Trapezoid(f, a, b, n));
    diffSim1 = abs(sol - Simpson13(f, a, b, n));
    diffSim2 = abs(sol - Simpson38(f, a, b, n));

    fprintf('quad(x.^%d, %d, %d) = %e\n', d, a, b, sol);
    fprintf('Error: pm: %e trap: %e rec: %e\n', diffMP, diffTrap, diffRec);
    fprintf('Error: sim1: %e sim2: %e\n\n', diffSim1, diffSim2);
end
