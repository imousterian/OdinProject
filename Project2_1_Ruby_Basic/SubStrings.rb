
def substrings (words, dict)
    str = words.downcase.split(" ")

    hash = Hash.new

    dict.each do |item|
        str.each do |word|
            if word.include?(item)
                 if not(hash.has_key?(item))
                    hash[item] = 1
                else
                    hash[item] += 1
                end
            end
        end
    end

    return hash
end

dictionary = ["below", "down", "go", "going", "horn", "how", "howdy", "it", "i", "low", "own", "part", "partner", "sit"]

puts substrings("below", dictionary)
puts substrings("Howdy partner, sit down! How's it going?", dictionary)



# an experimental function to create combinations of substrings
# like abc -> a, b, c, ab, ac, abc

# def find_substrings(str)

#     results = []

#     (0..str.length).each do |c|
#         (1..str.length - c).each do |i|
#             sub = str[c...c+i ].join("")
#             results.push(sub.downcase)
#         end
#     end
#     return results
# end













