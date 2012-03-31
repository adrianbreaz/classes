close all;
clear all;
% Test script for the Euler methods (Forward and Backward), Runge Kutta 4 and
% Crank-Nicolson:
%       - computing the order of each variant
%       - nice plots
%
% Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

% init data
T = 1.5;                % time interval [0, T]
N = [10:20:300];        % number of discretizations
y0 = 1;                 % initial value

errf = 0 .* N;          % forward method error
errb = 0 .* N;          % backward method error
errrk = 0 .* N;         % runge kutta 4 error
errcn = 0 .* N;         % crank nicolson error

h = T ./ N;             % step for each N(i)

% our EDO is:
%       | y'(t) + 2 * y(t) = 2 - e^(-4 * t)             (1)
%       | y(0) = 1
% thus we have the following functions:
f = @(t, y) 2 - exp(-4 * t) - 2 * y;                    % f(t, y)
df = @(t, y) -2;                                        % df(t, y)/dy
y = @(t) 1 + 1/2 * exp(-4 * t) - 1/2 * exp(-2 * t);     % real solution for (1)

% compute the error for each number of discretizations to see how the error
% gets smaller when we decrease the step.
for i = 1:length(N)

    % compute approximations with our functions
    yeulerf = ForwardEuler(f, y0, N(i), T);
    yeulerb = BackwardEuler(f, df, y0, N(i), T);
    yrungek = RungeKutta4(f, y0, N(i), T);
    ycrankn = CrankNicolson(f, df, y0, N(i), T);

    % compute the exact solution
    yexact = y(0:h(i):T);

    % get the maximum error for step h_i
    errf(i) = max(abs(yeulerf - yexact));
    errb(i) = max(abs(yeulerb - yexact));
    errrk(i) = max(abs(yrungek - yexact));
    errcn(i) = max(abs(ycrankn - yexact));
end

% compute the order of the Forward Euler method
orderf = regress(log2(h)', log2(errf)');
orderf = sprintf('order %f', orderf);

% compute the order of the Backward Euler method
orderb = regress(log2(h)', log2(errb)');
orderb = sprintf('order %f', orderb);

% compute the order of the Runge Kutta 4 method
orderrk = regress(log2(h)', log2(errrk)');
orderrk = sprintf('order %f', orderrk);

% compute the order of the Crank-Nicolson method
ordercn = regress(log2(h)', log2(errcn)');
ordercn = sprintf('order %f', ordercn);

% make pretty pictures for Forward Euler
figure(1);
subplot(2, 2, 1);
loglog(h, errf);                % the step relative to the error in log scale
hold on;
loglog(h, h, 'r');
title('Forward Euler');         % a line of slope 1 as reference
legend(orderf);

% same for Backward Euler
subplot(2, 2, 2);
loglog(h, errb);
hold on;
loglog(h, h, 'r');
title('Backward Euler');
legend(orderb);

% same for Runge Kutta 4
subplot(2, 2, 3);
loglog(h, errrk);
hold on;
loglog(h, h.^4, 'r');
title('Runge Kutta 4');
legend(orderrk);

% same for Crank-Nicolson
subplot(2, 2, 4);
loglog(h, errcn);
hold on;
loglog(h, h.^2, 'r');
title('Crank Nicolson');
legend(ordercn);
