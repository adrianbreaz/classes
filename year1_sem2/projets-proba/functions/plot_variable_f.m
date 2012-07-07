function plot_variable_f(vcdf, vicdf, vpdf, name, domain)
    % Using the inversion method construct a random variable with the inverse of
    % the CDF (vicdf) and plot the results together with the exact PDF and CDF.
    %
    % Arguments:
    %   - vcdf  (function): the CDF of our variable to simulate
    %   - vicdf (function): the inverse of the CDF, used to simulate the variable
    %   - vpdf  (function): the PDF of our desired variable
    %   - name  (string): the name of the distribution
    %   - domain(R^n): the area in which to plot the CDF and PDF.
    %
    % Usage:
    %   plot_variable_f(vcdf, vicdf, vpdf, 'Exponential', 0:0.1:10);
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

    n = 10000;
    X = vicdf(rand(n, 1));

    % FIXME: not the best heuristic like thing around.
    nbins = length(unique(X)) + 1;
    if nbins > 1000;
        nbins = nbins / 400;
    end

    subplot(1, 3, 1);
    hist(X / n, nbins);               % empiric PDF

    subplot(1, 3, 2);
    plot(domain, vpdf(domain), 'r', 'LineWidth', 2);    % exact PDF
    h = title(sprintf('Simulation of the %s distribution', name), 'FontSize', 11);

    subplot(1, 3, 3);
    hold on;
    cdfplot(X);                                         % empiric CDF
    axis([domain(1) domain(end) 0 1]);
    plot(domain, vcdf(domain), 'r-.');                  % exact CDF
    hold off;