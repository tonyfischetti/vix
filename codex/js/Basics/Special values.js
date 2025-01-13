// js, basics, undefined, null, check if undefined, check if null, special numbers, special values, bottom values, testing for special values, testing for bottom values


/*
 * Javascript has two bottom values:
 *   - null
 *   - undefined
 */

/***** undefined **********************************
 * When a variable is declared but not initialized
 */
let i;
i;                                // undefined
typeof(i) === 'undefined';        // true


const foo = (expectedArg) => { expectedArg };
foo();                            // undefined
typeof(foo()) === 'undefined';    // true


/***** null **************************************
 * Some suggest you should use `null` only for 
 * _intentionally_ missing values
 */
let j = null;
j === null;                       // true

// null is also what you push to streams to signal that it's done


/***** testing **********************************
 * different ways of testing bottom values
 */

let val;
typeof(val) === 'undefined' // true
val === undefined           // true
!val                        // true
val == null                 // true
val === null                // false

/* ----- */

val = undefined;
typeof(val) === 'undefined' // true
val === undefined           // true
!val                        // true
val == null                 // true
val === null                // false

/* ----- */

val = null;
typeof(val) === 'undefined' // false
val === undefined           // false
!val                        // true
val == null                 // true
val === null                // true


/**
  * `undefined` used to be able to be redefined so the `typeof...` gambit
  * was necessary. x === undefined is fine, now (since ES5)
  * HOWEVER...
  * If a variable hasn't been declared yet, the `typeof` thing _will_ work
  * (but not thing===undefined, etc...
  */

//  WARN  `typeof null` is `object`

/***** numbers **********************************
 *
 */

Number.NaN;                // NaN
Number.NEGATIVE_INFINITY;  // Infinity
Number.POSITIVE_INFINITY;  // -Infinity

Number.isNaN(Number.NaN);                   // true
Number.isFinite(10);                        // true
Number.isFinite(Number.POSITIVE_INFINITY);  // false

