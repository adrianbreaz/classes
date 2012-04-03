clear all;
close all;
% A small script that solves the pendulum problem (also an ODE).
%
% Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

% initial data
T = 50;                                 % duration for which we're simulating
N = 10000;                                % number of discretizations
g = 9.81;                               % acceleration of gravity
L = 0.5;                                  % length of the rod
alpha = 0.1                             % friction coefficient (0 for no friction)

theta0 = [pi/2 0]
f = @(t, theta) [theta(2) (-g / L * sin(theta(1)) - alpha * theta(2))]';
theta = RungeKutta4(f, theta0, N, T);
plot(theta(1, :), theta(2, :));
xlabel('angle');
ylabel('speed');

%  for angle = 0:0.2:2*pi
%      theta0 = [angle 0]';                   % initial value of angle and speed
%
%      % our nice function for the ODE:
%      %       \theta'(t) = f(t, \theta)
%      %       \theta_0 = (theta_0^1, theta_0^2)
%      % we're int R^2
%      f = @(t, theta) [theta(2) (-g / L * sin(theta(1)) - alpha * theta(2))]';
%
%      % find the approximations
%      theta = RungeKutta4(f, theta0, N, T);
%
%      % plot the phase (angle in relation to speed)
%      plot(theta(1, :), theta(2, :));
%      legend(sprintf('angle %.2f', angle));
%      xlabel('angle');
%      ylabel('speed');
%      pause;
%  end