
require 'csv'

class Hangman

    attr_accessor :secret

    def initialize(contents)
        @contents = CSV.open contents
        select_secret_word
        setup_display
    end

    def select_secret_word
        arr = Array.new
        @contents.each {|i| arr.push(i)}

        while(true)
            @secret = arr.sample[0]
            if @secret.length >= 5 and @secret.length <= 12
                puts @secret
                return @secret.split('').map!(&:downcase)
            end
        end
    end

    def setup_display
        @display = Array.new(@secret.length) { |i| ' _ ' }
    end

    def display_board
        print "\n#{@display.join(' ')}"
        puts " "
    end

    def return_feedback(lets)

        @lette = lets.downcase

        if @secret.include?(@lette)
            puts "'#{lets}' is here!"
            letter_indices = fetch_indices
            letter_indices.each {|i| @display[i] = @lette}
        else
            puts "Sorry! This word doesn't contain '#{lets}'."
        end
    end

    def fetch_indices
        @secret.split('').map.with_index { |value, index| index if value == @lette}.compact
    end

    def won?
        @display.include?(' _ ') ? false : true
    end

end

class Game



    def play

        @alphabet = %w{ a b c d e f g h i j k l m n o p q r s t u v w x y z}

        counter = 1

        hangman = Hangman.new('5desk.txt')

        while(counter < 13)

            puts "\n\nRound #{counter} out of 12! Please enter a letter."
            letter = gets.chomp
            puts " "

            if @alphabet.include?(letter.downcase)

                hangman.return_feedback(letter)
                hangman.display_board

                if hangman.won?
                    puts "\nVictory!"
                    counter = 14
                else
                    counter += 1
                end
            else
                puts "Wrong input!"
                hangman.display_board
            end

        end
        puts "\nGame over. The secret word was '#{hangman.secret}'." if counter > 12 and !hangman.won?
    end

end


g = Game.new
g.play

