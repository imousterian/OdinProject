# new game:

    # load in the dictionary
    # randomly select a word between 5 and 12 characters

require 'csv'

class Game

    def initialize(contents)
        @contents = CSV.open contents
    end

    def select_secret_word
        arr = Array.new
        @contents.each {|i| arr.push(i)}

        continue = true

        while(true)
            @secret = arr.sample[0]
            if @secret.length >= 5 and @secret.length <= 12
                # puts @secret
                puts @secret.length
                return @secret
                # continue = false
            end

        end
        # @secret
    end

    def play

    end

    def prints
        puts @contents
    end

end


g = Game.new('5desk.txt')
puts g.select_secret_word
g.prints
