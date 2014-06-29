=begin
could still be refactored and improved.
=end

$color_choices = %w{ red green blue yellow orange white purple violet }

class MasterMind

    def initialize(num)
        @board = Array.new(num) { |i| [' '] }
        $color_choices = $color_choices.map { |i| i[0].upcase }
    end

    def make_secret_code(code_input)
        if code_input == '2'
            # computer generates the secret code
            @codemaker = $color_choices.shuffle.slice(0..3)
            puts @codemaker.join(' ')
        elsif code_input == '1'
            # human creates an secret code
            puts "Choose 4 colors: R G B Y O W P V\n\n"
            @codemaker = convert_input
            @guess = nil # probably need to change that so that the code doesn't depend on resetting @guess
        else
            puts "Wrong input! Try again."
        end
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
            else
                @feedback.push(nil)
            end
        end
    end

    def check_guess(rounds_counter, code_input)

        @feedback = Array.new

        if code_input == '2'

            convert_input

            if input_not_valid? == true
                puts "Your input is incorrect. Try playing again..."
            else
                create_feedback_array
                # add selected choices and feedback to the board
                @board[rounds_counter-1].replace([@guess, '|', @feedback.compact.shuffle])
            end

        elsif code_input == '1'

            computer_makes_guess

            create_feedback_array

            keep_correctly_guessed_elements

            # display results on the board
            @board[rounds_counter-1].replace([@guess, '|', @feedback.compact.shuffle])

        end

    end

    def keep_correctly_guessed_elements
        indices = @feedback.map.with_index {|x,i| i unless x.nil?}.compact
        @guessed_correctly = indices.map.with_index {|x,i| @guess[x]}
    end

    def computer_makes_guess
        if @guess.nil?
            # first round, computer makes a random guess
            @guess = $color_choices.shuffle.slice(0..3)
        else
            # other rounds, computer keeps correctly guessed elements and adds new ones as needed
            if !extra_elements_to_be_guessed.nil?
                @guess = @guessed_correctly + extra_elements_to_be_guessed
            else
                @guess
            end
        end
    end

    def extra_elements_to_be_guessed
        diff = $color_choices - @guessed_correctly

        if @guessed_correctly.length < 4
            len = 4 - @guessed_correctly.length
            @rand = diff.shuffle.slice(0..len-1)
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
        if @feedback.empty?
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

                    puts "Do you want to create a secret code or do you want to guess?"
                    puts "Enter 1 for the former. Enter 2 for the latter."

                    choice = gets.chomp

                    master = MasterMind.new(num.to_i)

                    master.make_secret_code(choice)

                        while rounds_counter <= num.to_i

                            puts "Round #{rounds_counter}. Choose 4 colors: #{convert_colors_to_letters}.\n\n"
                            master.check_guess(rounds_counter, choice)
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








