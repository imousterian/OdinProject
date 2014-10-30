class Piece

    attr_accessor :id, :x, :y, :old_location, :color

    def initialize(color=:white,x=0,y=0)
        @color = color
        @x = x
        @y = y
        update_old_location
        update_id(x,y)
    end

    def description
        @color == :white ? 'w' : 'b'
    end

    def update_old_location
        @old_location = [@x, @y]
    end

    def update_id(x,y)
        @id = x * 8 + y + 1
    end

    def move_to(x,y)
        if x.nil?
            raise ArgumentError, "x and y must be within the board"
        else
            update_id(x,y)
            update_old_location
            @x, @y = x, y
        end
    end

    def is_it_blocked?(board, from_x, from_y, to_x, to_y)

        result = false
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
                cell = board.board[to_x+i*direction_x][to_y]
                result = true if !cell.nil?
            elsif col > row
                cell = board.board[to_x][to_y+i*direction_y]
                result = true if !cell.nil?
            else
                cell = board.board[to_x+i*direction_x][to_y+i*direction_y]
                result = true if !cell.nil?
            end
        end
        result
    end
end

class Pawn < Piece

    def initialize(color,x,y)
        super(color,x,y)
        @step_counter = 2
    end

    def decrement_counter
        @step_counter -= 1
    end

    def description
        'P' + super()
    end

    def where_to_go?(x,y)
        if @step_counter > 1
            if (@old_location[0] - x).abs == 1
                step = 1
            elsif (@old_location[0] - x).abs == 2
                step = 2
            else
                step = 0
            end
        else
            step = 1
        end
        if @color == :white
            x == (@x - step) && (y == @y) ? true : false
        else
            x == (@x + step) && (y == @y) ? true : false
        end
    end

    def valid_move?(board, from_x, from_y, to_x, to_y)
        destination = board.board[to_x][to_y]
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
               cell = board.board[move_x][move_y]
                if cell.nil?
                    places << [move_x, move_y]
                else
                    if cell.color != @color
                        places << [move_x, move_y]
                    end
                end
            end
        end
        places
    end

    def valid_move?(board, from_x, from_y, to_x, to_y)
        destination = board.board[to_x][to_y]
        block = is_it_blocked?(board, from_x, from_y, to_x, to_y)

        x = (from_x - to_x).abs
        y = (from_y - to_y).abs
        if (x >= 0 and x <= 1 && y >= 0 && y <= 1)
            return true if destination.nil? || destination.color != @color
        end
        false
    end
end

class Rook < Piece

    def description
        'R' + super()
    end

    def rook_move?(from_x, from_y, to_x, to_y)
        return true if from_x == to_x || from_y == to_y
        return true if (from_x-to_x).abs == (from_y - to_y).abs
        false
    end

    def valid_move?(board, from_x, from_y, to_x, to_y)
        destination = board.board[to_x][to_y]
        move = rook_move?(from_x, from_y, to_x, to_y)
        block = is_it_blocked?(board, from_x, from_y, to_x, to_y)

        if !destination.nil?
            if destination.color != @color
                return true if move == true && block == false
            end
        else
            return true if move == true && block == false
        end
    end
end

class Knight < Piece

    def description
        'k' + super()
    end

    def valid_move?(board, from_x, from_y, to_x, to_y)
        destination = board.board[to_x][to_y]
        x = (from_x - to_x).abs
        y = (from_y - to_y).abs
        if destination.nil? || destination.color != @color
            if (x * 2 == 4 && y == 1) || (x * 2 == 2 && y == 2)
                return true
            end
        end
        false
    end
end

class Bishop < Piece
    def description
        'B' + super()
    end

    def bishop_move?(from_x, from_y, to_x, to_y)
        return false if from_x == to_x || from_y == to_y
        return true if (from_x-to_x).abs == (from_y - to_y).abs
        false
    end

    def valid_move?(board, from_x, from_y, to_x, to_y)
        destination = board.board[to_x][to_y]
        move = bishop_move?(from_x, from_y, to_x, to_y)
        block = is_it_blocked?(board, from_x, from_y, to_x, to_y)

        if !destination.nil?
            if destination.color != @color
                return true if move == true && block == false
            end
        else
            return true if move == true && block == false
        end
    end
end

class Queen < Piece

    def description
        'Q' + super()
    end

    def valid_move?(board, from_x, from_y, to_x, to_y)

        destination = board.board[to_x][to_y]
        move = true
        block = is_it_blocked?(board, from_x, from_y, to_x, to_y)

        if !destination.nil?
            if destination.color != @color
                return true if move == true && block == false
            end
        else
            return true if move == true && block == false
        end
    end
end
