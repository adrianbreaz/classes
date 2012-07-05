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
    % NOTE: Widely considered as one of the most ill-conceived PRNG around.
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

    if nargin < 1
        error('Not enough arguments. See help `randu`.');
    end

    if nargin < 2
        n = 100;
    end

    % The RANDU algorithm works better with an odd seed for obvious reasons.
    if mod(x0, 2) == 0
        x0 = x0 + 1;
    end

    a = 2^16 + 2 + 1;
    c = 0;
    m = 2^31;

    x = lcg(x0, a, c, m, n);