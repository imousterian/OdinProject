require './lib/game'
require './lib/piece'

describe "Board" do

    let(:board) { Board.new }

    describe "#new" do

        it "returns a new Board object" do
            expect(board).to be_an_instance_of Board
        end

        it "returns" do
            board.board[4][7] = Queen.new(:black,4,7)
            board.piece_collection << Queen.new(:black,4,7)
            board.board[7][4] = King.new(:white,7,4)
            board.piece_collection << King.new(:white,7,4)
            expect(board.check_for_check(board.board[7][4])).to be_truthy
        end
    end

end

describe "Game" do

end

