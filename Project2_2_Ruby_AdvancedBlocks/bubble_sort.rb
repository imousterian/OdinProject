def bubble_sort(unsorted_array)

    swapped = true # create a variable that keeps track of whether the swap's occured

    while swapped # while we are swapping...

        swapped = false # set swapped to false in case there are still swaps to do

        (0...unsorted_array.size-1).each do |i| # iterate over...

            if (unsorted_array[i] > unsorted_array[i+1]) # compare two elements, and if first element is larger than the second, they have to be swapped

                holder = unsorted_array[i+1] # set a holder variable to the value of the second (smaller) element
                unsorted_array[i+1] = unsorted_array[i] # set the value of the the second element to the value of the first
                unsorted_array[i] = holder #set the value of the first element now to the value of the holder

                swapped = true # swap's happened
            end
        end
    end

    return unsorted_array
end


def bubble_sort_by(unsorted_array)

    swapped = true

    while swapped

        swapped = false

        (0...unsorted_array.size-1).each do |i|

            if yield(unsorted_array[i], unsorted_array[i+1]) < 0 # calling a block with yield here...
                holder = unsorted_array[i+1]
                unsorted_array[i+1] = unsorted_array[i]
                unsorted_array[i] = holder

                swapped = true

            end
        end
    end



    return unsorted_array
end

##########

array_to_sort = [4,3,78,2,0,2]
puts bubble_sort(array_to_sort) # => [0,2,2,3,4,78]

##########

array_to_sort_by = ["hi", "hello", "hey","h"]

bubble_sort_by(array_to_sort_by) do |left,right|
    right.length - left.length
end

puts array_to_sort_by # => ["hi", "hey", "hello"]























