clear all;
close all;

% Project 4.
%
% Students:
%   Alexandru Fikl
%   Adrian Breaz

disp('Exercise number format:');
disp(' - first digit: exercise number');
disp(' - second digit: subproblem number (none if it does not have one)');
exercise = input('Give exercise number: ');

switch exercise
    case 11
        disp('Not Implemented.');
    case 12
        disp('Not Implemented.');
    case 13
        disp('Not Implemented.');
    case 14
        disp('Not Implemented.');
    case 15
        disp('Not Implemented.');
    case 2
        disp('Not Implemented.');
    case 4
        disp('Not Implemented.');
    case 5
        disp('Not Implemented.');
    case 6
        disp('Not Implemented.');
    case 7
        disp('Not Implemented.');
    case 8
        disp('Not Implemented.');
    otherwise
        fprintf('Wrong exercise number.\n');
        fprintf('Available exercises are:\n');
        disp([11 12 13 14 15 2 4 5 6 7 8]);
end
