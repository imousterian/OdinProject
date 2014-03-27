def echo(word)
    return word
end

def shout(word)
    return word.upcase
end

def repeat (word, num=2)

    return ([word] * num).join(' ')

end

def start_of_word(word, num)
    return word[0, num]
end

def first_word(word)
    return word.split(" ")[0]
end

def titleize(word)
    str = word.split(" ")
    result = ""

    str.each do |item|
        res = item
        if(item != "and" and item != "over" and item != "the")
            res = item.capitalize
        end

        str.first.capitalize!

        result = [result, res].join(' ').strip
    end

    return result
end










