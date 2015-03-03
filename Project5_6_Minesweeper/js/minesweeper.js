// 'use strict';

$(function(){

  Game.set();

  $('#start_game').on('click', function(){
    Game.set();
  });

  $('#stop_timer').click(function(){
    Game.stopTimer();
  });

});

var Game = {

  timer: null,

  set: function(){
    this.over = false;
    this.stopTimer();
    this.timer = Game.setTimer();

    var cols = $("input#cols").val();
    var rows = $("input#rows").val();
    var bombs = $("input#bombs").val();

    GridPreparer.setup(cols,rows);
    var board = new Board(rows,cols,bombs);

    $('div.grid').on('click', function(e){
      if(!this.over){
        Game.start($(this), board);
      }
    });
  },

  start: function($element, board){
    var at_x = parseInt($element.attr("row"));
    var at_y = parseInt($element.attr("col"));
    var cell = board.isValidCell(at_x,at_y);

    if (cell.mine){
      this.win(false);
    }else{
      board.openCells(at_x, at_y);
    }
    board.drawMap(board.board);
  },

  win: function(result){
    if(!result){
      $('.alert').text("Boo, you lost!").addClass('alert-danger').removeClass('alert-info');
    }else{
      $('.alert').text("Yay, you won!").addClass('alert-success').removeClass('alert-danger');
    }
    $('.bomb').each(function(){
      $(this).addClass('open');
    });

    this.over = true;
    this.stopTimer();
  },

  setTimer: function(){
    var seconds = 0;
    return setInterval(function(){
      $('#counter').html(++seconds%60);
    }, 2000);
  },

  stopTimer: function(){
    if(this.timer){
      clearInterval(this.timer);
      this.timer = null;
    }
  }
}
