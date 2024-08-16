// js, arrays, array predicates, some, every, includes, any, all, match, regex, anaphors

// Many of these functions can take lambdas that include other info...
// array.every(function(currentValue, index, arr),thisValue)
// (same as forEach, and map)

let rainbow = [ 'red', 'orange', 'yellow', 'green', 'blue', 'indigo', 'violet' ];

rainbow.every(i => i.match(/\w/));  // true
rainbow.every(i => i.match(/r/));   // false
rainbow.some(i => i.match(/r/));    // true
rainbow.some(i => i.match(/z/));    // false
rainbow.includes("red");            // true
rainbow.includes("RED");            // false

