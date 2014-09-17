$(function(){

    $('#content').append("<div class='tabs'></div>").prepend("<img id='theImg' src='images/guinea-pig-1.jpg' />").prepend("<h1>We are the best restaurant for your guinea pig!</h1>");
    $('.tabs').append("<ul class='tab-links'></ul>");
    var lis = "<li><p id='atab1' class='tab1'>About Us</p></li>" +
                "<li><p id='atab2' class='tab2'>Contact</p></li>" +
                "<li><p id='atab3' class='tab3'>Menu</p></li>";
    $('.tab-links').append(lis);
    $('.tabs').append("<div class='tab-content'></div>");


    var about_us = "<div id='tab1' class='tab tab1'><p>We are awesome!</p></div>";
    var contact_us = "<div id='tab2' class='tab tab2'><p>Contact us!</p></div>";
    var menu = "<div id='tab3' class='tab tab3'><p>Menu is filled with veggies.</p></div>";

    replaceTabs('.tab1', about_us);
    replaceTabs('.tab2', contact_us);
    replaceTabs('.tab3', menu);

});

var replaceTabs = function(element, contents){
    $(element).click(function(){
        $('.active').remove();
        $('.tab-content').html(contents);
        var classy = "div." + $(this).attr('class');
        $(classy).addClass('active');
    });
}
