clear all;
close all;

T = 10;                                     % 0s
N = 100;
g = 9.81;                                   % m/s^2
L = 1;                                      % 3m
alpha = 
theta0 = [pi/2 0]';

f = @(t, theta) [theta(2) (-g / L * sin(theta(1)) - alpha * theta(2))]';
    
theta = RungeKutta4(f, theta0, N, T);

plot(theta(1, :), theta(2, :));