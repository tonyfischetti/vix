let part1 = ["red", "orange", "yellow"];
let part2 = ["green", "blue", "indigo", "violet"];
let rainbow = [...part1, ...part2];
let clone  = [...rainbow];

let [car, cadr, caddr, ...rest] = [...rainbow];
car     // red
cadr    // orange
caddr   // yellow
rest    // [ 'green', 'blue', 'indigo', 'violet' ]
