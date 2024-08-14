// js, arrays, create an array, array length, concat, combine two arrays, array destructuring

let tmp = [0, 1, 2, "three"];

tmp[1]        // 1
tmp["1"]      // 1

tmp.length    // 4

// empty array of 100 `undefined`s
let tmp2 = [];
tmp2.length = 100;

// same
Array(100);

// uses destructuring to combine two arrays
let part1 = ["red", "orange", "yellow"];
let part2 = ["green", "blue", "indigo", "violet"];

let rainbow = [...part1, ...part2];
let rainbow2 = part1.concat(part2);    // same
