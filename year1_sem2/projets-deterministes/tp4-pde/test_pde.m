f = @(x, y) 1;
border_f = @(x, y) [1 1 1 1];
border_t = [0 0 0 0];

N = 5;
M = 5;
area = [-1 1 -1 1];

SolveEq(f, area, border_f, border_t, N, M)