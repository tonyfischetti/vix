// js, arrays, array destructuring, car, cdr, cadr

let part1 = ["red", "orange", "yellow"];
let part2 = ["green", "blue", "indigo", "violet"];
let rainbow = [...part1, ...part2];
let clone  = [...rainbow];

let [car, cadr, caddr, ...rest] = [...rainbow];
car     // red
cadr    // orange
caddr   // yellow
rest    // [ 'green', 'blue', 'indigo', 'violet' ]

// you can skip elements
const nums = [1, 2, 3, 4, 5];
const [ one, , three, , five] = nums;
one     // 1
three   // 3
five    // 5
