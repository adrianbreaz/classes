function [I] = montecarlo(f, rejected, randg, domain, n)
    % Compute the integral of a given function using the Monte Carlo method.
    %
    % Arguments:
    %   - f           (function): function to integrate.
    %   - rejected    (function): function that describes the integration domain.
    %   - randg       (function): generating function for points in the domain.
    %   - domain      (R^4): the domain of integration
    %   - n           (int): number of points
    %
    % Returns:
    %   - I           (double): approximated value of the integral.
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

    if nargin < 5
        help(mfilename);
        return;
    end

    [X, Y] = acceptreject(rejected, randg, domain, n);
    I = mean(f(X, Y));