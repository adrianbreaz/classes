clear all;
close all;

% Project 3.
%
% Students:
%   Breaz Adrian
%   Alexandru Fikl

disp('Exercise number format:');
disp(' - first digit: exercise number');
disp(' - second digit: subproblem number (none if it does not have one)');
exercise = input('Give exercise number: ');

switch exercise
    case 1
        disp('Not Implemented.');
    case 2
        disp('Not Implemented.');
    case 3
        disp('Not Implemented.');
    case 4
        disp('Not Implemented.');
    case 5
        disp('Not Implemented.');
    case 6
        disp('Not Implemented.');
    case 7
        disp('Not Implemented.');
    case 9
        disp('Not Implemented.');
    case 10
        disp('Not Implemented.');
    otherwise
        fprintf('Wrong exercise number.\n');
        fprintf('Available exercises are:\n');
        disp([1 2 3 4 5 6 7 9 10]);
end
