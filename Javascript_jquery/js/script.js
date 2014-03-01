
$(document).ready(function()
{

    $("#add_left").click(function(){

        $(".grid").remove();

        var count = prompt("Please select how many grids to display, \n but no more than 64!");
        var dimensions = (960 - count*2) / count;

        for(var i = 1; i <= count * count; i++){
            createDivs(dimensions,i);
        }

        $('.grid').hover(function(){
            //$(this).css("background-color", generateRandomRGB());
            $(this).text($(this).attr('id')).css("background-color", "red");

        });

    }); // end of #add_left butoon


    $("#add_right").click(function()
    {
        $(".grid").remove();
        var count = 30;
        var dimensions = (960 - count*2) / count;

        for(var i = 1; i <= count * count; i++){
            createDivs(dimensions,i);
        }

        var lineToBegin = 3*count+1;

        var arr = constructDalekArray(lineToBegin,count);

        var elements = 0;


        $('.grid').mouseenter(function()
        {
            //$(this).css("background-color", generateRandomRGB());
            $(this).text($(this).attr('id')).css("background-color", "#FCFCFC");

            for (var i = 0; i < arr.length; i++)
            {

                var my = "d" + arr[i].toString();
                //var myColor = $(this).css("background-color");
                var blockColor = "#FFCC00"

                if($(this).attr('id') === my)
                {
                    $(this).addClass("colored");
                    var v = "#"+my;
                    $(v).css("background-color", "#000080");

                    //console.log("done " + stuff);

                    var beep = 1;
                    //var initial = (count - 2) * 15;//420; start coloring the body at the end of line 14
                    var initial = count * 14; //start coloring the body at the end of line 14


                    while(beep <= 13)
                    {
                        //var x = beep + 30;
                        $(v).css("background-color", "#red");

                        if(beep % 2 != 0){ // odd line
                            initial = initial + count;
                            var d = initial + count;//*beep;
                            if(arr[i] >= initial & (arr[i] <= d))
                            {
                                //console.log(arr[i] + " " +d);
                                if(arr[i] % 2 != 0){
                                    $(v).css("background-color", blockColor);
                                }
                            }
                        }else{
                            initial = initial + count;
                            var d = initial + count;// * beep;
                            if(arr[i] >= initial & (arr[i] <= d))
                            {
                                //console.log(arr[i] + " " +d);
                                if(arr[i] % 2 === 0){
                                    $(v).css("background-color", blockColor);
                                }
                            }
                        }

                        beep += 1;

                    } /// end of while loop

                    // add color to lines 8 and 10
                     //if((arr[i] > 272 & arr[i] < 283) || (arr[i] >= 212 & arr[i] < 223))
                     // add color to line 8
                     if (count % 3 != 0){

                        if(arr[i] >= (count * 7) + 3 & arr[i] < (count * 7) + 2 + 10)
                        {

                            if (arr[i+1] % 3 != 0 )
                            {
                                $(v).css("background-color", "green");
                             //console.log("test");
                            }
                        }

                     }else{

                        if(arr[i] >= (count * 7) + 2 & arr[i] < (count * 7) + 2 + 10)
                        {

                            if (arr[i] % 3 != 0 )
                            {
                                $(v).css("background-color", "green");
                             //console.log("test");
                            }
                        }

                     }


                     // add color to line 10
                     if(arr[i] >= (count * 9) + 2 & arr[i] < (count * 9) + 2 + 10)
                     {
                         if (arr[i] % 3 != 0 )
                         {
                             $(v).css("background-color", "green");
                             //console.log("test");
                         }
                     }

                     if(arr[i] > 332 & arr[i] <=342){
                        if(arr[i] % 2 != 0){
                            //$(v).css("background-color", blockColor);
                        }

                     }

                     if(arr[i] >= 361 & arr[i] <=372){
                        if(arr[i] % 2 != 0){
                            $(v).css("background-color", blockColor);
                        }

                     }

                     if(arr[i] >= 391 & arr[i] <=402){
                        if(arr[i] % 2 != 0){
                            $(v).css("background-color", blockColor);
                        }

                     }

                }// end of if condition


            }  // end for for loop




                // var data = $('.colored').length;

                // $('.bullet').bind("main", function(event, data) {
                //     //alert(data);

                //     console.log(data);

                //     }); // end of test

                // $('.bullet').trigger("main", data);

        }); // end of hover

        var data = $('.colored').length;
            // console.log("bullets " + $('.bullet').length);
            if (data >= 6){ //356
                //console.log(data);
                for (var f = 386; f <= 390; f++) //386
                {

                    var my2 = "d" + f;//arr[f].toString();
                    //console.log(my2 + " " + f + " " + arr[f].toString());

                    if($(this).attr('id') === my2)
                    {
                        //$(this).addClass("colored");
                        var v2 = "#"+my2;
                        //console.log(v2 + " " + data);
                        $(v2).css("background-color", "red");
                        $(v2).effect("pulsate");
            //        // console.log(data);

                    }
                }
            }



        // $('.grid').mouseenter(function(){
        //     var data = $('.colored').length;
        //     if (data >= 6){ //356
        //             $('.bullet').css("background-color", "red");
        //             $('#bull').toggle("pulsate");
        //             //console.log(data);

        //     }

        //   //  console.log(data);
        // });



    }); // end of #add_right()


}); // end of document.ready()


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
            $(this).text($(this).attr('id')).css("background-color", "red");

            for(var j = 1; j <= count * count; j++)
            {
                var my = "d"+j.toString();
                if($(this).attr('id') === my)
                {
                    var v = "#"+my;
                    //if(j === 1){
                        $(v).css("background-color", generateRandomRGB());
                    //}
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

function createDivs(size,i){

    d = document.createElement('div');
    $(d).addClass("grid");
    $divgrid = $(d);
    var g = "d" + i.toString();
    $divgrid.attr('id',g);
    //$divgrid.css("background-color","grey");
    $divgrid.css("border", "1px dotted grey");
    $divgrid.css("display","inline-block");
    $divgrid.css("float","left");

    var h = size.toString() + 'px';
    $divgrid.height(h);
    $divgrid.width(h);

    $('.wrapper').append($divgrid);
}

function constructDalekArray(beginning,count){

    var whole = [];

    // line 1 ; length = 7, offset = 4
    var line1Dims = beginning + 4;
    var line1 = generateElements(line1Dims,line1Dims+5);

    // line 2 ; length = 14, offset = 3
    var line2Dims = beginning + count*1 + 3;
    var line2 = generateElements(line2Dims,line2Dims+13);

    //  line 3; length = 10, offset = 2;
    var line3Dims = beginning + count*2 + 2;
    var line3 = generateElements(line3Dims,line3Dims+8);

    //  line 4; length = 11, offset = 2;
    var line4Dims = beginning + count*3 + 2;
    var line4 = generateElements(line4Dims,line4Dims+9);

    // line 5 through 8 are the same length, length = 11, offset = 2;
    var line5Dims = beginning + count*4 + 2;
    var line5 = generateElements(line5Dims,line5Dims+9);

    var line6Dims = beginning + count*5 + 2;
    var line6 = generateElements(line6Dims,line6Dims+9);

    var line7Dims = beginning + count*6 + 2;
    var line7 = generateElements(line7Dims,line7Dims+9);

    var line8Dims = beginning + count*7 + 2;
    var line8 = generateElements(line8Dims,line8Dims+9);

    var line9Dims = beginning + count*8 + 1;
    var line9 = generateElements(line9Dims,line9Dims+11);

    // the longest
    var line10Dims = beginning + count*9 + 1;
    var line10 = generateElements(line10Dims,line10Dims+22);

    var plunger1Dims = beginning + count*8 + 23;
    var linePlunger1 = generateElements(plunger1Dims,plunger1Dims);

    var plunger2Dims = beginning + count*10 + 23;
    var linePlunger2 = generateElements(plunger2Dims,plunger2Dims);

    var line11Dims = beginning + count*10 + 1;
    var line11 = generateElements(line11Dims,line11Dims+15);

    var line12Dims = beginning + count*11 + 1;
    var line12 = generateElements(line12Dims,line12Dims+15);

    // next three lines 13 though 15
    var h = 12;
    var muu = [];
    while(h < 15){
        var line13To15Dims = beginning + count*h + 1;
        var line13To15 = generateElements(line13To15Dims, line13To15Dims+11);
        var r = $.merge([],line13To15);
        muu = $.merge($.merge(muu,r),line13To15);

        h++;
    }

    var h1 = 15;
    var muu2 = [];
    while(h1 < 19){
        var line14To19Dims = beginning + count*h1 + 1;
        var line14To19 = generateElements(line14To19Dims, line14To19Dims+12);
        var r1 = $.merge([],line14To19);
        muu2 = $.merge($.merge(muu2,r1),line14To19);

        h1++;
    }

    h1 = 19;
    var muu3 = [];
    while(h1 < 23){
        var line18To23Dims = beginning + count*h1 + 1;
        var line18To23 = generateElements(line18To23Dims, line18To23Dims+13);
        var r1 = $.merge([],line18To23);
        muu3 = $.merge($.merge(muu3,r1),line18To23);

        h1++;
    }

    h1 = 23;
    var muu4 = [];
    while(h1 < 25){
        var line22To25Dims = beginning + count*h1 + 1;
        var line22To25 = generateElements(line22To25Dims, line22To25Dims+14);
        var r1 = $.merge([],line22To25);
        muu4 = $.merge($.merge(muu4,r1),line22To25);
        h1++;
    }

    h1 = 25;
    var muu5 = [];
    while(h1 < 27){
        var line24To27Dims = beginning + count*h1;
        var line24To27 = generateElements(line24To27Dims, line24To27Dims+16);
        var r1 = $.merge([],line24To27);
        muu5 = $.merge($.merge(muu5,r1),line24To27);

        h1++;
    }

    return whole.concat(line1,line2,line3,line4,line5,line6,line7,line8,line9,line10,
        line11,line12,muu,muu2,muu3,muu4,muu5,
        linePlunger1,linePlunger2);

}

function generateElements(beginning, end){
    var arr = Array();
    var diff = end - beginning;
    for (var i = 0; i <= diff; i++){
        arr[i] = beginning + i;
    }
    return arr;
}












