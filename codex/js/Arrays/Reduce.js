// js, arrays, reduce, fold, accumulator

let numbers = [0, 1, 2, 3, 4, 5, 6, 7];
numbers.reduce((i, acc) => acc+i );     // 28


let rainbow = [ 'red', 'orange', 'yellow', 'green', 'blue', 'indigo', 'violet' ];

rainbow.reduce((i, acc) => `${acc}, ${i}`);
// 'violet, indigo, blue, green, yellow, orange, red'

rainbow.reduceRight((i, acc) => `${acc}, ${i}`);
// 'red, orange, yellow, green, blue, indigo, violet'
