function UnitTest(A, b, x, x0)
    % Description:
    %   Test all iterative method functions on a given system of the form A * x = b
    %   with a initial value of x0.
    %
    % Test 1: Test RSLJacobi and RSLJacobiVec
    % -----------------------------------------------------
    % Test 2: Test RSLGaussSeidel and RSLGaussSeidelVec
    % -----------------------------------------------------
    % Test 3: Test RSLRelaxation and RSLRelaxationVec
    % -----------------------------------------------------
    % Test 4: Test RSLRichardson and RSLRichardsonVec
    % -----------------------------------------------------
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2011

    if nargin < 4
        error('not enough input arguments');
    end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %       TEST 1: JACOBI
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [x1, it1] = RSLJacobi(A, b, x0);
    [x2, it2] = RSLJacobiVec(A, b, x0);

    DisplayResults('TEST 1: JACOBI', x, x1, it1, x2, it2);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %       TEST 2: Gauss-Seidel
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [x1, it1] = RSLGaussSeidel(A, b, x0);
    [x2, it2] = RSLGaussSeidelVec(A, b, x0);

    DisplayResults('TEST 2: GAUSS-SEIDEL', x, x1, it1, x2, it2);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %       TEST 3: S.O.R.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [x1, it1] = RSLRelaxation(A, b, x0);
    [x2, it2] = RSLRelaxationVec(A, b, x0);

    DisplayResults('TEST 3: S.O.R.', x, x1, it1, x2, it2);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %       TEST 1: RICHARDSON
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    [x1, it1] = RSLRichardson(A, b, x0);
    [x2, it2] = RSLRichardsonVec(A, b, x0);

    DisplayResults('TEST 4: RICHARDSON', x, x1, it1, x2, it2);