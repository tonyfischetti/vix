// js, arrays, map, mapcar, index and value, zip, anaphors

let nums = [0, 1, 2, 3, 4, 5, 6];
let rainbow = [ 'red', 'orange', 'yellow', 'green', 'blue', 'indigo', 'violet' ];

const zip = (array1, array2) => {
  return array1.map((value, index, array) => [value, rainbow[index]]);
};

zip(nums, rainbow);
// [
//     [ 0, 'red' ],
//     [ 1, 'orange' ],
//     [ 2, 'yellow' ],
//     [ 3, 'green' ],
//     [ 4, 'blue' ],
//     [ 5, 'indigo' ],
//     [ 6, 'violet' ]
// ]
