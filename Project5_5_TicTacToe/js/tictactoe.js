$(function(){

    function Board(){
        this.results = [];

        this.initiateBoard = function(){
            for (var i = 0; i < 3; i++){
                this.results[i] = [];
                for (var j = 0; j < 3; j++){
                    var id = i * 3 + j + 1;
                    this.results[i][j] = 0;
                    $divgrid = $('div').find("[id="+id+"]");
                    $divgrid.attr("col", j );
                    $divgrid.attr("row", i );
                }
            }
        }

        this.updateCell = function(player,row,col){
            if (this.results[row][col] != 0){
                alert("The cell is occupied!");
            }else{
                this.results[row][col] = player;
                $divgrid = $("div").find("[row="+row+"]"+"[col="+col+"]");
                $divgrid.text(this.drawMark(player));
                $divgrid.parent().addClass("opened flip");
            }
        }

        this.drawMark = function(player){
            return player == 1 ? 'X' : 'O'
        }

        this.currentPlayer = function(){
            var turn_count = 0;
            for (var i = 0; i < 3; i++){
                for (var j = 0; j < 3; j++){
                    turn_count += this.results[i][j];
                }
            }
            return turn_count % 3 == 0 ? 1 : -1
        }

        this.turnsLeft = function(){
            var turns_left = 9;
            for (var i = 0; i < 3; i++){
                for (var j = 0; j < 3; j++){
                    if (this.results[i][j] != 0){
                        turns_left -= 1;
                    }
                }
            }
            return turns_left;
        }

        this.playGame = function(current_player,row,col){
            if (this.determineWinner() === undefined){
                this.updateCell(current_player, row, col);
            }
            this.gameOver();
        }

        this.gameOver = function(){
            var that = this;
            if (this.determineWinner() !== undefined){
                setTimeout(function(){ alert("The winner is " + that.drawMark(that.determineWinner())) }, 100);
            }
            if (this.turnsLeft() == 0){
                alert("Sorry, no more turns!");
            }
        }

        this.determineWinner = function(){
            if (this.checkRows() !== undefined){
                return this.checkRows();
            }
            if (this.checkCols() !== undefined){
                return this.checkCols();
            }
            if (this.checkDiagonals() !== undefined){
                return this.checkDiagonals();
            }
        }

        this.checkRows = function(){
            for (var i = 0; i < 3; i++){
                var sum = this.results[i][0] + this.results[i][1] + this.results[i][2];
                if (sum === 3 || sum === -3){
                    return this.results[i][0];
                }
            }
        }

        this.checkCols = function(){
            for (var i = 0; i < 3; i++){
                var sum = this.results[0][i] + this.results[1][i] + this.results[2][i];
                if (sum === 3 || sum === -3){
                    return this.results[0][i];
                }
            }
        }

        this.checkDiagonals = function(){
            for (var i = 0; i < 1; i++){
                 var sum = this.results[i][i] + this.results[i+1][i+1] + this.results[i+2][i+2];
                 if (sum === 3 || sum === -3){
                    return this.results[1][1];
                 }
            }
            for (var i = 1; i > 0; i--){
                 var sum = this.results[i][i] + this.results[i+1][i-1] + this.results[i-1][i+1];
                 if (sum === 3 || sum === -3){
                     return this.results[1][1];
                 }
            }
        }
    };

    var b = new Board();
    b.initiateBoard();

    $('.box').click(function(){
        var cols = $(this).children().attr("col");
        var rows = $(this).children().attr("row");
        var current_player = b.currentPlayer();
        b.playGame(current_player,rows,cols);
    });

    $('#button_wrapper').click(function(){
        location.reload();
    });

});
