clear all;
close all;
% Test script for the Rectangle, Middle Point, Trapezoid, 1/3 Simpson and 3/8
% Simpson quadrature rules based on the Newton-Coates Formula. This script computes
% the order of convergence of each method.
%
% Expected outcome:
%       - rectangle: order 1
%       - middle point and trapezoid: order 2
%       - simpson: order 3
%
% Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

% data
a = 0;                  % interval [a, b]
b = pi/2;
f = @(x) cos(x);        % nice function with a known integral for the given integral
                        % \int_0^{pi/2} cos(x) dx = 1

% inits
na = 100:100:800;       % array with number of discretizations
h = (b - a) ./ na;      % step for each iteration

% compute errors
for i = 1:length(na)
    errRec(i) = abs(1 - Rectangle(f, a, b, na(i)));
    errMP(i) = abs(1 - MiddlePoint(f, a, b, na(i)));
    errTrap(i) = abs(1 - Trapezoid(f, a, b, na(i)));
    errSim1(i) = abs(1 - Simpson13(f, a, b, na(i)));
    errSim2(i) = abs(1 - Simpson38(f, a, b, na(i)));
end

% compute order for each rule
% Rectangle Rule
order_rec = robustfit(log(h)', log(errRec)')
order_rec = sprintf('pts rectangles: h^{%f}', order_rec);

% Middle Point Rule
order_mp = robustfit(log(h)', log(errMP)')
order_mp = sprintf('pts milieux: h^{%f}', order_mp);

% Trapezoid Rule
order_trap = robustfit(log(h)', log(errTrap)')
order_trap = sprintf('trapezes: h^{%f}', order_trap);

% 1/3 Simpson Rule
order_sim1 = robustfit(log(h)', log(errSim1)');
order_sim1 = sprintf('simpson1: h^{%f}', order_sim1);

% 3/8 Simpson Rule
order_sim2 = robustfit(log(h)', log(errSim2)');
order_sim2 = sprintf('simpson2: h^{%f}', order_sim2);

% draw
loglog(h, errRec);              % rectangle
hold on;
grid on;
loglog(h, errMP, 'r');          % middle point
loglog(h, errTrap, 'g');        % trapezoid
loglog(h, errSim1, 'k');        % 1/3 simpson
loglog(h, errSim2, 'c');        % 3/8 simpson

legend(order_rec, order_mp, order_trap, order_sim1, order_sim2, 'Location', 'SouthEast');
hold off;