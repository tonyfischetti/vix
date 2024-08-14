// js, arrays, sort, destructuring, sort an array, toSorted

rainbow = [ 'red', 'orange', 'yellow', 'green', 'blue', 'indigo', 'violet' ];
// rainbow.sort();      // this sorts it in place!!
[...rainbow].sort();    // this doesn't
rainbow.toSorted();     // neither does this
// [ 'blue', 'green', 'indigo', 'orange', 'red', 'violet', 'yellow' ]

[...rainbow].sort((i, j) => i.length - j.length);
// [ 'red',    'blue', 'green',  'orange', 'yellow', 'indigo', 'violet' ]
