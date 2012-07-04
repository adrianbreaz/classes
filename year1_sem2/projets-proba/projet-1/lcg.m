function [x] = lcg(x0, a, c, m, n)
    % A linear congruential generator.
    %
    % A LCG uses a simple recursion formula:
    %   x_{n + 1} = (a * x_n + c) mod m
    %
    % Arguments:
    %   - x0 (unsigned int): the seed
    %   - a  (unsigned int): the multiplier (0 < a < m)
    %   - c  (unsigned int): the increment (0 <= c < m)
    %   - m  (unsigned int): the modulus
    %   - n  (unsigned int): number of steps to do
    %
    % Return:
    %   - x (R^n): a vector with the first n values computed by the generator
    %
    % Usage:
    %   x = lcg(x0, a, c, m[, n]);
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

    if nargin < 4
        error('Not enough arguments. See help `lcg`.');
    end

    if nargin < 5
        n = 100;
    end

    x = zeros(n, 1);
    x(1) = x0;
    for i = 1:n - 1
        x(i + 1) = mod(a * x(i) + c, m);
    end