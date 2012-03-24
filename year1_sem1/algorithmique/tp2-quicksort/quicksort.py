import random

def quicksort(arr):
    '''3-Way Partitioning Quicksort.
    Everybody knows the classic algorithm.
    This just separates the elements that are equal to the pivot in a separate list.
    '''
    n = len(arr)
    if n <= 1:
        return arr

    start = []
    middle = [arr[0]]
    end = []

    for i in range(1, n):
        if arr[i] < arr[0]:
            start.append(arr[i])
        elif arr[i] > arr[0]:
            end.append(arr[i])
        else:
            middle.append(arr[i])

    return quicksort(start) + middle + quicksort(end)

def test():
    arr = [random.randint(1, 100) for i in range(10)]
    print(arr)
    print(quicksort(arr))

if __name__ == "__main__":
    test()