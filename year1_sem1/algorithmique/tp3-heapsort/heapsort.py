'''Heapsort (uses a binary max heap).
Binary max heap properties:
    - the heap is a complete binary tree
    - each node is greater or equal to each of its children. (i.e the root is the
    biggest element)
Algorithm:
    - turn array into a heap
    - add the root to a the sorted list  and delete it (i.e. exhange it with the last
    element and fixDown the heap from position 0)
    - repeat until the heap is empty
Time: O(n*log(n)) to heapify and O(n*log(n)) to empty out the heap.
'''

def fixUp(heap, pos):
    '''Fixes up the heap from a given position: exchanges the element at pos with
    it's parent until it satisfies the heap property.
    '''
    while pos > 0:
        parent = pos // 2
        if heap[pos] > heap[parent]:
            heap[pos], heap[parent] = heap[parent], heap[pos]
        else:
            break
        pos = parent

def fixDown(heap, pos):
    '''Fixes down the heap from a given position: exchanges the element at pos with the
    biggest of it's children until the heap property is satisfied.
    '''
    def next_pos(heap, pos):
        if heap[2 * pos] > heap[2 * pos + 1]:
            nextp = 2 * pos
        else:
            nextp = 2 * pos + 1

        return nextp

    n = len(heap) - 1
    while 2 * pos + 1 < n:
        if heap[pos] < max(heap[2 * pos], heap[2 * pos + 1]):
            nextp = next_pos(heap, pos)
            heap[pos], heap[nextp] = heap[nextp], heap[pos]
            pos = nextp
        else:
            break


def init(size):
    '''Generates a random heap of size size.
    '''
    import random
    return heapify([random.randint(0, 74) for i in range(size)])

def heapify(array):
    '''Turns a random array into a heap.
    '''
    heap = []
    for item in array:
        insert(heap, item)

    return heap

def insert(heap, el):
    '''Insert an element into the heap
    '''
    heap.append(el)
    fixUp(heap, len(heap) - 1)

    return heap

def delMax(heap):
    '''Deletes the heap root.
    '''
    if len(heap) < 1:
        return

    deleted = heap.pop(0)
    if len(heap) > 1:
        heap.insert(0, heap.pop())
        fixDown(heap, 0)

    return deleted

def heapsort(arr):
    '''Heapsort.
    TODO: fix it. two elements are swapped for some reason.
    '''
    heap = heapify(arr)
    result = []
    while len(heap):
        result.append(delMax(heap))

    return result[::-1]

def test():
    heap = init(13)
    print('start:', heap)
    insert(heap, 20)
    print('insert 20:', heap)

    delMax(heap)
    print('deleted root:', heap)

    print('sorted:', heapsort(heap))

if __name__ == "__main__":
    test()
