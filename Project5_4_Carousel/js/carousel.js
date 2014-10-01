$(function(){

    var i = 0;
    var interval;
    var divs = $('.carousel > div');
    var circles = $('#circles > li');

    function cycle(){

        divs.removeClass('active').eq(i).addClass('active');

        circles.removeClass('active').eq(i).addClass('active');

        var img_width = divs.eq(i).children().width() + $('.carousel-control').width() * 2;
        $('#container').css('width', img_width + 'px');

        i = ++i % divs.length;

        clearTimeout(interval);
        interval = setTimeout(function() { cycle(); }, 4000);
    };

    $('.prev').click(function(){
        i = $('div.active').index() - 1;
        cycle();
    });

    $('.next').click(function(){
        var next = $('div.active').index() + 1;
        next === divs.length ? i = 0 : i = next;
        cycle();
    });

    $('#circles > li').click(function(){
        i = $(this).index();
        cycle();
    });

    cycle();

});
