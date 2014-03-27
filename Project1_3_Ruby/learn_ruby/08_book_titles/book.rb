class Book

    attr_reader :title

    def title= (new_title)
        words = new_title.split(" ")
        small_words = ["and", "of", "the", "in", "a", "an"]
        words = [words[0].capitalize!] +

        words[1..words.length].each do |word|

            if small_words.include? word
                word
            else
                words =  word.capitalize!
            end

        end

        @title = words.join(" ")
    end

end