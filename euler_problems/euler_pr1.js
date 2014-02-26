//Problem1. Find the sum of all the multiples of 3 or 5 below 1000.

function calculate(input){

    var sum = 0;
    for (var i = 0; i < input; i++){
        if (i % 3 === 0){
            sum += i;
        }else if (i % 5 === 0){
            sum += i;
        }
    }
    return sum;
};

var input = 1000;
var result = calculate(input);
console.log(result);