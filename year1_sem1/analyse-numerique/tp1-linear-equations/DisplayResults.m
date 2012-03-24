function DisplayResults(testName, x, x1, it1, x2, it2)
    % Description:
    %   Nicely displays results from unit tests
    % Arguments:
    %   testName - name of the test
    %   x - actual solution.
    %   x1/x2 - solution from the iterative/vectorial method.
    %   it1/it2 - number of iterations from the iterative/vectorial method.
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2011

    if nargin < 5
        error('not enough input arguments');
    end

    s = sprintf('<=== %s ===>', testName);
    disp(s);
    disp('real solution:');
    disp(x');
    disp('=== Iterative variant ===')
    disp('Solution:');
    disp(x1');
    disp('Number of iterations:')
    disp(it1);
    disp('Error:')
    disp(norm(x - x1, Inf) / norm(x1, Inf))

    disp('=== Vectorial variant ===');
    disp('Solution:');
    disp(x2');
    disp('Number of iterations:');
    disp(it2);
    disp('Error:')
    disp(norm(x - x2, Inf) / norm(x2, Inf))