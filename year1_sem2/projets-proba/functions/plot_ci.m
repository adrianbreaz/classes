function plot_ci(alpha, nval, icdf, mu)
    % Plots a nice graph with the exact mean, empiric mean and confidence interval
    % for certain values of n and alpha.
    %
    % Arguments:
    %   - alpha (double): confidence level
    %   - nval (R^n): array of values of n
    %   - icdf (function): generating function for some distribution
    %   - mu (double): exact expected mean of the distribution
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

    % the first 4 are important
    if nargin < 4
        help(mfilename);
        return;
    end

    n = length(nval);

    % Lower bound, Upper bound and Mean arrays.
    lower = zeros(n, 1);
    upper = zeros(n, 1);
    meanx = zeros(n, 1);

    for iv = [1:n; nval]
        i = iv(1);
        n = iv(2);

        [l, u, m] = confidenceint(icdf(rand(n, 1)), alpha);
        lower(i) = l;
        upper(i) = u;
        meanx(i) = m;
    end

    hold on;
    errorbar(nval, meanx, meanx - lower, upper - meanx, 'o');
    plot(nval, meanx, 'r', 'LineWidth', 2);
    plot([nval(1) nval(end)], [mu mu], 'k', 'LineWidth', 2);
    legend('Confidence Interval', 'Empiric Mean', 'Exact Mean');
    hold off;