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

    def king_collection
        @king_collection
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
        piece = @piece_collection.sort_by! {|x| x.id}.bsearch { |x| x.id >= pid }
        if !piece.nil?
            return piece if piece.id == pid
        else
            return nil
        end
    end

    def destination=(dest)
        @destination = dest
    end

    def legal_moves_left?(king)
        @places = king.places_to_hide(self)
        @places.length == 0 ? counter = 1 : counter = @places.length
        while !@places.empty?
            x, y = @places.pop
            @piece_collection.each do |piece|
                if piece.valid_move?(self, x, y) && king.color != piece.color
                    counter -= 1
                end
            end
        end

        counter > 0 ? true : false
    end

    def threatening_piece(king)
        threat = nil
        @piece_collection.each do |piece|
            if piece.valid_move?(self, king.x, king.y) && king.color != piece.color
                return threat = piece
            end
        end
        threat
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
                    if pid < 10
                        print " .." + Converter.convert_x_y_to_location(i,j).to_s + " "
                    else
                        print ".." + Converter.convert_x_y_to_location(i,j).to_s + " "
                    end

                end
            end
            puts " "
            print "\n"
        end
        puts " "
    end
end
