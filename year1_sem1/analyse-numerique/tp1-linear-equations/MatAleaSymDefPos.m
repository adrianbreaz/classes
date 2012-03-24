function [A] = MatAleaSymDefPos(n, a, b)
    % Description:
    %   Generate a random nxn symmetric positive-defined matrix using the Cholesky
    %   method A = L * L'.
    % Arguments:
    %   n       (uint)           - matrix dimension.
    %   [a, b]  (double, double) - interval for values of triagonal matrix (optional).
    % Usage:
    %   A = MatAleaSymDefPos(n[, a, b])
    %
    % Warning:
    %  The resulting matrix does not have values in the interval [a, b]. A rough
    %  interval for the resulting matrix would be [n * a^2, n * b^2].
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
    A = A * A';
