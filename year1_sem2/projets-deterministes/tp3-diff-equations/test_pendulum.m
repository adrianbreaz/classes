clear all;
close all;
% A small script that solves the pendulum problem (also an ODE).
%
% Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

% initial data
T = 30;                                   % duration for which we're simulating
N = 500;                                % number of discretizations
g = 9.81;                                 % acceleration of gravity
L = 1;                                  % length of the rod
alpha = 0.0                               % friction coefficient (0 for no friction)

%  theta0 = [pi + 0.01 0.2]
%  f = @(t, theta) [theta(2) (-g / L * sin(theta(1)) - alpha * theta(2))]';
%  theta = RungeKutta4(f, theta0, N, T);
%  plot(theta(1, :), theta(2, :));
%  xlabel('angle');
%  ylabel('speed');

for angle = pi - 0.1:0.01:pi + 0.1
    theta0 = [angle 0.2];                   % initial value of angle and speed

    % our nice function for the ODE:
    %       \theta'(t) = f(t, \theta)
    %       \theta_0 = (theta_0^1, theta_0^2)
    % we're int R^2
    f = @(t, theta) [theta(2) (-g / L * sin(theta(1)) - alpha * theta(2))]';

    % find the approximations
    theta = RungeKutta4(f, theta0, N, T);

    % plot the phase (angle in relation to speed)
    plot(theta(1, :), theta(2, :));
    legend(sprintf('angle %.2f', angle)); % 3.08 - 3.20
    xlabel('angle');
    ylabel('speed');
    pause(2);
end