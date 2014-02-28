

$(document).ready(function()
{
    //$('button').click(function() {
    //   var toAdd = $("input[name=message]").val();
    //    $('#messages').append("<p>"+toAdd+"</p>");
    //});

    // Event binding using a convenience method
    $( "#add" ).click(function( event ) {
        alert( "Hello." );
    });

    $head = $(".header");
    var count = test();
    var dimensions = (960 - count*2) / count;

    for(var i = 0; i < count * count; i++)
    {
        createDivs(dimensions);
    }

});

function test(){
    var count = 8; // or an input from the form
    return count;
}

function createDivs(size){
    d=document.createElement('div');
    $divgrid = $(d);
    $('.wrapper').append($divgrid);

    $divgrid.css("background-color","purple");
    $divgrid.css("border", "1px dotted white");
    $divgrid.css("display","inline-block");
    $divgrid.css("float","left");

    var h = size.toString() + 'px';
    //$divgrid.css("height", h);
    $divgrid.height(h);
    $divgrid.width(h);


}












