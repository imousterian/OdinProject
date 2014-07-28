#implementation of caesar cipher method using hashes

def caesar_cipher(arr, num=0)

    raise(ArgumentError, 'Argument is not numeric') unless num.is_a? Numeric

    hash = Hash[('a'..'z').map.with_index.to_a]

    (0..arr.length-1).each do |item|

        letter = arr[item].downcase

        if (hash[letter] != nil)

            new_index = hash[letter] + num.to_i

            if (new_index >= 26)
                new_index = new_index - 26
            end

            new_value = hash.key(new_index)

            if (arr[item] === arr[item].capitalize)
                new_value = new_value.upcase
            end

            arr[item] = new_value

        end
    end

    return arr

end

# puts "Enter a string to cipher: "
# input = gets.chomp
# puts "Enter number of letters to shift: "
# number = gets.chomp
# puts caesar_cipher(input, number)
