// js, arrays, sort, destructuring, sort an array, toSorted

rainbow = [ 'red', 'orange', 'yellow', 'green', 'blue', 'indigo', 'violet' ];
// rainbow.sort();      // this sorts it in place!!
[...rainbow].sort();    // this doesn't
rainbow.toSorted();     // neither does this
// [ 'blue', 'green', 'indigo', 'orange', 'red', 'violet', 'yellow' ]

[...rainbow].sort((i, j) => i.length - j.length);
// [ 'red',    'blue', 'green',  'orange', 'yellow', 'indigo', 'violet' ]

// to sort an array of objects on a string field...
[{ color: 'red', N: 1 }, { color: 'blue', N: 10 }].sort((i, j) => {
  return (i.color > j.color) - (i.color < j.color);
});
