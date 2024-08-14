// js, arrays, concat, combine two arrays, array destructuring


let part1 = ["red", "orange", "yellow"];
let part2 = ["green", "blue", "indigo", "violet"];

let rainbow1 = part1.concat(part2);    // same

// uses destructuring to combine two arrays
let rainbow2 = [...part1, ...part2];
