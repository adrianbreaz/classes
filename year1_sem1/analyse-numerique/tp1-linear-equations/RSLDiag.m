function [x] = RSLDiag(A, b)
    % Description:
    %   Solve the system of equations A * x = b when the matrix A is diagonal.
    % Arguments:
    %   A       (M_(n, n))      - diagonal matrix.
    %   b       (R^n)           - vector.
    % Usage:
    %   [x] = RSLDiag(A, b)
    %
    % Copyleft Alexandru Fikl <alexfikl@gmail.com> (c) 2011

    % check assertions
    if nargin < 2
        error('not enough input arguments');
    end

    [n, m] = size(A);
    if n ~= m
        error('matrix not square');
    end

    if length(b) ~= n
        error('vector b is not the right size');
    end

    if ismember(0, diag(A))
        error('matrix has 0 on diagonal');
    end

    % initializations
    x = zeros(n, 1);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %                   ALGORITHM
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 1:n
        x(i) = b(i) / A(i, i);
    end