class Game

    def initialize
        @board = Board.new
        @array_of_players = [Player.new('X',1), Player.new('O',2)]
    end

    def play

        continue = true

        switch_players = true

        puts "\n\nLet the games begin. Player 1 plays with 'X', and Player 2 plays with '0'.\n\n"

        @board.display

        while continue

            if switch_players == true
                current_player = @array_of_players.shift
                puts current_player.description + "Enter the number on the board where you want to place your mark."
            end

            begin
                loc = Kernel.gets.match(/\d+/)[0]
            rescue
                puts "Erroneous input! " + current_player.description + "Try entering a number from 1 through 9.\n\n"
                switch_players = false
            else

                if @board.location_available?(loc.to_i)

                    mark = current_player.player_play

                    @board.record_mark(loc.to_i,mark)

                    continue = game_continues?(mark)

                    puts current_player.description + "You won!" if continue == false && @board.board_empty? == true

                    puts "Deadlock: no one has won!" if continue == false && @board.board_empty? == false

                    switch_players = true
                    @array_of_players.push(current_player)

                else
                    puts "This location is already taken by another player! " + current_player.description + "Enter the number on the board where you want to place your mark."
                    switch_players = false
                end

            end

            @board.display

        end

    end

    def game_continues?(mark)
        return false if @board.check_rows(mark) == true
        return false if @board.check_cols(mark) == true
        return false if @board.check_diagonal1(mark) == true
        return false if @board.check_diagonal2(mark) == true
        return false if @board.board_empty? == false
        true
    end

end

class Board

    @@size = 3

    attr_accessor :matrix

    def initialize
        @matrix = Array.new (@@size) { |i| Array.new(@@size) { |j| nil }}
    end

    def get_new_location(location)
        @matrix.each_with_index do |i, ix|
            @matrix.each_with_index do |j, jx|
                return ix,jx if location == (ix * @@size + jx + 1)
            end
        end
    end

    def location_available?(location)
        x,y = get_new_location(location)
        @matrix[x][y] == nil ? true : nil
    end

    def record_mark(location, sign)
        x,y = get_new_location(location)
        @matrix[x][y] = sign
    end

    def check_rows(element)
        @matrix.each_with_index do |i, ix|
            return true if i.count(element) == 3
        end
        false
    end

    def check_cols(element)
        @matrix.transpose.each_with_index do |i, ix|
            return true if i.count(element) == 3
        end
        false
    end

    def check_diagonal1(element)
        return true if (0...@@size).collect { |i| @matrix[i][i] }.count(element) == 3
        false
    end

    def check_diagonal2(element)
        return true if (0...@@size).collect { |i| @matrix[i][@@size-1-i] }.count(element) == 3
        false
    end

    def board_empty?
        @matrix.each_with_index do |i, ix|
            return true if i.count(nil) > 0
        end
        false
    end

    def display
        @matrix.each_with_index do |i, ix|
            @matrix.each_with_index do |j, jx|
                if !@matrix[ix][jx].nil?
                    print @matrix[ix][jx].to_s + " "
                else
                    print (ix * @@size + jx + 1).to_s + " "
                end
            end
            print "\n"
        end
    end
end

class Player

    def initialize(mark, num)
        @mark = mark
        @num = num
    end

    def description
        "Player #{@num}: "
    end

    def player_play
        @mark
    end

end


# g = Game.new
# g.play
