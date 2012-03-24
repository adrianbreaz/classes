'''Matrix Multiplication using the Strassen Algorithm.
Algorithm:
    - cut the two matrices A and B into ~equal 4 blocks
    - compute other 7 matrices by the formulas:
        P_1 = (A11 + A22) * (B11 + B22)
        P_2 = (A21 + A22) * B11
        P_3 = A11 * (B12 - B22)
        P_4 = A22 * (B21 - B11)
        P_5 = (A11 + A12) * B22
        P_6 = (A21 - A11) * (B11 + B12)
        P_7 = (A12 + A22) * (B21 + B22)
    - compute the result by blocks:
        C11 = (P_1 + P_4) * P_5 + P_7
        C12 = P_3 + P_5
        C21 = P_2 + P_4
        C22 = P_1 - P_2 + P_3 + P_6
    - re-assemble the blocks C11, C12, C21, C22 into the matrix C which is C = A * B.

WARNING: Only tested with sizes that are powers of 2. It shall implode for others.
'''
import random

def msub(matrix_a, matrix_b):
    '''Substract matrix_b from matrix_a.
    TODO: is this better with 'import operator'?
    '''
    sub = lambda x, y: x - y
    return _mperform_op(matrix_a, matrix_b, sub)

def madd(matrix_a, matrix_b):
    '''Add matrix_a and matrix_b.
    '''
    add = lambda x, y: x + y
    return _mperform_op(matrix_a, matrix_b, add)

def _mperform_op(ma, mb, op):
    '''Performs a general operation between the elements (i, j) of matrix_a and matrix_b.
    E.g. : op(matrix_a[i][j], matrix_b[i][j]).
    '''
    assert len(ma) == len(mb)
    assert len(ma[0]) == len(mb[0])

    return [[op(aij, bij) for aij, bij in zip(ra, rb)] for ra, rb in zip(ma, mb)]

def _cut_part(mat, rs, re, cs, ce):
    '''Cuts a part from a given matrix, from row rs to row re and from column
    cs to column ce.
    '''
    return [[e for e in row[cs:ce]] for row in mat[rs:re]]

def cut(matrix):
    '''Cuts a given matrix into 4 squares.
    TODO: should check dimensions and stuff.
    '''
    n = len(matrix)
    m11 = _cut_part(matrix, 0, n // 2, 0, n // 2)
    m12 = _cut_part(matrix, 0, n // 2, n // 2, n)
    m21 = _cut_part(matrix, n // 2, n, 0, n // 2)
    m22 = _cut_part(matrix, n // 2, n, n // 2, n)

    return [[m11, m12], [m21, m22]]

def remake(block_matrix):
    '''Given 4 blocks it reassembles them into a matrix.
    TODO: should check dimensions and stuff.
    '''
    n = len(block_matrix[0][0])
    m = len(block_matrix[1][0])

    block1 = block_matrix[0][0]
    [block1[i].extend(block_matrix[0][1][i]) for i in range(n)]
    block2 = block_matrix[1][0]
    [block2[i].extend(block_matrix[1][1][i]) for i in range(m)]
    block1.extend(block2)

    return block1

def _normal_mmul(matrix_a, matrix_b):
    '''Normal Matrix Multiplication using the formula:
        c_{i, j} = \sum_{k = 0}^n a_{i, k} * b_{k, j}
    '''
    n = len(matrix_a)
    c = [[0 for i in range(n)] for j in range(n)]

    for i in range(n):
        for j in range(n):
            for k in range(n):
                c[i][j] += matrix_a[i][k] * matrix_b[k][j]

    return c

def mmul(matrix_a, matrix_b):
    '''Multiplication using Strassen's algorithm as described above.
    '''
    if len(matrix_a) <= 5:
        return _normal_mmul(matrix_a, matrix_b)
    else:
        # cut into blocks
        a = cut(matrix_a)
        b = cut(matrix_b)

        # get products
        p1 = mmul(madd(a[0][0], a[1][1]), madd(b[0][0], b[1][1]))
        p2 = mmul(madd(a[1][0], a[1][1]), b[0][0])
        p3 = mmul(a[0][0], msub(b[0][1], b[1][1]))
        p4 = mmul(a[1][1], msub(b[1][0], b[0][0]))
        p5 = mmul(madd(a[0][0], a[0][1]), b[1][1])
        p6 = mmul(msub(a[1][0], a[0][0]), madd(b[0][0], b[0][1]))
        p7 = mmul(msub(a[0][1], a[1][1]), madd(b[1][0], b[1][1]))

        # construct final matrix
        c11 = madd(msub(madd(p1, p4), p5), p7)
        c12 = madd(p3, p5)
        c21 = madd(p2, p4)
        c22 = madd(madd(msub(p1, p2), p3), p6)

        # construct final matrix
        return remake([[c11, c12], [c21, c22]])

def print_m(matrix):
    '''Pretty prints matrix.
    '''
    if not matrix:
        return
    m = [["{:4}".format(i) for i in row] for row in matrix]
    print('\n'.join([' '.join(row) for row in m]))
    print

def test():
    import numpy as np
    a_np = np.random.rand(16, 16)
    b_np = np.random.rand(16, 16)
    a = [list(row) for row in a_np]
    b = [list(row) for row in b_np]

    print_m(a)
    print_m(b)

    print("addition")
    print_m(madd(a, b))

    print("substraction")
    print_m(msub(a, b))

    print("cut")
    slices = cut(a)
    print_m(slices[0][0])
    print_m(slices[0][1])
    print_m(slices[1][0])
    print_m(slices[1][1])

    print("recompose")
    print_m(remake(slices))

    print("multiplication")
    print_m(mmul(a, b))
    print(np.dot(a_np, b_np))

if __name__ == "__main__":
    test()
