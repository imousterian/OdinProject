require './lib/piece.rb'

class Board
    @@rows = 8
    @@cols = 8

    attr_accessor :board, :piece_collection

    def initialize
        @board = Array.new (@@rows) { |i| Array.new(@@cols) { |j| nil } }
        @piece_collection = []
        @king_collection = []
    end

    def remove_piece_from_collection(piece)
        @piece_collection.sort_by! { |x| x.id }
        ind = @piece_collection.bsearch{|x| x.id >= piece.id}
        @piece_collection.delete(ind)
    end

    def x_y_converter(i,j)
        i * @@rows + j + 1
    end

    def update_collection
        @piece_collection = []
        @king_collection = []
        (0...@@rows).each do |i|
            (0...@@cols).each do |j|
                if !@board[i][j].nil?
                    @piece_collection << @board[i][j]
                    if @board[i][j].instance_of?(King)
                        @king_collection << @board[i][j]
                    end
                end
            end
        end
    end

    def check_for_check(king)
        @piece_collection.each do |piece|
            if piece.color != king.color
                if piece.valid_move?(self, piece.x, piece.y, king.x, king.y)
                    puts "Check! #{piece.class} #{piece.color} #{piece.id} vs king #{king.color}"
                    places = king.places_to_hide(self)
                    while !places.empty?
                        x, y = places.pop
                        if piece.valid_move?(self, piece.x, piece.y, x, y)
                            puts "Mate!"
                            return true
                        end
                    end
                    return true
                end
            end
        end
    end

    def get_king_location(turn)
        turn % 2 == 0 ? @king_collection[0] : @king_collection[1]
    end

    def update(piece)
        old_x, old_y = piece.old_location
        @board[old_x][old_y] = nil
        @board[piece.x][piece.y] = piece
        update_collection
    end

    def convert_loc_to_xy(loc)
        @board.each_with_index do |i, ix|
            @board.each_with_index do |j, jx|
                return ix, jx if loc == (ix * @@rows + jx + 1).to_s
            end
        end
        nil
    end

    def setup_pieces
        (0...@@rows).each do |i|
            @piece_collection << Pawn.new(:black,1,i)
            @piece_collection << Pawn.new(:white,6,i)
        end

        @piece_collection << Rook.new(:black,0,0)
        @piece_collection << Rook.new(:black,0,7)
        @piece_collection << Knight.new(:black,0,1)
        @piece_collection << Knight.new(:black,0,6)
        @piece_collection << Bishop.new(:black,0,2)
        @piece_collection << Bishop.new(:black,0,5)
        @piece_collection << Queen.new(:black,0,3)
        @piece_collection << King.new(:black,0,4)

        @piece_collection << Rook.new(:white,7,0)
        @piece_collection << Rook.new(:white,7,7)
        @piece_collection << Knight.new(:white,7,1)
        @piece_collection << Knight.new(:white,7,6)
        @piece_collection << Bishop.new(:white,7,2)
        @piece_collection << Bishop.new(:white,7,5)
        @piece_collection << Queen.new(:white,7,3)
        @piece_collection << King.new(:white,7,4)

        @king_collection << King.new(:white,7,4)
        @king_collection << King.new(:black,0,4)

        populate_cells
    end

    def populate_cells
        @piece_collection.each do |i|
            x, y = self.convert_loc_to_xy(i.id.to_s)
            @board[x][y] = i
        end
    end

    def display
        puts " "
        (0...@@rows).each do |i|
            (0...@@cols).each do |j|
                if !@board[i][j].nil?
                    n = x_y_converter(i,j)
                    if n < 10
                        print print "." + @board[i][j].description.to_s + "#{@board[i][j].id.to_s} "
                    else
                        print @board[i][j].description.to_s + "#{i*@@rows+j+1} "
                    end
                else
                    print ".." + x_y_converter(i,j).to_s + " "
                end
            end
            puts " "
            print "\n"
        end
        puts " "
    end
end

class Game

    attr_accessor :board

    def turn
        @turns % 2 == 0 ? 'white' : 'black'
    end

    def play
        @turns = 0
        @board = Board.new
        @board.setup_pieces
        game = true
        @board.display
        while game
            puts " Yay for the games. Playing #{turn}. Pick a piece id and a board location. "
            @step = gets.chomp
            piece = @step.split(" ")[0]
            new_loc = @step.split(" ")[1]
            from_x,from_y = @board.convert_loc_to_xy(piece)
            to_x,to_y = @board.convert_loc_to_xy(new_loc)

            @piece_to_move = @board.board[from_x][from_y]
            opponent = @board.board[to_x][to_y]

            if !@piece_to_move.nil?
                    if @piece_to_move.valid_move?(@board, from_x, from_y, to_x, to_y)
                        if @piece_to_move.instance_of?(Pawn)
                            @piece_to_move.decrement_counter
                        end
                        destination_cell = @board.board[to_x][to_y]

                        @piece_to_move.move_to(to_x,to_y)
                        if !destination_cell.nil? && destination_cell != @piece_to_move
                            @board.remove_piece_from_collection(destination_cell)
                        end
                        @board.update(@piece_to_move)

                        # check for a check/mate here:
                        king = @board.get_king_location(@turns)
                        @board.check_for_check(king)
                        @turns += 1
                        puts "---------- #{@piece_to_move.class}'s' moved to #{to_x} #{to_y} ------------"

                    else
                        puts " #{@piece_to_move.class}'s' move is invalid"
                    end
            else
                puts "Can't move a piece that doesn't exist!"
            end
            @board.display
        end

    end
end

g = Game.new
g.play
