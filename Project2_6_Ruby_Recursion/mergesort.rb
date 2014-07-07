def mergesort(arr)

    left = []; right = []; result = []

    return arr if arr.length <= 1

    midpoint = arr.length/2

    0.upto(midpoint-1) {|i| left << arr[i]}
    midpoint.upto(arr.length-1) {|i| right << arr[i]}

    left = mergesort(left)
    right = mergesort(right)

    result = merge(left,right)
    result

end

def merge(left,right)
    result = []
    until left.empty? or right.empty?
        if left.first <= right.first
            result << left.first
            left = left[1..-1]
        else
            result << right.first
            right = right[1..-1]
        end
    end
    return result + left + right
end

arr = [4,5,2,56,12,32,456,3,-3,8]
puts mergesort(arr)

