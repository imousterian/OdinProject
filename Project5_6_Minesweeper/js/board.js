function Board(rows,cols, bombs){
  this.board = [];
  this.mineCollection = [];
  this.cols = cols;
  this.rows = rows;
  this.stack = [];
  this.bombs = bombs;

  for (var i = 0; i < this.rows; i++){
    this.mineCollection[i] = [];
  }

  this.createMines();

  for(var i = 0; i < this.rows; i++){
    this.board[i] = [];
    for(var j = 0; j < this.cols; j++){
      var mine = this.mineCollection[i][j];
      mine ? mine = true : mine = 0;
      var cell = new Cell(i,j,mine);
      this.board[i][j] = cell;
    }
  }

  for(var i = 0; i < this.rows; i++){
    for(var j = 0; j < this.cols; j++){
      var cell = this.isValidCell(i,j);
      cell.setNeighbors(this);
    }
  }
}

Board.prototype.createMines = function(){
  for (var i = 0; i < this.bombs; i++){
    this.generateMine();
  }
}

Board.prototype.generateMine = function(){
  var x = Math.floor(Math.random() * (this.rows));
  var y = Math.floor(Math.random() * (this.cols));
  if (this.mineCollection[x][y]){
    return this.generateMine();
  }
  this.mineCollection[x][y] = true;
  $("div.cell"+"[row="+x+"]"+"[col="+y+"]").addClass('bomb').append('<img src="images/mine.png"/>');
}

Board.prototype.isValidCell = function(x,y){
  if (x >= 0 && x < this.rows && y >= 0 && y < this.cols ){
    return this.board[x][y];
  }
}

Board.prototype.floodFill = function(mapData, x, y, oldVal, newVal){
  var mapWidth = mapData.length;
  var mapHeight = mapData[0].length;

  if(oldVal == null){
    oldVal=mapData[x][y].neighborsWithMines;
  }

  if(mapData[x][y].neighborsWithMines !== oldVal){
    return true;
  }

  this.stack.push(mapData[x][y]);
  mapData[x][y].neighborsWithMines = newVal;
  mapData[x][y].revealed = 1;

  if (x > 0){ // left
    this.floodFill(mapData, x-1, y, oldVal, newVal);
  }
  if(y > 0){ // up
    this.floodFill(mapData, x, y-1, oldVal, newVal);
  }
  if(x < mapWidth-1){ // right
    this.floodFill(mapData, x+1, y, oldVal, newVal);
  }
  if(y < mapHeight-1){ // down
    this.floodFill(mapData, x, y+1, oldVal, newVal);
  }
}

Board.prototype.proceed = function(){
  var total = parseInt(this.bombs);
  for(var i = 0; i < this.rows; i++){
    for(var j = 0; j < this.cols; j++){
      var cell = this.isValidCell(i,j);
      total += cell.revealed;
    }
  }

  if (total === this.rows * this.cols){
    Game.win(true);
  }
}

Board.prototype.openCells = function(x,y){
  this.stack = [];
  var cell = this.isValidCell(x,y);

  if (cell.neighborsWithMines == 0){
    this.floodFill(this.board,x,y,null,-1);
  }

  if (cell.neighborsWithMines > 0){
    cell.revealed = 1;
  }

  for(var i = 0; i < this.stack.length; i++){
    var cell = this.stack[i];
    for (var j = 0; j < cell.neighbors.length; j++){
      cell.neighbors[j].revealed = 1;
    }
  }

  this.proceed();
}

Board.prototype.drawMap = function (mapData){

  $('div.grid').each(function(index,obj){

    var x = parseInt($(this).attr("row"));
    var y = parseInt($(this).attr("col"));
    var cell = mapData[x][y];

    if(cell.neighborsWithMines > 0 && cell.revealed == 1 && cell.mine == 0){
      $(this).text(cell.neighborsWithMines);
      if ($(this).text() == '1'){
        $(this).addClass('one colored');
      }else if($(this).text() == '2'){
        $(this).addClass('two colored');
      }else if($(this).text() == '3'){
        $(this).addClass('three colored');
      }else{
        $(this).addClass('four colored');
      }
    }
    if (cell.revealed == 1 && cell.mine == 0){
      $("div.cell"+"[row="+x+"]"+"[col="+y+"]").addClass('open');
    }
  });
}

