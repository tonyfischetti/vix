// js, arrays, slice, array subsetting

let rainbow = [ 'red', 'orange', 'yellow', 'green', 'blue', 'indigo', 'violet' ];

rainbow.slice(1); // [ 'orange', 'yellow', 'green', 'blue', 'indigo', 'violet' ]
rainbow.slice(1, 3);   // [ 'orange', 'yellow' ]
rainbow.slice(-1);     // [ 'violet' ]
rainbow.slice(4, -1);  // [ 'blue', 'indigo' ]
rainbow.slice(-3, -1); // [ 'blue', 'indigo' ]
