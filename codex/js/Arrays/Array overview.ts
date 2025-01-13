// js, arrays, overview, Object.keys, Object.values, Array.isArray()

/**
  * Arrays are objects that have numeric indices
  *  NOTE  actually, only strings (and symbols) are allowed to be keys
  *        of an object
  *        Javascript will make `test['0']` -> `test[0]`
  */

let nums = {
  "0": "zero",
  "1": "one",
  "2": "two",
  "3": "three"
};

typeof nums;                  // 'object'
Array.isArray(nums);          // false
Object.keys(nums);            // [ '0', '1', '2', '3' ]
Object.values(nums);          // ['zero', 'one', 'two', 'three'];

let numArr = Object.values(nums);
typeof numArr;                  // 'object'
Array.isArray(numArr);          // true


numArr.arb = "hi";
Array.isArray(numArr);          // true
numArr.map(i => i);             // ['zero', 'one', 'two', 'three'];
Object.keys(numArr)             // [ '0', '1', '2', '3', 'arb' ]


nums = {};
nums['4'] = 'four';   // { '4': 'four' }
nums['1'] = 'one';    // { '1': 'one', '4': 'four' }
nums['0'] = 'zero';   // ...
nums['3'] = 'three';  // { '0': 'zero', '1': 'one', '3': 'three', '4': 'four' }
nums['2'] = 'two';    // { '0': 'zero', '1': 'one', '2': 'two', '3': 'three', '4': 'four' }
//  NOTE  they are re-ordered
//        BUT DON'T RELY ON THAT!

Object.values(nums);  // [ 'zero', 'one', 'two', 'three', 'four' ]
