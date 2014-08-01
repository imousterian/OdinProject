class Board

    attr_accessor :cols, :rows, :matrix, :test

    def initialize(rows,cols)
        @cols = cols
        @rows = rows
        @matrix = Array.new (rows) { |i| Array.new(cols) { |j| nil }}
    end

    def set_color_at(x,y,color)
        @matrix[x][y] = color unless !@matrix[x][y].nil?
    end

    def get_new_location_by_column(column)
        (0...rows).reverse_each do |i|
            col = column - 1
            return i, col if @matrix[i][col].nil?
        end
        false
    end

    def record_mark(location, sign)
        if get_new_location_by_column(location)
            x,y = get_new_location_by_column(location)
            set_color_at(x,y,sign)
        else
            puts 'The entire column is already filled. Please try again.'
            false
        end
    end

    def consecutive_neighbors?(in_array,piece)
        arr = in_array.collect.each_with_index { |i,index| index if i == piece }.compact
        return arr.sort.each_cons(2).all? { |x,y| x == y - 1 }
    end

    def horizontal_count(piece)
        @matrix.each do |row|
            return true if row.count(piece) == 4 and consecutive_neighbors?(row,piece)
        end
        false
    end

    def vertical_count(piece)
        @matrix.transpose.each do |col|
            return true if col.count(piece) == 4 and consecutive_neighbors?(col,piece)
        end
        false
    end

    def collect_diagonals_nw
        result = []
        (0...3).each do |ix|
            result << (ix-rows...0).collect {  |i| @matrix [i][ix-i] }
            result << (0...ix+4).collect {  |i| @matrix [i][ix-i+3] }
        end
        result
    end

    def diagonal_count_nw(piece)
        collect_diagonals_nw.each do |diagonal|
            return true if diagonal.count(piece) == 4 and consecutive_neighbors?(diagonal,piece)
        end
        false
    end

    def collect_diagonals_ne
        result = []
        (0...3).each do |ix|
            result << (ix...rows).collect {  |i| @matrix [i][i-ix] }
            result << (ix+1...cols).collect {  |i| @matrix [i-(ix+1)][i] }
        end
        result
    end

    def diagonal_count_ne(piece)
        collect_diagonals_ne.each do |diagonal|
            return true if diagonal.count(piece) == 4 and consecutive_neighbors?(diagonal,piece)
        end
        false
    end

    def display

        (0...rows).each do |i|
            (0...cols).each do |j|

                if !@matrix[i][j].nil?
                    print @matrix[i][j].to_s + "  "
                else
                    print (j+1).to_s + "  "
                end
            end
            print "\n"
        end
    end
end


class Game

    attr_accessor :current_player, :players

    def initialize
        @players = [['player1', 'X'], ['player2', 'O']]
        @current_player = @players.shift
        @players.push(@current_player)
        set_board
    end

    def set_board
        @board = Board.new(6,7)
    end

    def switch_players(switch=true)
        if switch
            @current_player = @players.shift
            @players.push(@current_player)
        end
    end

    def display_greeting
        puts "\n\nLet the games begin. Player 1 plays with 'X', and Player 2 plays with '0'.\n\n"
    end

    def update_game
        input = select_board_location
        @board.record_mark(input.to_i, @current_player[1])
    end

    def another_game?
        puts "\n\nDo you want to play another game?\n\n"
        input = gets.chomp
        return true if input == 'y'
        false
    end

    def replay_game
        if another_game?
            set_board
            switch_players
            play_main
        end
    end

    def play_one_game
        display_greeting
        print_board

        loop do
            switch = update_game
            print_board
            break if game_over?
            switch_players(switch)
        end
        display_winner
    end

    def print_board
        @board.display
    end

    def play_main
        play_one_game
        replay_game
    end

    def display_winner
        puts ""
        puts "The winner is #{winner}."
    end

    def select_board_location

        puts "\n\nDear #{@current_player[0]}: please select where to drop the piece.\n\n"

        begin
            input = gets.chomp.match(/^[1-7]$/)[0]
        rescue StandardError => e
            puts "Input must be in a range of  1 to 7. Please try again."
            retry
        else
            input
        end

    end

    def game_over?
        mark = @current_player[1]
        return mark if @board.vertical_count(mark)    == true
        return mark if @board.horizontal_count(mark)  == true
        return mark if @board.diagonal_count_ne(mark) == true
        return mark if @board.diagonal_count_nw(mark) == true
        false
    end

    def winner
        return @current_player[0]
    end
end


g = Game.new
g.play_main


