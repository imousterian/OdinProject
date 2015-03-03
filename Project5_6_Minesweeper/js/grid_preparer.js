var GridPreparer = {

  setup: function(cols,rows){

    $('#counter').html('0');

    $('.box').css('width', cols*20);
    $('.box').css('height', rows*20);

    $('.outer-wrapper').css('width', cols*20 + $('.left').width() + 30);
    $('.outer-wrapper').css('height', rows*20 + 50);

    $('.alert').css('width', cols*20 + $('.left').width() + 30);

    $('.grid').remove();
    $('.cell').remove();
    $('.alert').removeClass('alert-danger').removeClass('alert-success').html('');


    for (var i = 0; i < rows; i++){
      for (var j = 0; j < cols; j++){
        var $grid = $('<div>');
        $grid.attr("id", i*rows+j+1);
        $grid.addClass("grid");
        this.addCells(i,j,$grid);

        var $cell = $('<div>');
        $cell.addClass("cell");
        this.addCells(i,j,$cell);
      }
    }
  },

  addCells: function(i,j, $d){
    $d.css("left", parseInt(j * 20, 10) + "px");
    $d.css("top", parseInt(i * 20, 10) + "px");
    $d.attr("col", j );
    $d.attr("row", i );
    $d.appendTo($('.box'));
  }
}
