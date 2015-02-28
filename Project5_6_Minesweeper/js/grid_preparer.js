function GridPreparer(rows,cols){

  this.rows = rows;
  this.cols = cols;

  $('.box').css('width', this.cols*20);
  $('.box').css('height', this.rows*20);

  $('.outer-wrapper').css('width', this.cols*20 + $('.left').width() + 30);
  $('.outer-wrapper').css('height', this.rows*20 + 50);

  this.prepareGrid = function(){
    $(".grid").remove();
    $('.cell').remove();

    for (var i = 0; i < rows; i++){
      for (var j = 0; j < cols; j++){
        this.createCells(i, j);
        this.createCellLabels(i,j);
      }
    }
  }

  this.createCells = function(i,j){
    d = document.createElement('div');
    $(d).addClass("grid");
    $(d).data("value", { row: i, col: j } );
    $(d).attr("id", i*this.rows+j+1);
    $(d).attr("col", j );
    $(d).attr("row", i );
    $(d).css("left", parseInt(j * 20, 10) + "px");
    $(d).css("top", parseInt(i * 20, 10) + "px");
    $(d).appendTo($('.box'));
  }

  this.createCellLabels = function(i,j){
    d = document.createElement('div');
    $(d).addClass("cell");
    $(d).css("left", parseInt(j * 20, 10) + "px");
    $(d).css("top", parseInt(i * 20, 10) + "px");
    $(d).attr("col", j );
    $(d).attr("row", i );
    $(d).appendTo($('.box'));
  }

}
