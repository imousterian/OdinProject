=begin
still refactoring ...
=end

$color_choices = %w{ red green blue yellow orange white purple violet }

class MasterMind

    def initialize(num)
        @board = Array.new(num) { |i| [' '] }
        $color_choices = $color_choices.map { |i| i[0].upcase }
        @codemaker = $color_choices.shuffle.slice(0..3)
        puts @codemaker.join(' ')

    end

    def convert_input
        @guess = gets.chomp
        @guess = @guess.chars.reject { |i| i == ' '}.map {|i| i.upcase }
    end

    def input_not_valid?
        return true if @guess.length != 4
        @guess.any? { |i|  !$color_choices.include?(i) }

    end

    def create_feedback_array

        @guess.each_with_index do |value, index|
            if @codemaker.include?(value)
                value == @codemaker[index] ? @feedback.push('B') : @feedback.push('W')
            end
        end
    end

    def check_guess(rounds_counter)

        convert_input

        @feedback = Array.new

        if input_not_valid? == true
            puts "Your input is incorrect. Try playing again..."
        else
            create_feedback_array
            # add selected choices and feedback to the board
            @board[rounds_counter-1].replace([@guess, '|', @feedback.shuffle])
        end

    end

    def display_board
        @board.each_with_index do |arr, index|

            len = arr.flatten.map { |i| i.chars }.flatten.length
            puts arr.join(' ')
            puts "-" * (len + (18 - len))
        end
    end

    def won?
        # puts "length " + @feedback.length.to_s
        if @feedback.empty?
            # puts "test"
            return 0
        else
            @feedback.count('B') == 4 ? true : false
        end
    end

end


class Game

    def stop_game

    end

    def convert_colors_to_letters
        return $color_choices.map { |i| i[0].upcase }.join(' ')
    end

    def display_title
        puts "Your board"
        puts "------------------"
        puts "Guesses | Hints"
        puts "------------------"
    end

    def play

        continue = true

        rounds_counter = 1

        while continue

            puts "Please choose how many turns you want to play. It must be an even number!\n\n"

            begin
                num = Kernel.gets.match(/\d+/)[0]
            rescue
                puts "This is not a number! Try again..."
            else
                if num.to_i.even?
                    puts "The following colors are available: R for red, G for green, B for blue, Y for yellow, O for orange, W for white, P for purple, V for violet."

                    master = MasterMind.new(num.to_i)

                    while rounds_counter <= num.to_i

                        puts "Round #{rounds_counter}. Choose 4 colors: #{convert_colors_to_letters}.\n\n"
                        master.check_guess(rounds_counter)
                        puts ' '
                        self.display_title
                        master.display_board
                        puts ' '

                        rounds_counter = num.to_i if master.won? == true

                        rounds_counter += 1

                        rounds_counter -= 1 if master.won? == 0

                    end

                    if master.won? == true
                        puts "Hoorray, you guessed all numbers!"
                        continue = false
                    else
                        puts "Sorry..."
                        continue = false
                    end

                else
                    puts "it must be an even number!"
                end
            end #end of else (rescue)
        end #end of while
    end #end of play
end


game = Game.new
game.play

# choices = %w{ A B C D E F }
# a = gets.chomp
# a = a.chars.reject { |i| i == ' '}.map {|i| i.upcase }
# puts a.any? {|i| !choices.include?(i) }










