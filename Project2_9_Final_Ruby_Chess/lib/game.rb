require './lib/piece.rb'
require './lib/converter.rb'

class Board

    include Converter
    attr_accessor :board, :piece_collection, :destination

    def initialize
        @board = Array.new (Converter.rows) { |i| Array.new(Converter.cols) { |j| nil } }
        @piece_collection = []
        @king_collection = []
    end

    def setup_pieces
        (0...Converter.rows).each do |i|
            @piece_collection << Pawn.new(:black,1,i)
            @piece_collection << Pawn.new(:white,6,i)
        end

        white_king = King.new(:white,7,4)
        black_king = King.new(:black,0,4)

        @piece_collection << Rook.new(:black,0,0)
        @piece_collection << Rook.new(:black,0,7)
        @piece_collection << Knight.new(:black,0,1)
        @piece_collection << Knight.new(:black,0,6)
        @piece_collection << Bishop.new(:black,0,2)
        @piece_collection << Bishop.new(:black,0,5)
        @piece_collection << Queen.new(:black,0,3)
        @piece_collection << black_king

        @piece_collection << Rook.new(:white,7,0)
        @piece_collection << Rook.new(:white,7,7)
        @piece_collection << Knight.new(:white,7,1)
        @piece_collection << Knight.new(:white,7,6)
        @piece_collection << Bishop.new(:white,7,2)
        @piece_collection << Bishop.new(:white,7,5)
        @piece_collection << Queen.new(:white,7,3)
        @piece_collection << white_king

        @king_collection << black_king
        @king_collection << white_king
    end

    def remove_piece_from_collection(piece)
        ind = @piece_collection.sort_by! { |x| x.id }.bsearch{|x| x.id >= piece.id}
        @piece_collection.delete(ind)
    end

    def find_piece_in_collection(pid)
        piece = @piece_collection.sort_by! {|x| x.id}.bsearch { |x| x.id >= pid}
        return piece if piece.id == pid
        nil
    end

    def destination=(dest)
        @destination = dest
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
        false
    end

    def get_king_location(turn)
        turn % 2 == 0 ? @king_collection[0] : @king_collection[1]
    end

    def is_it_blocked?(from_x, from_y, to_x, to_y)

        direction_x = from_x > to_x ? 1 : -1
        direction_y = from_y > to_y ? 1 : -1

        row = (from_x - to_x).abs
        col = (from_y - to_y).abs

        if  row > col
            diff = row
        else
            diff = col
        end

        (1...diff).each do |i|
            if row > col
                loc = Converter.convert_x_y_to_location(to_x+i*direction_x,to_y)
                cell = find_piece_in_collection(loc)
                return true if !cell.nil?
            elsif col > row
                loc = Converter.convert_x_y_to_location(to_x,to_y+i*direction_y)
                cell = find_piece_in_collection(loc)
                return true if !cell.nil?
            else
                loc = Converter.convert_x_y_to_location(to_x+i*direction_x,to_y+i*direction_y)
                cell = find_piece_in_collection(loc)
                return true if !cell.nil?
            end
        end
        false
    end

    def display
        puts " "
        (0...Converter.rows).each do |i|
            (0...Converter.cols).each do |j|
                pid = Converter.convert_x_y_to_location(i, j)
                piece = find_piece_in_collection(pid)
                if !piece.nil?
                    if pid < 10
                        print "." + piece.description.to_s + "#{piece.id.to_s} "
                    else
                        print piece.description.to_s + "#{i*Converter.rows+j+1} "
                    end
                else
                    print ".." + Converter.convert_x_y_to_location(i,j).to_s + " "
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
            puts "Yay for the games. Playing #{turn.upcase}. Pick a piece id and a board location. "
            @step = gets.chomp
            piece_id = @step.split(" ")[0]
            loc_id = @step.split(" ")[1]

            from_x,from_y = Converter.convert_location_to_x_y(piece_id)
            to_x, to_y = Converter.convert_location_to_x_y(loc_id)

            @piece_to_move = @board.find_piece_in_collection(piece_id.to_i)

            if !@piece_to_move.nil?

                destination = @board.find_piece_in_collection(loc_id.to_i)

                @board.destination = destination

                if @piece_to_move.valid_move?(board, from_x, from_y, to_x, to_y)

                    if  @piece_to_move.instance_of?(Pawn)
                        @piece_to_move.decrement_step_counter
                    end

                    if !destination.nil? && destination.color != @piece_to_move.color
                        @board.remove_piece_from_collection(destination)
                    end

                    @piece_to_move.move_to(to_x,to_y)

                    # check for a check/mate here:

                    king = @board.get_king_location(@turns)
                    @board.check_for_check(king)
                    @turns += 1

                    puts "------------ #{@piece_to_move.class}'s moved to #{to_x} #{to_y} ------------"

                else
                    puts " #{@piece_to_move.class}'s move is invalid"
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
