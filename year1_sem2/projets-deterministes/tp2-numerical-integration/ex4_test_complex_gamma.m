clear all;
close all;
% Test script for the computation and representation of the \Gamma function in the
% complex plane.
%
% Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

% plane in which to compute the values
x = [-5:0.01:5];
y = [-5:0.01:5];

% create a nice grid with all the values (X = Y')
[X, Y] = meshgrid(x,y);

% make all the values complex
z = X + i*Y;

% compute the gamma function for the matrix z
f = gammala(z);

% limit the values to 10 so we don't go overboard.
p = find(abs(f) > 10);
f(p) = 10;

% make a pretty drawing
shading flat;
mesh(x, y, abs(f));
view([-40 30]);