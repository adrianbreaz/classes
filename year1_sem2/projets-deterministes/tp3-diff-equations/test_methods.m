close all;
clear all;
% Small test script for the Euler methods (Forward and Backward), Runge Kutta 4 and
% Crank-Nicolson to see if they work.
%
% Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

% init data
T = 5;                          % time interval [0, T]
N = [10 100 1000];              % number of discretizations


% test functions:
y0 = 0;                                                 % initial value
f = @(t, y) y - (exp(t / 2) .* sin(5 * t)) / 2 + 5 * (exp(t / 2) .* cos(5 * t));
df = @(t, y) 1;                                         % f'(t, y(t))
y = @(t) exp(t / 2) .* sin(5 * t);                      % real solution

% stiff problem:
%  y0 = 1;
%  f = @(t, y) -100 * y + 1 + 100 * t;                  % f(t, y(t))
%  df = @(t, y) -100;                                   % f'(t, y(t))
%  y = @(t) exp(-100 * t) + t;                          % real solution

% compute the error for each number of discretizations to see how the error
% gets smaller when we decrease the step.
for i = 1:length(N)
    % compute current step
    h = T / N(i);

    % compute approximations with our functions
%      ymethod = ForwardEuler(f, y0, N(i), T);
    ymethod = BackwardEuler(f, df, y0, N(i), T);
%      ymethod = RungeKutta4(f, y0, N(i), T);
%      ymethod = CrankNicolson(f, df, y0, N(i), T);

    % compute the exact solution
    yexact = y(0:h:T);

    max(abs((ymethod - yexact)))
    figure(i);
    hold on;
    plot(0:h:T, yexact, 'r');
    plot(0:h:T, ymethod, '*');
    legend('exact', 'approximation');
    hold off;
end