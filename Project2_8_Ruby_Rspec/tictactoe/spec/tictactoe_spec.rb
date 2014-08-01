require './lib/tictactoe'

describe 'TicTactoe game' do

    let(:tictactoe) { Game.new }

    before :each do
        @player1 = Player.new('X', 1)
        @player2 = Player.new('O', 2)
        @board = Board.new
    end

    describe "Player" do

        context "#new" do

            it "returns a new player 1 object" do
                expect(@player1).to be_an_instance_of Player
            end

            it "returns a new player 2 object" do
                expect(@player2).to be_an_instance_of Player
            end

        end

        context "#describe" do
            it "returns a correct description for Player 1" do
                expect(@player1.description).to eql "Player 1: "
            end

            it "returns a correct description for Player 2" do
                expect(@player2.description).to eql "Player 2: "
            end
        end

    end

    describe "Board" do

        context "#new" do
            it "returns a new board object" do
                expect(@board).to be_an_instance_of Board
            end
        end

        context "#initialize" do
            it "returns an array filled with nil values" do
                expect(@board.matrix).to eql [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]]
            end
        end

        context "#board location availability" do

            before :each do
                @board.matrix = [['X','X',nil],['X',nil,nil],['X',nil,nil]]
            end

            it "calculates a location correctly" do
                expect(@board.get_new_location(3)).to eql [0,2]
            end

            it "returns nil if location is not marked as nil" do
                expect(@board.location_available?(2)).to eql nil
            end

            it "returns true if location is marked as nil" do
                expect(@board.location_available?(3)).to eql true
            end

            it "returns correctly recorded mark for a location" do
                expect(@board.record_mark(2,'X')).to eql 'X'
            end
        end

        context "#board recording accuracy of results" do
            before :each do
                @board.matrix = [['X',nil,'X'],[nil,'X','X'],['X','X','X']]
            end

            it "returns true if elements are correctly counted across rows" do
                expect(@board.check_rows('X')).to be_truthy
            end

            it "returns true if elements are correctly counted across cols" do
                expect(@board.check_cols('X')).to be_truthy
            end

            it "returns true if elements are correctly counted across diagonal1" do
                expect(@board.check_diagonal1('X')).to be_truthy
            end

            it "returns true if elements are correctly counted across diagonal2" do
                expect(@board.check_diagonal2('X')).to be_truthy
            end

            it "returns true if board still has nil elements" do
                expect(@board.board_empty?).to be_truthy
            end
        end

    end

end

















