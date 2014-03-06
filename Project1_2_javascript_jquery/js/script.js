/*

The dalek project was inspired by http://cronodon.com/Programming/c64_programming.html,
and the image is mimicked after http://cronodon.com/images/dalek_sprite_1a.jpg


Note: current version does not account for grid boundaries when the dalek image is being moved around.
This means that if the dalek image (or its portions) goes behind the boundaries, it will be erased partially or completely.
The reason is that it is not a real image but a sequence of cells being repainted at each iteration.

Additional note: the 'hover' function is disabled when the complete dalek has been drawn, but if the drawing is
incomeplete, or becomes partially erased after having been moved behind the boundary, it becomes enabled again,
which may result in accidental painting over the existing dalek.

These issues will be addressed and fixed in the future.

*/


$(document).ready(function()
{
    // initiate a dialog function

    $(function(){
        $('#dialog').dialog({
            autoOpen: false,
            width: 500,
            show: {
                effect: "blind",
                duration: 500
            },
            hide: {
                effect: "explode",
                duration: 500
            }

        });
    });


    $("#add_left").click(function(){

        $(".grid").remove();

        var count = prompt("Please select how many grids to display, but \n (for better display purposes) no more than 64!");
        var dimensions = (960 - count*2) / count;

        for(var i = 1; i <= count * count; i++){
            createDivs(dimensions,i);
        }

        $('.grid').mouseenter(function(){
            $(this).css("background-color", generateRandomRGB());
            $(this).fadeTo(500,0);

        });

        $('.grid').mouseleave(function(){
            $(this).fadeTo(500,1);
        });

    }); // end of #add_left button



    $("#add_right").click(function()
    {
        $(".grid").remove();

        $('#dialog').dialog("open");

        // once the dialog closes, perform drawing

        $( "#dialog").on( "dialogclose", function( event, ui )
        {
            var count = setCount();

            // calculate the size of the cell based on the number of grids to be displayed
            // and create the necessary number of divs

            var dimensions = (960 - count * 2) / count;

            for (var i = 0; i < count; i++){
                for (var g = 0; g < count; g++){
                    createDivs(dimensions, i, g);
                }
            }

            // read in dalek data from the file

            var daleks = readDalekData();

            // start of the hover function

            $('.grid').mouseenter(function()
            {
                if($('.colored').length <= 327){
                // extract col and row value from the div matrix
                // and compare to col and row value of the dalek matrix
                // if equal, update the div matrix accordingly and assign each div a color code

                    var cols = $(this).data("value").col;
                    var rows = $(this).data("value").row;

                    var data1 = daleks[cols][rows];

                    $(this).data("value", { colour: data1, col: cols, row: rows });

                    // color each div based on its color value

                    colorDalek($(this));

                }

            }); // end of hover

        }); // end of close dialog event

    }); // end of add_right click event


    $(document).keydown(function(key)
    {
        var count = setCount();

        done = true;

        switch(parseInt(key.which,10)) {
            // Left arrow key pressed
            case 37:

                var previous = getPreviousDalekLocation(count);
                var goingLeft = setMatrixForMovingUpOrLeft(previous,count,0,1);
                recolorMovingDalek(goingLeft,count,0,1);

                break;
            // Up Arrow Pressed
            case 38:
                var previous = getPreviousDalekLocation(count);
                var goingUp = setMatrixForMovingUpOrLeft(previous,count,1,0);
                recolorMovingDalek(goingUp,count,1,0);

                break;
            // Right Arrow Pressed
            case 39:

                var previous = getPreviousDalekLocation(count);
                var goingRight = setMatrixForMovingDownOrRight(previous,count,0,1);
                recolorMovingDalek(goingRight,count,0,1);

                break;
            // Down Arrow Pressed
            case 40:

                var previous = getPreviousDalekLocation(count);
                var goingDown = setMatrixForMovingDownOrRight(previous,count,1,0);
                recolorMovingDalek(goingDown,count,1,0);

                break;
        }

    }); // end of document of keydown function

});


function setCount(){
    return 50;
}

function getPreviousDalekLocation(count){

    // construct a new, empty matrix for divs
    var newArr = [];

    for (var x = 0; x < count; x++){
        newArr[x] = [];

        for (var y = 0; y < count; y++){
            newArr[x][y] = 0;
        }
    }

    // read each div's color into the new matrix that was defined above
    // this way, we know the previous "location" of each color based on col, row in a matrix
    $('div.grid').each(function(index,element)
    {
        var cols = $(element).data("value").col;
        var rows = $(element).data("value").row;
        var colors = $(element).data("value").colour;

        newArr[cols][rows] = colors;

    });

    return newArr;
}

function setMatrixForMovingDownOrRight(newArr,count,x,y){

    var arr = [];

    for (var z = 0; z < count; z++){
        arr[z+x] = [];

        for(var t = 0; t < count; t++){
            arr[z+x][t+y] = newArr[z][t];
        }
    }

    return arr;
}

function setMatrixForMovingUpOrLeft(newArr,count,x,y){

    var arr = [];

    for (var z = 0; z < count; z++){
        arr[z-x] = [];

        for(var t = 0; t < count; t++){
            arr[z-x][t-y] = newArr[z][t];
        }
    }
    return arr;
}

function recolorMovingDalek(arr,count,x,y){

    // remove class .colored and repaint the background

    $('.grid').removeClass('colored');

    // reassign row, col and color value to the div matrix based on the
    // updated location of a dalek cell

    $('.grid').each(function(index,element)
    {
        $(this).removeClass('colored');
        var cols = $(element).data("value").col;
        var rows = $(element).data("value").row;
        var colors = $(element).data("value").colour;
        $(element).data("value", { colour: 0, col: 0, row: 0 });

        for (var j = x; j < count - x; j++){
            for (var c = y; c < count - y; c++)
            {
                var data1 = arr[j][c];
                if (j === cols & c === rows)
                {
                    $(element).data("value", { colour: data1, col: j, row: c });
                }
            }
        }
        colorDalek($(element));
    });
}

function colorDalek($e){

    if ($e.data("value").colour === 1){
        $e.css("background-color", "#000000");
        $e.addClass("colored");
    }
    else if ($e.data("value").colour === 2){
        $e.css("background-color", "#FF9C00");
        $e.addClass("colored");
    }
    else if ($e.data("value").colour === 3){
        //$e.css("background-color", "#F8F8F8");
        $e.css("background-color", "");
    }else if ($e.data("value").colour === 4){
        $e.effect("pulsate");
        $e.css("background-color", "");
    }
    else {
        //$e.css("background-color", "#F8F8F8");
        $e.css("background-color", "");
    }

}

function createDivs(size,i,j){

    d = document.createElement('div');
    $(d).addClass("grid");
    $divgrid = $(d);
    $divgrid.css("border", "1px dotted grey");
    $divgrid.css("display","inline-block");
    $divgrid.css("float","left");

    var h = size.toString() + 'px';
    $divgrid.height(h);
    $divgrid.width(h);
    $divgrid.data("value", { colour: 0, col: i, row: j } ); //adding a value field to all div grid elements

    $('.wrapper').append($divgrid);
}

function generateRandomRGB(){
    // generate random colors in green shades

    var r = 1;//Math.floor(Math.random() * 255) + 1;
    var g = Math.floor(Math.random() * 75) + 1;
    var b = 1;//Math.floor(Math.random() * 255) + 1;

    return "rgb("+r.toString()+ "," + g.toString() + "," + b.toString() + ")"

}
