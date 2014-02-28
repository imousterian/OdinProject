
$(document).ready(function()
{

    $("#add").click(function(){

        $(".grid").remove();

        var count = prompt("Please select how many grids to display, \n but no more than 64!");
        var dimensions = (960 - count*2) / count;

        for(var i = 0; i < count * count; i++){
            createDivs(dimensions);
        }

        $('.grid').hover(function(){
            $(this).css("background-color", generateRandomRGB());
        });

    });

});

function display()
{
        var input = prompt("Please select how many grids to display, \n but no more than 64!");
        $head = $(".header");
        var count = input;
        var dimensions = (960 - count*2) / count;

        for(var i = 0; i < count * count; i++)
        {
            createDivs(dimensions);
        }

        $('.grid').hover(function()
        {
            //$(this).css("background-color", generateRandomRGB());

            for(var j = 0; j < count * count; j++)
            {
                var my = "d"+j.toString();
                if($(this).attr('id') === my)
                {
                    var v = "#"+my;
                //    $(v).css("background-color", generateRandomRGB());
                    //$(this).fadeOut('slow');
                    //$(this).fadeToggle(800);
                    //$(v).css("background-color", "black");
                }
            }

        });
}


function generateRandomRGB(){
    var r = Math.floor(Math.random() * 255) + 1;
    var g = Math.floor(Math.random() * 255) + 1;
    var b = Math.floor(Math.random() * 255) + 1;

    return "rgb("+r.toString()+ "," + g.toString() + "," + b.toString() + ")"

}

function createDivs(size){

    d = document.createElement('div');
    $(d).addClass("grid");
    $divgrid = $(d);
    $divgrid.css("background-color","black");
    $divgrid.css("border", "1px dotted white");
    $divgrid.css("display","inline-block");
    $divgrid.css("float","left");

    var h = size.toString() + 'px';
    $divgrid.height(h);
    $divgrid.width(h);

    $('.wrapper').append($divgrid);
}












