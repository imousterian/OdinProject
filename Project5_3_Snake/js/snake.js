
$(function(){

    prepareGrid();

    $('#submitter').click(function(){
        initiateGame();
    });
});

function prepareGrid(){
    $(".grid").remove();
    $("#points").text(0);
    for (var i = 0; i < 30; i++){
        for (var g = 0; g < 40; g++){
            createDivs(18, i, g);
        }
    }
}

function createDivs(size,i,j){
    d = document.createElement('div');
    $(d).addClass("grid");
    $divgrid = $(d);
    var h = size.toString() + 'px';
    $divgrid.height(h);
    $divgrid.width(h);
    $divgrid.data("value", { row: i, col: j } );
    $divgrid.attr("col", j );
    $divgrid.attr("row", i );
    $('.wrapper').append($divgrid);
}

function initiateGame(){
    prepareGrid();
    snake = new Snake(20,20);
    $("div").find("[row="+snake.xx+"]"+"[col="+snake.yy+"]").addClass('snake');
    generateFood();
    runGame();
}

function Food(){
    this.xx = Math.floor(Math.random() * 29);
    this.yy = Math.floor(Math.random() * 39);
}

function generateFood(){
    $('div.food > img').remove();
    $("div").removeClass('food');
    food = new Food();
    $("div").find("[row="+food.xx+"]"+"[col="+food.yy+"]")
            .addClass('food').prepend('<img src="images/star.gif"/>');
}

function runGame(){
    var snake_head = [snake.xx, snake.yy];
    var snake_tail = snake.sbody.pop();
    var new_coords = snake.changeDirection(snake_head);

    snake.eatFood();
    snake.moveToXY(new_coords[0], new_coords[1]);

    if (new_coords[0] < 0 || new_coords[0] > 29 || new_coords[1] < 0 || new_coords[1] > 39 || snake.collision())
    {
        alert("Kaboom! You just crashed into a wall or\n\nYOURSELF. Eek. \n\nGame over!");
        location.reload();
        return;
    }

    repaintSnakeHead(new_coords[0], new_coords[1]);
    repaintSnakeBody(snake_tail);
    setTimeout(function(){ runGame() }, 50);
}

function Snake(xx,yy){
    this.xx = xx;
    this.yy = yy;
    this.sbody = [];
    this.direction = "up";
    this.sbody.push([this.xx, this.yy]);
}

Snake.prototype.changeDirection = function(snake_head){
    switch(this.direction){
        case 'up':
            var new_x = snake_head[0] - 1;
            var new_y = snake_head[1];
            break;
        case 'down':
            var new_x = snake_head[0] + 1;
            var new_y = snake_head[1];
            break;
        case 'right':
            var new_x = snake_head[0];
            var new_y = snake_head[1] + 1;
            break;
        case 'left':
            var new_x = snake_head[0];
            var new_y = snake_head[1] - 1;
            break;
    }
    return [new_x, new_y];
}

Snake.prototype.collision = function () {
    for(var i = 1; i < this.sbody.length; i++){
        if (this.xx === this.sbody[i][0] && this.yy === this.sbody[i][1]){
            return true;
        }
    }
    return false;
};

Snake.prototype.eatFood = function(){
    if (food.xx === this.xx && food.yy === this.yy){
        this.sbody.unshift([food.xx, food.yy]);
        $("#points").text(Number($("#points").text())+1);
        generateFood();
    }
}

Snake.prototype.moveToXY = function(xx,yy){
    this.xx = xx;
    this.yy = yy;
    this.sbody.unshift([this.xx,this.yy]);
}

function repaintSnakeHead(new_x, new_y){
    switch(snake.direction){
        case 'up':
            $("div").find("[row="+new_x+"]"+"[col="+new_y+"]").addClass('snake head_up');
            break;
        case 'down':
            $("div").find("[row="+new_x+"]"+"[col="+new_y+"]").addClass('snake head_down');
            break;
        case 'right':
            $("div").find("[row="+new_x+"]"+"[col="+new_y+"]").addClass('snake head_right');
            break;
        case 'left':
            $("div").find("[row="+new_x+"]"+"[col="+new_y+"]").addClass('snake head_left');
            break;
    }
}

function repaintSnakeBody(snake_tail){
    $('div.snake').each(function()
    {
        var cols = $(this).data("value").col;
        var rows = $(this).data("value").row;

        if (snake.xx === rows && snake.yy === cols){
            // do nothing
        }else{
            $(this).removeClass('head_up head_left head_right head_down');
            $(this).addClass('body_piece');
        }
    });

    $("div").find("[row="+snake_tail[0]+"]"+"[col="+snake_tail[1]+"]").removeClass('snake body_piece head_up head_left head_right head_down');
}

$(document).bind("keydown", function(key)
{
    switch(parseInt(key.which,10))
    {
            // Left arrow key pressed
        case 37:
            snake.direction = 'left';
            break;
            // Up Arrow Pressed
        case 38:
            snake.direction = 'up';
            break;
            // Right Arrow Pressed
        case 39:
            snake.direction = 'right';
            break;
            // Down Arrow Pressed
        case 40:
            snake.direction = 'down';
            break;
    }

});
