# non-recursive solution of fibonacci problem
def fibs(n)

    arr = []

    0.upto(n) do |i|

        if i == 0
            a = 0; b = 0
        elsif i == 1
            a = 0; b = 1
        else
            a = arr[i - 1]; b = arr[i - 2]
        end

        s = a + b
        arr << s

    end
    arr
end

#recursive solution of fibonacci problem
def fibs_rec(n)
    return n if n <= 1
    return fibs_rec(n-1) + fibs_rec(n-2)
end


puts fibs(20)
# fibs_rec(20)
0.upto(20) {|i| puts fibs_rec(i)}
