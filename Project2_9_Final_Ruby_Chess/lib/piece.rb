require './lib/converter.rb'

class Piece

    include Converter
    attr_accessor :id, :x, :y

    def initialize(color=:white,x=0,y=0)
        @color = color
        @x, @y = x, y
        set_id
    end

    def color
        @color
    end

    def description
        @color == :white ? 'w' : 'b'
    end

    def set_id
        @id = @x * 8 + @y + 1
    end

    def move_to(x,y)
        if x.nil?
            raise ArgumentError, "x and y must be within the board"
        else
            @x, @y = x, y
            set_id
        end
    end

end

class Pawn < Piece

    def initialize(color,x,y)
        super(color,x,y)
        @step_counter = 2
    end

    def description
        'P' + super()
    end

    def decrement_step_counter
        @step_counter -= 1
    end

    def determine_step_counter(to_x)
        step = 0
        if @step_counter > 1
            if (@x - to_x).abs == 1
                step = 1
            elsif (@x - to_x).abs == 2
                step = 2
            end
        else
            step = 1
        end
        return step
    end

    def where_to_go?(to_x,to_y)

        step = determine_step_counter(to_x)

        if  @color == :white
            to_x == (@x - step) && (to_y == @y) ? true : false
        else
            to_x == (@x + step) && (to_y == @y) ? true : false
        end
    end

    def valid_move?(board, from_x, from_y, to_x, to_y)
        destination = board.destination
        x = (from_x - to_x).abs
        y = (from_y - to_y).abs

        return true if destination.nil? && where_to_go?(to_x, to_y)

        if from_x != to_x && from_y != to_y && x <= 1 && y <= 1
            return true if !destination.nil? && destination.color != @color
        end
        false
    end
end

class King < Piece

    def description
        'K' + super()
    end

    def places_to_hide(board)
        places = []
        moves = [ [@x-1,@y], [@x-1, @y-1], [@x, @y-1], [@x+1, @y-1], [@x+1, @y], [@x+1, @y+1], [@x, @y+1], [@x-1, @y+1] ]
        moves.each do |i|
           move_x = i[0]
           move_y = i[1]
           if (move_x >= 0 && move_x <= 7) && (move_y >= 0 && move_y <= 7)
                loc = Converter.convert_x_y_to_location(move_x, move_y)
                cell = board.find_piece_in_collection(loc)
                if cell.nil?
                    places << [move_x, move_y]
                else
                    places << [move_x, move_y] if cell.color != @color
                end
            end
        end
        places
    end

    def piece_movements?(from_x, from_y, to_x, to_y)
        x = (from_x - to_x).abs
        y = (from_y - to_y).abs
        return true if (x >= 0 and x <= 1 && y >= 0 && y <= 1)
        false
    end

    def valid_move?(board, from_x, from_y, to_x, to_y)
        destination = board.destination
        move = piece_movements?(from_x, from_y, to_x, to_y)

        if destination.nil? || destination.color != @color
            return true if move == true
        end
        false
    end
end

class Rook < Piece

    def description
        'R' + super()
    end

    def piece_movements?(from_x, from_y, to_x, to_y)
        return true if from_x == to_x || from_y == to_y
        false
    end

    def valid_move?(board, from_x, from_y, to_x, to_y)
        destination = board.destination
        move = piece_movements?(from_x, from_y, to_x, to_y)
        path_blocked = board.is_it_blocked?(from_x, from_y, to_x, to_y)

        if destination.nil? || destination.color != @color
            return true if move == true && path_blocked == false
        end
    end

end

class Knight < Piece

    def description
        'k' + super()
    end

    def piece_movements?(from_x, from_y, to_x, to_y)
        x = (from_x - to_x).abs
        y = (from_y - to_y).abs
        return true if (x * 2 == 4 && y == 1) || (x * 2 == 2 && y == 2)
        false
    end

    def valid_move?(board, from_x, from_y, to_x, to_y)
        destination = board.destination
        move = piece_movements?(from_x, from_y, to_x, to_y)
        if destination.nil? || destination.color != @color
            return move
        end
        false
    end
end

class Bishop < Piece
    def description
        'B' + super()
    end

    def piece_movements?(from_x, from_y, to_x, to_y)
        return true if (from_x-to_x).abs == (from_y - to_y).abs
        false
    end

    def valid_move?(board, from_x, from_y, to_x, to_y)
        destination = board.destination
        move = piece_movements?(from_x, from_y, to_x, to_y)
        path_blocked = board.is_it_blocked?(from_x, from_y, to_x, to_y)

        if destination.nil? || destination.color != @color
            return true if move == true && path_blocked == false
        end
    end
end

class Queen < Piece

    def description
        'Q' + super()
    end

    def valid_move?(board, from_x, from_y, to_x, to_y)
        destination = board.destination
        path_blocked = board.is_it_blocked?(from_x, from_y, to_x, to_y)

        if destination.nil? || destination.color != @color
            return true if path_blocked == false
        end
    end
end
