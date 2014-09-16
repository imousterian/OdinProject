function my_max(arr){
    var max = arr[0];
    for (var i = 0; i < arr.length; i++){
        if (arr[i] > max){
            max = arr[i];
        }
    }
    return max;
};

// helper function for vowel_count
Array.prototype.contains = function(k) {
  for(var i=0; i < this.length; i++){
    if(this[i] === k){
      return true;
    }
  }
  return false;
}

function vowel_count(str){
    var splitted = str.split("");
    var vowels_splitted = 'aeiouy'.split("");
    console.log(splitted);
    counter = 0;
    for (var i = 0; i < splitted.length; i++){
        if (vowels_splitted.contains(splitted[i])){
            counter += 1;
        }
    }
    return counter;
}

function reverse(str){
    result = "";
    splitted = str.split("");
    for(var i = splitted.length-1; i >= 0; i--){
        result += splitted[i];
    }
    return result;
}
