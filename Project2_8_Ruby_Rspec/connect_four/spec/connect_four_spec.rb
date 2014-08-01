require './lib/connect_four'

describe "Board" do

    let(:board) { Board.new(6,7) }

    describe "#new" do

        it "returns a new Board object" do
            expect(board).to be_an_instance_of Board
        end

        it "returns correct number of cols" do
            expect(board.cols).to eql 7
        end

        it "returns correct number of rows" do
            expect(board.rows).to eql 6
        end
    end

    describe "#obtaining information on the color piece location" do

        it "sets the color at a given board position if the location is available and the input is x and y" do
            expect(board.set_color_at(0,5,'red')).to eql "red"
        end

        it "sets the color at a given board position and converts the input from a column to x and y" do
            expect(board.record_mark(7,'X')).to eql 'X'
        end

        it "determines the proper x and y coordinates where to place a piece by columns" do
            expect(board.get_new_location_by_column(1)).to eql [5,0]
        end

        it "does not set the color at a given board position if the location is not available" do
            expect(board.set_color_at(0,5,"red")).to eql "red"
            expect(board.set_color_at(0,5,'yellow')).to_not eql 'yellow'
        end

        it "returns false if the top row is already full" do
            (0...6).each {|i| allow(board.set_color_at(i,0,'X'))}
            expect(board.record_mark(1,'X')).to be_falsey
        end

    end

    describe "#determning if 4 color pieces are located in a given row" do

        it "checks the count of neighboring color pieces horizontally" do
            board.matrix[0] = ['o', 'x', 'x', 'x', 'x', 'o', 'o']
            expect(board.horizontal_count('x')).to eql true
        end

        it "checks the count of neighboring color pieces vertically" do
            board.matrix[0][0] = 'o'
            board.matrix[1][0] = 'x'
            board.matrix[2][0] = 'x'
            board.matrix[3][0] = 'x'
            board.matrix[4][0] = 'x'

            expect(board.vertical_count('x')).to eql true
        end

        it "checks the count of neighboring color pieces in NW direction" do
            board.matrix[5][3] = 'x'
            board.matrix[4][4] = 'x'
            board.matrix[3][5] = 'x'
            board.matrix[2][6] = 'x'

            expect(board.diagonal_count_nw('x')).to be_truthy
        end

        it "checks the count of neighboring color pieces in NE direction" do
            board.matrix[2][0] = 'x'
            board.matrix[3][1] = 'x'
            board.matrix[4][2] = 'x'
            board.matrix[5][3] = 'x'

            expect(board.diagonal_count_ne('x')).to be_truthy
        end

    end

    describe "#determining consecutive neighbors" do

        it "determines if consecutive neighbors are present" do
            board.matrix[0] = ['o', 'x', 'x', 'x', 'x', 'o', 'o']
            expect(board.consecutive_neighbors?(board.matrix[0], 'x')).to be_truthy
        end

        it "determines if consecutive neighbors are not present" do
            board.matrix[0] = ['o', 'x', 'o', 'x', 'x', 'o', 'o']
            expect(board.consecutive_neighbors?(board.matrix[0], 'x')).to be_falsey
        end

    end

end


describe "Game" do

    let (:game)    { Game.new }

    before :each do
        allow(game).to receive(:puts)
        allow(game).to receive(:print_board)
        @player2 = game.players.first
        @player1 = game.players.last
    end

    describe "#new" do

        it "returns a new Game object" do
            expect(game).to be_an_instance_of Game
        end
    end

    describe "#switching players" do

        it "swaps players 1 and 2" do
            expect(game.current_player).to eql @player1
            game.switch_players
            expect(game.current_player).to eql @player2
        end

        it "swaps players 2 and 1" do
            game.switch_players
            expect(game.current_player).to eql @player2
            game.switch_players
            expect(game.current_player).to eql @player1
        end

    end

    describe "#getting input" do

        it "receives an input from a player" do
            allow(game).to receive(:gets).and_return('1')
            expect(game.select_board_location).to eq("1")
        end

    end

    describe "#playing another game" do

        it "recognizes 'y' as the only input if players want another game" do
            allow(game).to receive(:gets).and_return('y')
            expect(game.another_game?).to be_truthy
        end

        it "recognizes any input other than 'y' if players want another game" do
            allow(game).to receive(:gets).and_return('n', '2', 'd')
            expect(game.another_game?).to be_falsey
        end

    end

    describe "#initializing a game" do

        it "initializes an array with players" do
            expect(game.players.count).to eql 2
        end

        it "sets the current player to the first player in the array of players" do
            expect(game.current_player).to eql @player1
        end

        it "initializes an empty board" do
            expect(game.instance_variable_get(:@board)).to be_an_instance_of Board
        end

    end

    describe "#determning winners" do

        let (:current_board) {game.instance_variable_get(:@board)}

        let (:rows) { current_board.rows }
        let (:cols) { current_board.cols }

        let (:game)    { Game.new }


        describe "vertical win" do

            array1 = [ 0,  1,  2 ]
            array2 = [-2, -1,  0 ]

            array1.zip(array2).each do |a, b|

                game = Game.new
                current_board = game.instance_variable_get(:@board)

                (a...(current_board.rows + b)).each do |i|
                    (0...current_board.cols).each do |j|
                        current_board.set_color_at(i, j, 'X')
                    end
                end

                it 'recognizes a vertical win by a current player' do
                    expect(game.game_over?).to eql 'X'
                    expect(game.winner).to eql @player1[0]
                end

            end

        end


        describe "horizontal win" do

            array1 = [ 0, 1, 2, 3 ]
            array2 = [-3,-2, -1, 0 ]

            array1.zip(array2).each do |a, b|

                game = Game.new
                current_board = game.instance_variable_get(:@board)

                (0...(current_board.rows)).each do |i|
                    (a...current_board.cols+b).each do |j|
                        current_board.set_color_at(i, j, 'X')
                    end
                end

                it 'recognizes a horizontal win by a current player' do
                    expect(game.game_over?).to eql 'X'
                    expect(game.winner).to eql @player1[0]
                end

            end

        end

        describe "diagonal win in NE direction" do

            it "recognizes diagonal win in NE direction by a current player" do

                (0...3).each do |ix|
                    (ix...rows).collect   {  |i| current_board.set_color_at(i,i-ix, 'X') }
                    (ix+1...cols).collect {  |i| current_board.set_color_at(i-(ix+1),i,'X') }
                end

                expect(game.game_over?).to eql 'X'
                expect(game.winner).to eql @player1[0]
            end

        end

        describe "diagonal win in NW direction" do

            it "recognizes diagonal win in NW direction by a current player" do
                (0...3).each do |ix|
                    (ix-rows...0).collect {  |i| current_board.set_color_at(i,ix-i, 'X') }
                    (0...ix+4).collect {  |i| current_board.set_color_at(i,ix-i+3, 'X') }
                end

                expect(game.game_over?).to eql 'X'
                expect(game.winner).to eql @player1[0]
            end

        end

        describe "#playing a game" do

            it "recognizes the first player as a winner" do
                allow(game).to receive(:select_board_location).and_return(1,2,1,2,1,2,1,2)
                expect(game).to receive(:game_over?).and_call_original.exactly(7).times
                game.play_one_game
                expect(game.winner).to eq @player1[0]
            end

            it "recognizes the second player as a winner" do
                allow(game).to receive(:select_board_location).and_return(5,6,7,6,7,6,5,6)
                expect(game).to receive(:game_over?).and_call_original.exactly(8).times
                game.play_one_game
                expect(game.winner).to eq @player2[0]
            end

        end

    end

end

