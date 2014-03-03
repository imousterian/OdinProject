$(document).ready(function(){

    $("#add_right").click(function()
    {

        $(".grid").remove();
        var count = 60;
        var dimensions = (960 - count*2) / count;

        for (var i = 0; i < count; i++){
            for (var g = 0; g < count; g++){
                createDivs(dimensions, i, g);
            }
        }

        var daleks1 = dalekData();

        var daleks = [];

        for (var b = 0; b < count; b++){
            daleks[b] = [];
            for(var bb = 0; bb < count; bb++){
                daleks[b][bb] = 0;
                if (b < 25 & bb < 24){
                    daleks[b][bb] = daleks1[b][bb];

                }

            }
        }

        for (var b1 = 0; b1 < count; b1++){
         //   console.log(daleks[b1]);
        }



        $('.grid').hover(function()
        {

            var cols = $(this).data("value").col;
            var rows = $(this).data("value").row;
            //console.log(cols + " " + rows);

            for (var j = 0; j < count; j++){ //25
                for (var c = 0; c < count; c++){ //24

                    var data1 = daleks[j][c];

                    if (j === cols & c === rows){
                        //$(this).addClass("colored");
                        $(this).data("value", { colour: data1, col: j, row: c });
                    }
                }
            }

            colorDalek($(this));

            var data = $('.colored').length;
            //console.log(data);

            $(this).show(function(){
              //  shoot( $(this), data);
            });

        }); // end of hover

        }); // end of add_right click event




    //$("#test").click(function()
        $(document).keyup(function()
    {
        // return array of current dalek locations
           //var obj = $('.colored');
           //var arr = $.makeArray(obj);
           //console.log(arr);
           var count = 60;

           var newArr = [];

           //var testArr = [];

           for (var x = 0; x < count; x++){
                newArr[x] = [];

                for (var y = 0; y < count; y++){
                        //console.log(colors);
                    newArr[x][y] = 0;
                        //console.log(colors);
                    }
            }

           //console.log($('div.grid').length);

           $('div.grid').each(function(index,element)
           {
                var cols = $(element).data("value").col;
                var rows = $(element).data("value").row;
                var colors = $(element).data("value").colour;

                //console.log(cols + " " + rows + " " + colors);

                //colorDalek($(this));
                newArr[cols][rows] = colors;

           });

           var extra = [];
           for (var z = 0; z < count; z++){
                extra[z+1] = [];
                for(var t = 0; t < count; t++){
                    extra[z+1][t] = newArr[z][t];

                }
           }


           //console.log($('.colored').length);

           $('.grid').removeClass('colored');
           $('.grid').css("background-color", "");
           //$('grid').data("value", { colour: 0});
           //$('.grid').css("background-color", "#F8F8F8");



           $('.grid').each(function(index,element)
           {
                var cols = $(element).data("value").col;
                var rows = $(element).data("value").row;
                var colors = $(element).data("value").colour;
                $(element).data("value", { colour: 0, col: 0, row: 0 });

                for (var j = 1; j < count; j++){

                    for (var c = 0; c < count; c++){

                    var data1 = extra[j][c];



                    if (j === cols & c === rows){
                        $(element).data("value", { colour: data1, col: j, row: c });
                        }
                    }

                }

            colorDalek($(element));

           });

           //console.log($('.colored').length);

        //


    }); // end of test click event


});

function colorDalek($e){
    if ($e.data("value").colour === 1){
        $e.css("background-color", "#000000");
        $e.addClass("colored");
    }
    else if ($e.data("value").colour === 2){
        $e.css("background-color", "#FF9C00");
        $e.addClass("colored");
    }else {
        //$e.css("background-color", "#F8F8F8");

    }

}

function returnBulletDivs(){
    var arr = [];
    for(var i = 386; i <= 390; i++){
        var id = "#d" + i;
        arr.push(id);
    }
    return arr;
}

function shoot($e, data)
{
    var arr = returnBulletDivs();

    if(data >= 356)
    {

        var count = 0;


        for (var i = 0; i < arr.length; i++)
        {
            if(i % 2 === 0){
                var those = arr[i];
                $(those).css("background-color", "red");
                $(those).effect("pulsate", {duration: 2000, complete: function() { shoot ($(those),data)}});

                $(those).fadeToggle({ duration: 1000, complete: function(){ shoot($(those), data) }});
            }else
            {
                var those = arr[i];
                $(those).css("background-color", "red");
                $(those).effect("pulsate", {duration: 4000, complete: function() { shoot ($(those),data)}});

                $(those).fadeToggle({ duration: 2000, complete: function(){ shoot($(those), data) }});
            }
        }
    }
}


function createDivs(size,i,j){

    d = document.createElement('div');
    $(d).addClass("grid");
    $divgrid = $(d);
    var g = "d" + i.toString();
    $divgrid.attr('id',g);
    $divgrid.css("border", "1px dotted grey");
    $divgrid.css("display","inline-block");
    $divgrid.css("float","left");

    var h = size.toString() + 'px';
    $divgrid.height(h);
    $divgrid.width(h);
    $divgrid.data("value", { colour: 0, col: i, row: j } ); //adding a value field to all div grid elements

    $('.wrapper').append($divgrid);
}
