
require 'csv'

class Hangman

    attr_accessor :secret, :saved_counter

    def initialize(contents)
        @contents = CSV.open contents
    end

    def setup_new_game
        select_secret_word
        setup_display
    end

    def read_in_data_values
        arr = Array.new
        @contents.each {|i| arr.push(i)}
        arr
    end

    def setup_continued_game
        arr = read_in_data_values
        @saved_counter = arr[0][0]
        @secret = arr[1][0]
        @display = arr[2][0].split(' ')
    end

    def select_secret_word

        arr = read_in_data_values

        while(true)
            @secret = arr.sample[0]
            if @secret.length >= 5 and @secret.length <= 12
                return @secret.split('').map!(&:downcase)
            end
        end
    end

    def setup_display
        @display = Array.new(@secret.length) { |i| ' _ ' }
    end

    def display_board
        print "\n#{board}"
        puts " "
    end

    def board
        @display.join(' ')
    end

    def return_feedback(lets)

        @lette = lets.downcase

        if @secret.include?(@lette)
            puts "'#{lets}' is here! :)"
            letter_indices = fetch_indices
            letter_indices.each {|i| @display[i] = @lette}
        else
            puts "Sorry! This word doesn't contain '#{lets}' :("
        end
    end

    def fetch_indices
        @secret.split('').map.with_index { |value, index| index if value == @lette}.compact
    end

    def won?

        if @display.include?(' _ ') or @display.include?('_')
            false
        else
            true
        end
    end

    def save_turn(id,turn,results)

        filename = "saved_games/game#{id}.txt"
        File.open(filename, 'w') do |file|
            file.puts turn,@secret,results
        end
    end

end



class Game

    def count_files
        Dir.mkdir("saved_games") unless Dir.exists? "saved_games"
        Dir.glob(File.join('./saved_games', '**', '*')).select { |file| File.file?(file) }.count
    end

    def start_new_game
        @hangman = Hangman.new('5desk.txt')
        @hangman.setup_new_game
        @counter = 1
    end

    def start_saved_game(id)
        @hangman = Hangman.new("saved_games/game#{id}.txt")
        @hangman.setup_continued_game
        @counter = @hangman.saved_counter.to_i + 1
    end

    def make_game_selection(num)
        if num == '1'
            puts "Starting a new game!"
            start_new_game
        else
            if count_files == 0
                puts "You do not have any saved games yet. Starting a new game instead."
                start_new_game
            else
                puts "Enter the number of the game you want to play. You currently have #{count_files} games."
                puts "Enter a number between 1 and #{count_files}."
                number_selection = gets.chomp
                start_saved_game(number_selection)

                if @counter >= 12
                    puts "\nYou can't play the game that's already over."
                end
            end
        end
    end

    def play

        @alphabet = %w{ a b c d e f g h i j k l m n o p q r s t u v w x y z}

        total_count = count_files

        puts "Do you want to start a new game or load an old game?"
        puts "1 = load new game"
        puts "2 = load old game"

        game_selection = gets.chomp

        make_game_selection(game_selection)

        while(@counter < 13)

            @hangman.display_board

            puts "\n\nRound #{@counter} out of 12! Please enter a letter."
            letter = gets.chomp
            puts " "

            if @alphabet.include?(letter.downcase)

                @hangman.return_feedback(letter)

                if @hangman.won?
                    puts "\nVictory! ;)"
                    @counter = 14
                else
                    @counter += 1
                end
            else
                puts "Wrong input! :("
            end

            puts "\nDo you want to save the game? Enter Y for yes "
            input = gets.chomp

            if input == 'Y' or input == 'y'
                @hangman.save_turn(total_count+1,(@counter-1),@hangman.board)
            end
        end

        puts "\nGame over :( The secret word was '#{@hangman.secret}'." if @counter > 12 and !@hangman.won?
    end

end


g = Game.new
g.play

