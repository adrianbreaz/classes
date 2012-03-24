# Classic Quicksort implementation
def quicksort(arr)
    return arr if arr.size <= 1
    left, right = arr[1..-1].partition { |x| x < arr[0] }
    return quicksort(left) + [arr[0]] + quicksort(right)
end

arr = (0..10).map { |x| rand(100) }
p arr, quicksort(arr)
