let range = Array(10).fill().map((_, i) => i++);
range       // [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 ]

let j = 9;
let range2 = Array(j).fill().map((_, i) => j-i);
range2      // [ 9, 8, 7, 6, 5, 4, 3, 2, 1 ]