function [x] = randu(x0, n)
    % A linear congruential generator using the RANDU algorithm.
    %
    % RANDU is a special case of an LCG with:
    %   a = 2^16 + 2 + 1
    %   c = 0
    %   m = 2^31
    %
    % Arguments:
    %   - x0 (unsigned int): the seed
    %   - n  (unsigned int): number of steps to do
    %
    % Return:
    %   - x (R^n): a vector with the first n values computed by the generator
    %
    % Usage:
    %   x = randu(x0[, n]);
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

    if nargin < 1
        error('Not enough arguments. See help `randu`.');
    end

    if nargin < 2
        n = 100;
    end

    a = 2^16 + 2 + 1;
    c = 0;
    m = 2^31;

    x = zeros(n, 1);
    x(1) = mod(a * x0 + c, m);

    for i = 1:n - 1
        x(i + 1) = mod(a * x(i) + c, m);
    end