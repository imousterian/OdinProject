

def translate(str)
    vowels = "aeiouq"
    punctuations = ",.!" #[",", "!", "."]
    words = str.split(" ")
    finalResult = ""

    words.each do |word|
        result = ""
        some = 0

        if (punctuations.index(word[word.length-1]) == nil)
            some = 0
        else
            some = 2
        end



        if(vowels.index(word[0]) != nil)
            result = "test" #word[0,word.length-some] + "ay"
        else
            if (vowels.index(word[1]) != nil)
                result = "test2"#word[1,word.length] + word[0] + "ay"

                if(word[1,2] == "qu")
                    result = "test3" #word[3,word.length] + word[0] + "quay"
                end

            elsif (vowels.index(word[2]) != nil)
                result = "test4" #word[2,word.length] + word[0,2] + "ay"
            else
                result = "tset5" #word[3,word.length] + word[0,3] + "ay"
            end
        end

        if(word[0,2] == "qu")
           result = word[2,word.length] + "qu" + "ay"
        end

        finalResult = [finalResult,result].join(" ").strip

    end

    finalResult.downcase!

    if(words[0][0,1] == words[0][0,1].upcase)
        finalResult.capitalize!
    end

    return finalResult

end

def punctuation? punctuation
    punctuations.include? punctuation
end