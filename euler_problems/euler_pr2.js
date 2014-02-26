// Problem 2. By considering the terms in the Fibonacci
//sequence whose values do not exceed four million, find the sum of the even-valued terms.

function calculateFibonacci(input){
    var sum = 0;
    if(input <= 2){
        return input;
    } else {
        return calculateFibonacci(input - 2) + calculateFibonacci(input-1);
    }
};

function summarize(max){
    var sum = 0;
    for (var i = 1; i < 34; i++){
        var num = calculateFibonacci(i);
        if (num % 2 === 0 & num <= max){
            sum += num;
        }
    }
    return sum;
};

var sum = summarize(4000000);
console.log(sum);