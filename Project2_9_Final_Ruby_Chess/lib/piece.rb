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

    def full_description
        @color == :white ? 'WHITE' : 'BLACK'
    end

    def set_id
        @id = Converter.convert_x_y_to_location(@x,@y)
    end

    def move_to(x,y)
        @x, @y = x, y
        set_id
    end

    def can_piece_move?(to_x, to_y)
        id = Converter.convert_x_y_to_location(to_x,to_y)
        return true if id >= 1 && id <= 64
        false
    end

    def valid_move?(board, to_x, to_y)
        destination = board.destination
        move = can_piece_move?(to_x, to_y)
        path_blocked = board.is_it_blocked?(@x, @y, to_x, to_y)

        if destination.nil? || destination.color != @color
            return true if move == true && path_blocked == false
        end
        false
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

    def can_kill?(to_x, to_y)
        x = (@x - to_x).abs
        y = (@y - to_y).abs
        return @x != to_x && @y != to_y && x <= 1 && y <= 1
        false
    end

    # overriding can_piece_move? and valid_move? for Pawn only as its
    # capture and move bevavior are different from other pieces
    def can_piece_move?(to_x, to_y)
        step = determine_step_counter(to_x)
        if  @color == :white
            super && to_x == (@x - step) && (to_y == @y) ? true : false
        else
            super && to_x == (@x + step) && (to_y == @y) ? true : false
        end
    end

    def valid_move?(board, to_x, to_y)
        destination = board.destination
        if destination.nil?
            return can_piece_move?(to_x, to_y)
        else
            return true if destination.color != @color && can_kill?(to_x, to_y)
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
           to_x = i[0]
           to_y = i[1]

           if can_piece_move?(to_x, to_y)
                loc = Converter.convert_x_y_to_location(to_x, to_y)
                cell = board.find_piece_in_collection(loc)
                places << [to_x, to_y] if cell.nil? || cell.color != @color
            end
        end
        places
    end

    def can_piece_move?(to_x, to_y)
        x = (@x - to_x).abs
        y = (@y - to_y).abs
        return true if (super && x >= 0 && x <= 1 && y >= 0 && y <= 1)
        false
    end
end

class Rook < Piece
    def description
        'R' + super()
    end

    def can_piece_move?(to_x, to_y)
        return true if super && @x == to_x || @y == to_y
        false
    end
end

class Knight < Piece
    def description
        'k' + super()
    end

    def can_piece_move?(to_x, to_y)
        x = (@x - to_x).abs
        y = (@y - to_y).abs
        return true if super && (x * 2 == 4 && y == 1) || (x * 2 == 2 && y == 2)
        false
    end
end

class Bishop < Piece
    def description
        'B' + super()
    end

    def can_piece_move?(to_x, to_y)
        return true if super && (@x-to_x).abs == (@y - to_y).abs
        false
    end
end

class Queen < Piece
    def description
        'Q' + super()
    end

    def can_piece_move?(to_x, to_y)
        return true if super && (@x == to_x || @y == to_y || (@x-to_x).abs == (@y - to_y).abs)
    end
end
