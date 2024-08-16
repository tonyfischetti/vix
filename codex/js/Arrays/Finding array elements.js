// js, arrays, array methods, finding elements in array, find, indexOf, anaphors

// Many of these functions can take lambdas that include other info...
// array.find(function(currentValue, index, arr),thisValue)
// (same as forEach, and map)

const numbers = [1, 2, 3, 4, 5, 4, 3, 2, 1];

numbers.indexOf(3);               // 2
numbers.lastIndexOf(3);           // 6
numbers.find(x => x==3);          // 3    (returns the value, not the index)
numbers.findLast(x => x==3);      // 3    (returns the value, not the index)
numbers.findIndex(x => x==3);     // 2
numbers.findLastIndex(x => x==3); // 6

