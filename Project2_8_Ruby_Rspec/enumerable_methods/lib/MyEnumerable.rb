module Enumerable

    def my_each

        return self.to_enum if !block_given?

        for i in self
            yield i
        end

    end

    def my_each_with_index

        return self.to_enum if !block_given?

        counter = 0

        for i in self
            yield i, counter
            counter += 1
        end

    end

    def my_select

        return self.to_enum if !block_given?

        result = []

        for i in self
            result << i if yield i
        end

        return result

    end

    def my_all?

        count_true = 0
        for i in self
            if block_given?
                count_true += 1 unless yield(i)
            else
                count_true += 1 unless i
            end
        end

        return count_true == 0 ? true : false

    end

    def my_any?

        count_true = 0

        for i in self
            if block_given?
                count_true += 1 if yield(i)
            else
                count_true += 1 if (i != false and not i.nil?)
            end
        end

        return (count_true == 0) ? false : true
    end

    def my_none?

        count_true = 0

        for i in self
            if block_given?
                count_true += 1 if yield(i)
            else
                count_true += 1 if i
            end

        end

        return (count_true == 0) ? true : false

    end

    def my_count (arg = nil)

        count_elements = 0

        for i in self
            if block_given?
                count_elements += 1 if yield(i)
            else
                if arg == nil
                    return self.length
                else
                    count_elements += 1 if arg == i
                end
            end
        end

        return count_elements
    end

    def my_map

        return self.to_enum if !block_given?

        result = []

        for i in self
            result << yield(i)
        end

        return result

    end

    def my_map(&proc)

        return self.to_enum if !block_given?

        result = []

        for i in self
            result << proc.call(i)
        end

        return result

    end


    def my_inject(initial=nil,sym=nil)

        result = initial.nil? ? nil : initial

        if block_given?
            for i in self
                result = yield(result,i)
            end
        else
            if sym.nil?
                sym = initial
                initial = nil
            end

            for i in self
                if initial.nil?
                    initial = i
                    result = initial
                else
                    result = result.send(sym,i)
                end
            end
        end

        return result

    end

    def my_map_two_args(proc=nil, &block)

        result = []

        for i in self
            result << block.call(proc.call(i)) if proc and block_given?
            result << proc.call(i) if !block_given?
            result << yield(i) if !proc and block_given?
        end

        return result
    end

end


# check the inject method:
def multiply_els(arr)
    # multiplies all the elements of the array together by using my_inject
    return arr.my_inject(:*)
end

# puts multiply_els([2,4,5]) # => 40

