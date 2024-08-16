// js, arrays, filter, remove-if-not, remove-if, match, detect, anaphors

let rainbow = [ 'red', 'orange', 'yellow', 'green', 'blue', 'indigo', 'violet' ];


rainbow.filter(i => i.match(/r/));  // [ 'red', 'orange', 'green' ]


// array.filter(function(currentValue, index, arr),thisValue)
// (same as forEach, and map)

const numbers = [1, 2, 3, 4, 5, 4, 3, 2, 1];

numbers.filter((v, i, a) => v % 3 == 0 && i % 3 == 0)   // [ 3 ]
