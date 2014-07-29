require './lib/MyEnumerable'

describe "enumerable" do

    describe "#my_each" do

        context "without block" do
            it "returns an Enumerator" do
                expect([1,2,3].my_each).to be_kind_of Enumerator
            end
        end

        context "with block" do
            it "returns an array of preperly manipulated variables" do
                b = []
                [1,2,3].my_each { |i| b << i*2 }
                expect(b).to eql [2,4,6]
            end
        end
    end

    describe "#my_each_with_index" do
        context "without block" do
            it "returns an Enumerator" do
                expect([1,2,3].my_each_with_index).to be_kind_of Enumerator
            end
        end

        context "with block" do
            it "returns an array of preperly manipulated variables" do
                b = []
                [1,2,3].my_each_with_index { |i,j| b << i*j }
                expect(b).to eql [0,2,6]
            end
        end
    end

    describe "#my_select" do
        context "without block" do
            it "returns an Enumerator" do
                expect([1,2,3].my_select).to be_kind_of Enumerator
            end
        end

        context "with block" do
            it "returns an array of appropriately selected numbers" do
                expect([1,2,3,4,5].my_select{|num| num.even?}).to eql [2,4]
            end
        end
    end

    describe "#my_all?" do

        context "without block" do

            it "returns false if false value is present" do
                expect([1,false,4].my_all?).to eql false
            end

            it "returns false if nil value is present" do
                expect([nil,2,4].my_all?).to eql false
            end

            it "returns true if neigher false nor nil values are present" do
                expect([1,1,4].my_all?).to eql true
            end

            it "returns false if both nil and false values are present" do
                expect([nil,false,4].my_all?).to eql false
            end
        end

        context "with block" do
            it "returns true under specified conditions" do
                expect(%w[ant bear cat].my_any? { |word| word.length >= 4 }).to eql true
            end
        end
    end


    describe "#my_any?" do

        context "with block" do

            it "returns true under specified conditions" do
                expect(%w[ant bear cat].my_any? { |word| word.length >= 4 }).to eql true
            end

            it "returns false under wrong search conditions" do
                expect(%w[ant bear cat].my_any? { |word| word == "dog" }).to eql false
            end

        end

        context "without block" do

            it "returns false if nil value if present" do
                expect([nil,false,false].my_any?).to eql false
            end

            it "returns true if at least one element is not false" do
                expect([12,false,false].my_any?).to eql true
            end
        end
    end

    describe "#my_none?" do

        context "with block" do

            it "returns true under correct conditions" do
                expect(%w{ant bear cat}.my_none? { |word| word.length == 5 }).to eql true
            end

            it "returns false under wrong conditions" do
                expect(%w{ant bear cat}.my_none? { |word| word.length >= 4 }).to eql false
            end
        end

        context "without block" do

            it "returns true when array is empty" do
                expect([].my_none?).to eql true
            end

            it "returns true when nil element is present" do
                expect([nil].my_none?).to eql true
            end

            it "returns true when none of the elements are true" do
                expect([nil,false].my_none?).to eql true
            end

            it "returns false when at least one element is true" do
                expect([true,nil].my_none?).to eql false
            end
        end
    end

    describe "#my_count" do

        subject { [1,2,4,2] }

        context "with block" do
            it 'returns correct value' do
                expect(subject.my_count { |x| x%2==0 }).to eql 3
            end
        end
        context "with arguments" do
            it "returns correct count of values equal to the argument" do
                expect(subject.my_count(2)).to eql 2
            end
        end

        context "without arguments and a block" do
            it "returns number of elements" do
                expect(subject.my_count).to eql 4
            end
        end
    end

    describe "#my_map" do
        context "with block" do
            it "returns properly multiplied values" do
                expect((1..4).my_map { |i| i*i }).to eql [1,4,9,16]
            end

            it "returns an array of true and false values based on specified conditions" do
                expect((1..10).my_map { |i| i >= 3 && i <= 7 }).to eql [false,false,true,true,true,true,true,false,false,false]
            end
        end

        context "without block" do
            it "returns an Enumerator" do
                expect((1..3).my_map).to be_kind_of Enumerator
            end
        end
    end

    describe "#my_inject" do

        context "with a block" do

            context "with initial value" do
                it "returns correct value when initial is 0" do
                    expect([1,2,3,4].my_inject(0) { |result, element| result + element }).to eql 10
                end

                it "returns correct value when initial is 2" do
                    expect([1,2,3,4].my_inject(2) { |result, element| result + element }).to eql 12
                end
            end

            context "without initial value" do
                it "returns an array of correct value" do
                    n = [1,2,3,4,5,6].my_inject([]) do |result, element|
                        result << element  if element % 2 == 0
                        result
                    end
                    expect(n).to eql [2,4,6]
                end

                it "returns a correct integer" do
                    expect((5..10).inject { |sum, n| sum + n }).to eql 45
                end
            end
        end

        context "without a block" do

            context "with initial and symbol" do
                it "returns a correct sum" do
                    expect([1,2,3,4,5].my_inject(0,:+)).to eql 15
                end

                it "returns a correct multiplication" do
                    expect([1,2].my_inject(1,:*)).to eql 2
                end
            end

            context "with symbol only" do
                it "returns a correct sum" do
                    expect([9,2].my_inject(:+)).to eql 11
                end

                it "returns a correct multiplication" do
                    expect([2,4,5].my_inject(:*)).to eql 40
                end
            end
        end
    end

    context "#my_map_two_args" do
        it "executes proc and block and returns an array" do
            add_one = Proc.new { |x| x + 1 }
            expect([1,2,3,4].my_map_two_args(add_one) { |x| x * 2 }).to eql [4,6,8,10]
        end

        it "executes proc and returns an array" do
            add_one = Proc.new { |x| x + 1 }
            expect([1,2,3,4].my_map_two_args(add_one)).to eql [2,3,4,5]
        end

        it "executes block and returns an array" do
            expect([1,2,3,4].my_map_two_args { |x| x * 2 }).to eql [2,4,6,8]
        end
    end
end
