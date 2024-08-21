// js, arrays, reduce, fold, accumulator, initial value

let numbers = [0, 1, 2, 3, 4, 5, 6, 7];
numbers.reduce((acc, i) => acc+i );     // 28


let rainbow = [ 'red', 'orange', 'yellow', 'green', 'blue', 'indigo', 'violet' ];

rainbow.reduce((acc, i) => `${acc}, ${i}`);
// 'red, orange, yellow, green, blue, indigo, violet'

rainbow.reduceRight((acc, i) => `${acc}, ${i}`);
// 'violet, indigo, blue, green, yellow, orange, red'



const findMinMax = (lst) => {
  const minMaxReducer = (acc, i) => {
    return { min: i < acc.min ? i : acc.min,
             max: i > acc.max ? i : acc.min };
  };
  // you can supply an initialValue for the accumulator
  return lst.reduce(minMaxReducer, { min: Infinity, max: -Infinity });
};

findMinMax([10, 8, 20, 3, 17, 19]);       // { min: 3, max: 19, }
