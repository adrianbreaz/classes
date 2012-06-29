function corr = corrempiric(X, Y)
    N = length(X);
    cov = sum(X .* Y)/N - sum(X) * sum(Y) / N^2;
    corr = cov / sqrt(var(X) * var(Y));
