

$(document).ready(function()
{
    //$('button').click(function() {
    //    var toAdd = $("input[name=message]").val();
    //    $('#messages').append("<p>"+toAdd+"</p>");
    //});

    $head = $(".header");
    var count = test();

    d=document.createElement('div');
    $divgrid = $(d);
    $('.wrapper').append($divgrid);
    $divgrid.height('50px');
    $divgrid.width('478px');
    $divgrid.css("background-color","black");
    $divgrid.css("border", "1px solid white");
    $divgrid.css("display","inline-block");
    $divgrid.css("float","left");


    d=document.createElement('div');
    $divgrid = $(d);
    $('.wrapper').append($divgrid);
    $divgrid.height('50px');
    $divgrid.width('478px');
    $divgrid.css("background-color","purple");
    $divgrid.css("border", "1px solid white");
    $divgrid.css("display","inline-block");
    $divgrid.css("float","left");


    d=document.createElement('div');
    $divgrid = $(d);
    $('.wrapper').append($divgrid);
    $divgrid.height('50px');
    $divgrid.width('478px');
    $divgrid.css("background-color","purple");
    $divgrid.css("border", "1px solid white");
    $divgrid.css("display","inline-block");
    $divgrid.css("float","left");




    //$('.wrapper').append("<p>" + count + " I'm a paragraph!</p>")


});

function test(){
    var count = 16; // or an input from the form
    return count;
}