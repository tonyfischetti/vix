// js, basics, functions, default arguments, default args

const test = (a, b=1) => {
  console.log({a, b});
};

test(1, 1);   // { a: 1, b: 1 }
test(2);      // { a: 2, b: 1 }
test(3,2,1);  // { a: 3, b: 2 }

/*
 * - doesn't have python's "mutable default argument" problem
 * - all functions are basically `(a=undefined, b=undefined)`
 * - earlier parameters can be referenced in later ones
 */


