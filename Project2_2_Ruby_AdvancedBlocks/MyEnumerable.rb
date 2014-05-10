
require 'rspec'

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

puts multiply_els([2,4,5]) # => 40


#############   RSPEC tests   #############

describe "enumerable" do

    describe "check my_each" do

        describe "without block" do
            it "should return an Enumerator" do
                n = [1,2,3].my_each
                n.should be_kind_of(Enumerator)
            end
        end

        describe "with block" do
            it "should return an array of multiples" do
                b = []
                n = [1,2,3].my_each { |i| b << i*2 }
                b.should == [2,4,6]
            end
        end
    end

    describe "check my_each_with_index" do
        describe "without block" do
            it "should return an Enumerator" do
                n = [1,2,3].my_each_with_index
                n.should be_kind_of(Enumerator)
            end
        end

        describe "with block" do
            it "should return an array of items multiplied by indices" do
                b = []
                n = [1,2,3].my_each_with_index { |i,j| b << i*j }
                b.should == [0,2,6]
            end
        end
    end

    describe "check my_select" do
        describe "without block" do
            it "should return an Enumerator" do
                n = [1,2,3].my_select
                n.should be_kind_of(Enumerator)
            end
        end

        describe "with block" do
            it "should return an array of even numbers" do
                n = [1,2,3,4,5].my_select { |num| num.even? }
                n.should == [2,4]
            end
        end
    end

    describe "check my_all?" do

        describe "without block" do

            it "should return false" do
                n = [1,false,4].my_all?
                n.should == false
            end

            it "should return false" do
                n = [nil,2,4].my_all?
                n.should == false
            end

            it "should return true" do
                n = [1,1,4].my_all?
                n.should == true
            end

            it "should return false" do
                n = [nil,false,4].my_all?
                n.should == false
            end
        end

        describe "with block" do
            it "should return true" do
                n = %w[ant bear cat].my_any? { |word| word.length >= 4 }
                n.should == true

            end
        end
    end


    describe "check my_any?" do

        describe "with block" do

            it "should return true" do
                n = %w[ant bear cat].my_any? { |word| word.length >= 4 }
                n.should == true
            end

            it "should return false" do
                n = %w[ant bear cat].my_any? { |word| word == "dog" }
                n.should == false
            end

            it "should return true" do
                n = %w[ant bear cat].my_any? { |word| word != "dog" }
                n.should == true
            end

            it "should return true" do
                n = [false,false,12].my_any? { |word| word.kind_of? Integer }
                n.should == true
            end
        end

        describe "without block" do

            it "should return false" do
                n = [nil,false,false].my_any?
                n.should == false
            end

            it "should return true" do
                n = [12,false,false].my_any?
                n.should == true
            end

            it "should return false" do
                n = [false,nil,false].my_any?
                n.should == false
            end
        end
    end

    describe "check my_none?" do

        describe "with block" do

            it "should return true" do
                n = %w{ant bear cat}.my_none? { |word| word.length == 5 }
                n.should == true
            end

            it "should return false" do
                n = %w{ant bear cat}.my_none? { |word| word.length >= 4 }
                n.should == false
            end
        end

        describe "without block" do

            it "should return true" do
                n = [].my_none?
                n.should == true
            end

            it "should return true" do
                n = [nil].my_none?
                n.should == true
            end

            it "should return true" do
                n = [nil,false].my_none?
                n.should == true
            end

            it "should return false" do
                n = [true,nil].my_none?
                n.should == false
            end
        end
    end

    describe "check my_count" do

        arr = [1,2,4,2]

        describe "with block" do
            it 'should be 3' do
                n = arr.my_count { |x| x%2==0 }
                n.should == 3
            end
        end
        describe "with arguments" do
            it "should be 2" do
                n = arr.my_count(2)
                n.should == 2
            end
        end

        describe "without arguments and a block" do
            it "should be 4" do
                n = arr.my_count
                n.should == 4
            end
        end
    end

    describe "check my_map" do
        describe "with block" do
            it "should get multiplied" do
                n = (1..4).my_map { |i| i*i }
                n.should == [1,4,9,16]
            end

            it "should have an array of true and false" do
                n = (1..10).my_map { |i| i >= 3 && i <= 7 }
                n.should == [false,false,true,true,true,true,true,false,false,false]
            end
        end

        describe "without block" do
            it "should return an Enumerator" do
                n = (1..3).my_map
                n.should be_kind_of(Enumerator)
            end
        end
    end

    describe "check my_inject" do

        describe "with a block" do

            describe "with initial" do
                it "has an initial 0" do
                    n = [1,2,3,4].my_inject(0) { |result, element| result + element }
                    n.should == 10
                end

                it "has an initial 2" do
                    n = [1,2,3,4].my_inject(2) { |result, element| result + element }
                    n.should == 12
                end
            end

            describe "without initial" do
                it "returns an array" do
                    n = [1,2,3,4,5,6].my_inject([]) do |result, element|
                        result << element  if element % 2 == 0
                        result
                    end
                    n.should == [2,4,6]
                end

                it "returns an integer" do
                    n = (5..10).inject { |sum, n| sum + n }
                    n.should == 45
                end
            end
        end

        describe "without a block" do

            describe "with initial and symbol" do
                it "should be 15" do
                    n = [1,2,3,4,5].my_inject(0,:+)
                    n.should == 15
                end

                it "should be 20" do
                    n = [1,2,3,4,5].my_inject(5,:+)
                    n.should == 20
                end

                it "should be 2" do
                    n = [1,2].my_inject(1,:*)
                    n.should == 2
                end
            end

            describe "with symbol only" do
                it "should be 11" do
                    n = [9,2].my_inject(:+)
                    n.should == 11
                end

                it "should be 40" do
                    n = [2,4,5].my_inject(:*)
                    n.should == 40
                end
            end
        end
    end

    describe "check my_map_two_args" do
        it "should execute proc and block" do
            add_one = Proc.new { |x| x + 1 }
            n = [1,2,3,4].my_map_two_args(add_one) { |x| x * 2 }
            n.should == [4,6,8,10]
        end

        it "should execute proc" do
            add_one = Proc.new { |x| x + 1 }
            n = [1,2,3,4].my_map_two_args(add_one)
            n.should == [2,3,4,5]
        end

        it "should execute block" do
            n = [1,2,3,4].my_map_two_args { |x| x * 2 }
            n.should == [2,4,6,8]
        end
    end
end

