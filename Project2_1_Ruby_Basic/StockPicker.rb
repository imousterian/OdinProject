# determines the days when the profit is maximum between buying and selling.
# input values are prices, and index is a day (starting at 0)
# you can't "sell" before "buying"
# output is the indices of the days when one buys and sells

def stock_picker(arr)

    days = 0
    maximum = 0
    range = []

    while(days < arr.length)
        bought = arr[days]

        (days...arr.length-1).each do |item|

            sold = arr[item+1]
            profit = sold - bought

            if profit > maximum
                maximum = profit
                range = days, item+1
            end
        end

        days+=1
    end

    return range

end

stocks = [17,3,6,9,15,8,6,1,10]
values = stock_picker(stocks)
puts "#{values}"






