function [A] = MatAlea(n, m, a, b)
    % Description:
    %   Generate a random nxm matrix with values in [a, b] (default [0, 1])
    % Arguments:
    %   n       (uint)                  - number of rows.
    %   m       (uint)                  - number of columns. (optional)
    %   [a, b]  (double, double)        - interval for values (optional).
    % Usage:
    %   A = MatAlea(n[, m[, a, b]])
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2011

    % check assertions
    if nargin == 0
        error('not enough input arguments');
    end

    % set defaults
    if nargin == 1
        m = n;
    end

    if nargin < 4
        a = 0;
        b = 1;
    elseif b < a
        error('wrong interval (b < a)');
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                   ALGORITHM
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    A = a + (b - a) * rand(n, m);
