close all;
clear all;
% Solve a Stiff Problem using the implemented methods. Notice shortcomings:
%       - explicit methods explode for small h
%
% Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

% init data
T = 0.5;                        % time interval [0, T]
N = [10 100 1000 10000];        % number of discretizations
y0 = 1;                         % initial value
errf = 0 .* N;                  % forward euler method error
errb = 0 .* N;                  % backward euler method error
errrk = 0 .* N;                 % runge kutta 4 error
errcn = 0 .* N;                 % crank-nicolson error
h = 0 .* N;                     % step for each N(i)
lambda = 600;

% our EDO is:
%       | y'(t) = - \lambda * y(t) + 1 - \lambda * t)             (1)
%       | y(0) = 1
% thus we have the following functions:
f = @(t, y) -lambda * y + 1 + lambda * t;       % f(t, y(t))
df = @(t, y) -lambda;                           % f'(t, y(t))
y = @(t) exp(-lambda * t) + t;                  % real solution for (1)

% compute the error for each number of discretizations to see how the error
% gets smaller when we decrease the step.
for i = 1:length(N)
    % compute current step
    h(i) = T / N(i);

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

disp('error forward euler');
disp(errf);

disp('error backward euler');
disp(errb);

disp('error runge-kutta 4');
disp(errrk);

disp('error crank-nicolson');
disp(errcn);