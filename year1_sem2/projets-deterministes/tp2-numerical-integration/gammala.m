function [gamma] = gammala(m)
    % Gamma function computed by using the Lanczos approximation [3]. The Gamma function
    % is defined by the following integral:
    %   \Gamma(m) = \int_0^{\infty} x^{m - 1} * e^{-x} dx
    % A very useful recurrence relation for \Gamma is defined for m > 0 in [1]:
    %   \Gamma(m + 1) = m * \Gamma(m)
    %
    % Arguments:
    %   m     nxm matrix containing the values to be computed
    %
    % Usage:
    %   [gamma] = gammala(m);
    %
    % References:
    %   [1] http://en.wikipedia.org/wiki/Gamma_function
    %   [2] http://en.wikipedia.org/wiki/Reflection_formula
    %   [3] http://en.wikipedia.org/wiki/Lanczos_approximation
    %   [4] http://www.numericana.com/answer/info/godfrey.htm
    %   [5] http://my.fit.edu/~gabdo/gamma.txt
    %   [6] Numerical Recipies in C by  William H. Press, Saul A. Teukolsky, William
    %   T. Vetterling and Brian P. Flannery
    %   [7] http://www.rskey.org/CMS/index.php/the-library/11
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

    % remember the original size in case it was a matrix or something
    initial_size = size(m);

    % make the whole thing into a vector just to be sure
    m = m(:);

    % remember the old value of m
    m_old = m;

    % allocated needed size
    gamma = 0 .* m;

    % find all negative numbers and flip them
    neg = find(real(m) < 0);
    if ~isempty(neg)
        m(neg) = -m(neg);
    end

    % constant g as given by [7] for n = 4.
    g = 3.65;

    % the array of coefficients used for the Lanczos approximation from [7] for n = 4.
    % This has a precision of about 7 digits. Other coefficients could be obtained using:
    %   - the supplied lanczoscoeffs function
    %   - from [4], should give the best precision, up to 15 digits
    %   - from [6], probably the most widely used
    p = [
        2.50662846436560184574;
        41.4174045302370911317;
        -27.0638924937115168658;
        2.23931796330266601246
    ];

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % start computing the Lanczos approximation using the formula:
    %   \Gamma(m + 1) = \sqrt(2*\pi) * (m + g + 0.5 )^{m + 0.5} *
    %                   e^{-(m + g + 0.5)} * A_g(m).                    (1)
    % Where A_g(m) is defined by:
    %   A_g(m) = p_0 + \sum_1^n \frac{p_k}{m + k}                       (2)
    % using the coefficients defined above.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % make it easier to use the various values of m
    %   - we're computing the function using m - 1 because (1) is defined for m + 1
    %   - m = m - 1 + 0.5
    %   - mg = m - 1 + 0.5 + g
    m = m - 0.5;
    mg = m + g;

    % compute A_g(m) using (2)
    a = p(1);
    for pp = (size(p, 1) - 1):-1:1
        a = a + p(pp + 1) ./ (m + pp);
    end

    % compute the actual gamma function using (1)
    gamma = (sqrt(2 * pi) * a) .* ((mg.^m) .* exp(-mg));

    % for the negative values we're using Euler's Reflection Formula as definied in [2].
    % Slighly modified by using the recurrence formula \Gamma(-m + 1) = -m * \Gamma(-m)
    % to obtain:
    %   \Gamma(m) = \frac{pi}{-m * \Gamma(-m) * sin(pi * m)}
    % where m is negative.
    if ~isempty(neg)
        gamma(neg) = - pi ./ (m_old(neg) .* gamma(neg) .* sin(pi * m_old(neg)));
    end

    % find the poles of the Gamma function and set them lower than infinity. These
    % are definied at the points -1, -2, -3, -4, -5, ...
    poles = find(round(m_old) == m_old & imag(m_old) == 0 & real(m_old) <= 0);
    if ~isempty(poles)
        gamma(poles) = 10;
    end

    % finally put the values of gamma in the same shape as the given m
    gamma = reshape(gamma, initial_size);
