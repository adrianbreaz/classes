function [coeffs] = lanczoscoeffs(n, g)
    % Compute coefficients for use in the Lanczos approximation of the
    % Gamma Function.
    %
    % Argumens:
    %   - n     number of computed coefficients
    %   - g     scalar used in computations
    %
    % Usage:
    %   coeffs = lanczoscoeffs(n, g);
    %
    % References:
    %   [1] http://www.numericana.com/answer/info/godfrey.htm
    %   [2] http://my.fit.edu/~gabdo/gamma.txt
    %   [3] http://oeis.org/A002457
    %   [4] http://en.wikipedia.org/wiki/Chebyshev_polynomials
    %   [5] http://en.wikipedia.org/wiki/Binomial_coefficient
    %   [6] http://imgur.com/aNoL0
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2012

    % some checks to be sure we don't mess up from the start
    if nargin < 2
        error('you need to be more specific about what you want me to do.');
    end

    if n > 20
        error('your numbers are making me feel dizzy');
    end

    % precomputed Sloane Sequence as definied in [3]
    D = [1 6 30 140 630 2772 12012 51480 218790 923780 3879876 16224936 67603900 280816200 1163381400 4808643120 19835652870 81676217700 335780006100];

    % initialize all matrices
    B = diag(ones(n, 1));
    B(1, :) = ones(1, n);

    C = zeros(n, n);
    C(1) = 0.5;

    F = 1:n;

    % The coefficients of for the Lanczos coefficients will be computed using:
    %   coeffs = D * B * C * F
    % where D, B and C are nxn matrices and F is a vector of size n.

    % == compute the matrix D
    % The D matrix is computed using the reverse of the Sloane Sequence ([3]) on the
    % diagonal
    D = diag([1 -D(1:n - 1)]);

    % == compute the matrix B
    % The B matrix is a upper triangular matrix in which each row is an odd row
    % from the Pascal matrix (as computed by Matlab) (binomial coefficients) using
    % alternating signs according to (colum + row) % 2. More details on [1] and [5].
    k = 1;
    for i = 2:n
        m = k + 1;
        for j = i + 1:n
            B(i, j) = (-1)^(mod(i + j, 2)) * nchoosek(m, k);
            m = m + 1;
        end
        k = k + 2;
    end

    % == compute the matrix C
    % The C matrix is a lower triangular matrix where each row is an even row computed
    % from Chebyshev coefficients as defined in [4]. Uses the simple Matlab function
    % chebyshevpoly to compute them.
    % NOTE: hope the chebyshevpoly function exists in Matlab and not just in Octave.
    k = 2;
    for i = 2:n
        cheb = fliplr(chebyshevpoly(1, k));
        cheb = cheb(find(cheb ~= 0));
        C(i, 1:length(cheb)) = cheb;
        k = k + 2;
    end

    % == compute the vector F
    % Computed using the following formula (from [1] and [2]):
    %   F(g, n) = \frac{\sqrt(2)}{\pi} * \Gamma(n + 1/2) * e^{n + g + 0.5} *
    %                   * (n + g + 0.5)^{-(n + 0.5)}
    % To compute \Gamma(n + 1/2) we use 6.1.12 from [7].
    %
    % TODO: figure out why this doesn't work. it uses the right formula.
    sqrtpi = 1.77245385090552;
    gamma12 = prod(1:2:(2 * n - 1)) / 2^n * sqrtpi;
    nar = 0:n - 1;
    F = (sqrt(2) / pi * gamma12) * (exp(nar + g + 0.5) .* (nar + g + 0.5).^(-(nar + 0.5)));

    % finally assemble everything.
    coeffs = (D * (B * C)) * F';