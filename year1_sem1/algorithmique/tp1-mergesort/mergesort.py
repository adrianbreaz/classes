import random

def merge(arra, arrb, count=False):
    '''Merge function. Takes 2 already sorted arrays and returns one sorted
    array with the elements of the 2.
    Optional argument: count the number of inversions between the two arrays.

    Merge algorithm:
        - start from the end of arrays A and B
        - if A and B are not empty
        - check which one has the bigger element
        - if A: pop element from A and push to result
        - if B: pop element from B and push to result
        - if A or B is empty: push the remaining array into the result.

    Inversions algorithm:
        - start from the end of arrays A and B
        - if A and B are not empty
        - check which one has the bigger element
        - if A: pop element from A and increment the current counted position
        - if B: pop element from B, pass to the next counting position and
        copy over the current count
        - if B still has elements increment the last position with the number of
        remaining elements
        - the number of inversions is the sum of inversions from each position.

    NOTE: Start from the end because it is easier to count inversions that way.
    Should work the same for mergesort.
    '''
    result = []
    n = len(arrb) - 1
    ct = [0] * (n + 1)

    while arra or arrb:
        if arra and arrb:
            if arra[-1] < arrb[-1]:
                result.insert(0, arrb.pop())

                if count and n:
                    ct[n - 1] = ct[n]
                    n -= 1
            else:
                result.insert(0, arra.pop())

                if count:
                    ct[n] += 1
        elif arra:
            result.insert(0, arra.pop())
        else:
            result.insert(0, arrb.pop())

            if count and n:
                ct[n - 1] = ct[n]
                n -= 1

    if count:
        return (sum(ct), result)
    return result

def mergesort(arr):
    '''Mergesort. O(n*log(n))
    Algorithm:
        - array split in two
        - call mergesort with the two halves
        - the returned arrays are already sorted
        - call the merge function to merge them into the result
    '''
    n = len(arr)
    if n == 1:
        return arr

    arra = mergesort(arr[:n // 2])
    arrb = mergesort(arr[n // 2:])
    return merge(arra, arrb)

def test():
    arr = [random.randint(0, 1000) for i in range(10)]
    print(arr)
    print(mergesort(arr))

if __name__ == "__main__":
    test()
