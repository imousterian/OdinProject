

def translate(str)

    vowels = ["a", "e", "i", "o", "u", "y"]

    words = str.split(" ")

    result = ""

    words.each do |word|

        counter = 0

        if (vowels.include? word[0])
            counter += 0
        elsif word[0,2] == "qu"
            counter += 2
        else
            if (vowels.include? word[1])
                counter += 1

            elsif(vowels.include? word[2])
                if (word[1,2] == "qu")
                    counter += 1
                end
                counter += 2
            else
                counter += 3
            end
        end


        result = [result, word[counter,word.length] + word[0,counter] + "ay"].join(' ').strip

    end

    result

end

