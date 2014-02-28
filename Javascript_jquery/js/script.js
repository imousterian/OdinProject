//var dims = new Array();
$(document).ready(function()
{
    //$('button').click(function() {
    //   var toAdd = $("input[name=message]").val();
    //    $('#messages').append("<p>"+toAdd+"</p>");
    //});

    // Event binding using a convenience method

    $( "#add" ).click(function( event )
    {
        //location.reload(false);
        //$(document).removeClass(".grid");


        var input = prompt("Please select how many grids to display, \n but no more than 64!");
        $head = $(".header");
        var count = input;//test();
        var dimensions = (960 - count*2) / count;



        for(var i = 0; i < count * count; i++)
        {
           // $grd = createDivs(dimensions);
            //$grd.css("background-color", "red");
            //$dims[i] =
            createDivs(dimensions,i);
        }

        $('.grid').hover(function()
        {

            for(var j = 0; j < count * count; j++)
            {
                var my = "d"+j.toString();
                if($(this).attr('id') === my){
                    var v = "#"+my;
                    //$(v).css("background-color", "blue");
                    $(v).css("background-color", generateRandomRGB());
                    //$(this).fadeOut('slow');
                    //$(this).fadeToggle(1000);
                }

                //$(this).attr('id').hover(function()
                //{
                    //$(this).text($(this).attr('id')).css("background-color", "blue");

                    //$(this.id).css("background-color", "blue");


                //});


            }

        });





    });

       $('#1').hover(function(){
    //     for (var i = 0; i < dims.length, i++){
    //         $d = dims[i];
             $('#1').css("background-color", "blue");
    //     }

     });





});

function test(){
    var count = 8; // or an input from the form
    return count;
}

function generateRandomRGB(){
    var r = Math.floor(Math.random() * 255) + 1;
    var g = Math.floor(Math.random() * 255) + 1;
    var b = Math.floor(Math.random() * 255) + 1;

    return "rgb("+r.toString()+ "," + g.toString() + "," + b.toString() + ")"

}

function createDivs(size,ids){

    d = document.createElement('div');
    $(d).addClass("grid");
    //$(d).attr("id",id.toString());
    $divgrid = $(d);
    var idToString = "d"+ids.toString();
    $divgrid.attr("id",idToString);

    $('.wrapper').append($divgrid);

    $divgrid.css("background-color","purple");
    $divgrid.css("border", "1px dotted white");
    $divgrid.css("display","inline-block");
    $divgrid.css("float","left");

    var h = size.toString() + 'px';
    //$divgrid.css("height", h);
    $divgrid.height(h);
    $divgrid.width(h);

    //return $divgrid;

    //return $divgrid;
}












