require './lib/board.rb'

class Game

    def turn
        @turns % 2 == 0 ? 'white' : 'black'
    end

    def determine_winners(board)
        board.king_collection.each do |king|
            board.destination = king
            under_check = board.threatening_piece(king)
            legal_moves = board.legal_moves_left?(king)

            if legal_moves == true && !under_check.nil?
                puts "WINNING: #{under_check.full_description} Check! #{under_check.class} #{under_check.color} vs #{king.class} #{king.color}"
                return true
            elsif legal_moves == false && !under_check.nil?
                puts "WINNING: #{under_check.full_description} Check & Mate!  #{under_check.class} #{under_check.color} vs #{king.class} #{king.color}"
                @game = false
                return true
            elsif legal_moves == false && under_check.nil?
                puts "WINNING: #{turn.upcase} StaleMate!  #{@piece_to_move.class} #{@piece_to_move.color} vs #{king.class} #{king.color}"
                @game = false
                return true
            end
        end
        false
    end

    def play
        @turns = 0
        @board = Board.new
        @board.setup_pieces
        @game = true
        @board.display

        while @game
            puts "Yay for the games. Playing #{turn.upcase}. Pick a piece id and a board location. "
            @step = gets.chomp
            piece_id = @step.split(" ")[0]
            loc_id = @step.split(" ")[1]

            to_x, to_y = Converter.convert_location_to_x_y(loc_id)

            @piece_to_move = @board.find_piece_in_collection(piece_id.to_i)

            if !@piece_to_move.nil?

                destination = @board.find_piece_in_collection(loc_id.to_i)
                @board.destination = destination

                if @piece_to_move.valid_move?(@board, to_x, to_y)

                    if  @piece_to_move.instance_of?(Pawn)
                        @piece_to_move.decrement_step_counter
                    end

                    if !destination.nil?
                        @board.remove_piece_from_collection(destination)
                    end

                    @piece_to_move.move_to(to_x,to_y)

                    determine_winners(@board)

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
