// js, arrays, map, mapcar, index and value, toUpperCase, upper case, anaphors, flatMap

let rainbow = [ 'red', 'orange', 'yellow', 'green', 'blue', 'indigo', 'violet' ];

rainbow.map(i => i.toUpperCase());  // [ 'RED', 'ORANGE', etc...]

rainbow.map((value, index, array) => {
  return `  - [${index}] => '${value}'`
});



const numbers = [1, 2, 3];

numbers.flatMap(i => [i, i*2]);     // [ 1, 2, 2, 4, 3, 6 ]
