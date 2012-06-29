function f = cdfuniform(x, a, b, n)
    if x < a
        f = 0 * x;
    elseif x > b
            f = ones(length(x), 1);
    else
        f = (floor(x) - a + 1) / n;
    end
