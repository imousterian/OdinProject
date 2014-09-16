var intermediate = "";
var operator = "";

var sums = [];
var temp = [];

$(function(){

    $('.number_btn').click(function(){
        var input  = $(this).val();
        var result = intermediate += input;
        temp.push(result);
        showResult(result);
    });

    $('.operator_btn').click(function(){
        var name = $(this).attr("name");
        if (typeof name === 'undefined')
            operator = $(this).val();
        else
            operator = name;
        setNumbers();
    });

    $('.result_btn').click(function(){
        setNumbers();
        switch(operator){
            case "+":
                showResult(add());
                break;
            case "-":
                showResult(substract());
                break;
            case "x":
                showResult(multiply());
                break;
            case 'division':
                showResult(divide());
                break;
        }
        clearAll();
        sums.push($('#calc_result').val());
    });

    $('.clear_btn').click(function(){
        clearAll();
        showResult("0");
    });
});

function setNumbers(){
    intermediate = "";

    if (temp.length >= 1){
        popped = temp[temp.length-1];
        if (operator === "plusminus"){
            popped = (Number(popped) * (-1)).toString();
            showResult(popped);
        }
        sums.push(popped);
    }
    temp = [];

    if (sums.length == 1){
        popped = sums[0];
        if (operator === "plusminus"){
            popped = (Number(popped) * (-1)).toString();
            showResult(popped);
            sums[0] = popped;
        }
    }
}

function clearAll(){
    intermediate = "";
    temp = [];
    sums = [];
}

function multiply(){
    return Number(sums[0]) * Number(sums[1]);
}

function add(){
    return Number(sums[0]) + Number(sums[1]);
}

function divide(){
    return Number(sums[0]) / Number(sums[1]);
}

function substract(){
    return Number(sums[0]) - Number(sums[1]);
}

function showResult(result){
    $('#calc_result').val(result);
}
