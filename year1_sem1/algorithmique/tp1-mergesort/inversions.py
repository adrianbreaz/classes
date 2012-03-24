import mergesort
import random

def inversions(arr):
    '''Count the number of inversions in an array (i.e. the number of permutations
    to get a sorted array).
    Algorithm:
        - split array in two
        - call function for each half
        - call merge function to count the inversions between the two halves
        - the number of inversions in the array is number of inversions from
        each half plus the number of inversions between them
    Returns: (i, L) - number of inversions and sorted list.
    '''
    n = len(arr)
    if n == 1:
        return (0, arr)

    ra, A = inversions(arr[:n // 2])
    rb, B = inversions(arr[n // 2:])
    r, L = mergesort.merge(A, B, count=True)

    return (ra + rb + r, L)

def test():
    arr = list(range(1, 10))
    random.shuffle(arr)
    print(arr)
    print('inversions:', inversions(arr)[0])

if __name__ == "__main__":
    test()