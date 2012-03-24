function [A] = MatAleaSym(n, a, b)
    % Description:
    %   Generate a random nxn symmetric matrix with values in [a, b] (default [0, 1])
    % Arguments:
    %   n       (uint)                  - matrix dimension.
    %   [a, b]  (double, double)        - interval for values (optional).
    % Usage:
    %   A = MatAleaSym(n[, a, b])
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2011

    % check assertions
    if nargin == 0
        error('not enough input arguments');
    end

    % set defaults
    if nargin < 3
        a = 0;
        b = 1;
    elseif b < a
        error('wrong interval (b < a)');
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                   ALGORITHM
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    A = MatAleaTriInf(n, a, b);
    A = A + A' - diag(diag(A));
