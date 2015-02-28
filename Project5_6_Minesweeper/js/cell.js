function Cell(x,y,mine){
  this.x = x;
  this.y = y;
  this.mine = mine;
  this.neighbors = [];
  this.neighborsWithMines = 0;
  this.revealed = 0;
}

Cell.prototype.addNeighbor = function(neighbor){
  this.neighbors.push(neighbor);
  if (neighbor.mine ){
    this.neighborsWithMines += neighbor.mine;
  }
}

Cell.prototype.setNeighbors = function(board){

  var neighbor = board.isValidCell(this.x, this.y-1);

  if (neighbor){
    this.addNeighbor(neighbor);
  }

  neighbor = board.isValidCell(this.x-1, this.y-1);
  if (neighbor){
    this.addNeighbor(neighbor);
  }

  neighbor = board.isValidCell(this.x-1, this.y);
  if (neighbor){
    this.addNeighbor(neighbor);
  }

  neighbor = board.isValidCell(this.x-1, this.y+1);
  if (neighbor){
    this.addNeighbor(neighbor);
  }

  neighbor = board.isValidCell(this.x+1, this.y-1);
  if (neighbor){
    this.addNeighbor(neighbor);
  }

  neighbor = board.isValidCell(this.x+1, this.y+1);
  if (neighbor){
    this.addNeighbor(neighbor);
  }

  neighbor = board.isValidCell(this.x+1, this.y);
  if (neighbor){
    this.addNeighbor(neighbor);
  }

  neighbor = board.isValidCell(this.x, this.y+1);
  if (neighbor){
    this.addNeighbor(neighbor);
  }

}

