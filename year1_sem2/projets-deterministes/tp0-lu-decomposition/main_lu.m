% Test script for the LU decomposition.
%
% Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012
%%%

% data
n = 5;                                  % matrix size

% inits
A = rand(n, n);                         % tested matrix
b = A * ones(n, 1);                     % trivial solution x = (1, 1, 1, ...)

% test
disp('our solving function');
x_lu = solveSystem(A, b)                % solve using our function
disp('using matlab A \ b');
x_mat = A \ b                           % solve using matlab
norme = norm(A * x_lu - b)              % compute how close our solution really is

% give it some room. no one can be perfect.
if norme < 10 * eps
    disp('really good solution!');
end