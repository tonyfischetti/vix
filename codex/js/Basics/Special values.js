
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


Number.NaN;                // NaN
Number.NEGATIVE_INFINITY;  // Infinity
Number.POSITIVE_INFINITY;  // -Infinity

Number.isNaN(Number.NaN);                   // true
Number.isFinite(10);                        // true
Number.isFinite(Number.POSITIVE_INFINITY);  // false
