/**************************************************************
 *** ES MODULES ***********************************************
 **************************************************************/

/* ******************************************* */
/* module-code.js */
export const magicConstant = 2.46;
export const square = (x) => x**2;

/* consumer code */
import { square, magicConstant } from './module-code.js';
square(2);
//  or
import * as mod from './module-code.js';
mod.square(2);
/* ******************************************* */


/* ******************************************* */
/* module-code.js */
export const magicConstant = 2.46;
const square = (x) => x**2;
export default square;

/* consumer code */
import square, {magicConstant} from './module-code.js';
square(2);
/* ******************************************* */


/* ******************************************* */
/* module-code.js */
export const magicConstant = 2.46;
export const square = (x) => x**2;
// re-export
export { anotherMagicConstant } from './another-module.js';

/* consumer code */
import { square, magicConstant, anotherMagicConstant } from './module-code.js';
/* ******************************************* */


/* ******************************************* */
/* module-code.js */
export default class Cow {
  constructor(name) {
    this.name = name;
  }
  speak() {
    console.log(`${this.name} says "Moo"`);
  }
};

// or "export default Cow"
/* consumer code */
import Cow from './module-code.js';
const bessie = new Cow("bessie");
bessie.speak();
/* ******************************************* */


/**************************************************************
 *** COMMONJS *************************************************
 **************************************************************/

/* ************* Just one export ************* */
/* module-code.js */
const square = (x) => x**2;
module.exports = square;

/* consumer code */
const square = require("./module-code.js");
/* ******************************************* */

/* ************* Named exports *************** */
/* module-code.js */
const magicConstant = 2.46;
const square = (x) => x**2;
module.exports = { square, magicConstant };

/* consumer code */
const { square, magicConstant } = require("./module-code.js");
/* ******************************************* */

/************************************************
 * Other notes
 *
 * ES modules
 *   - support top-level await
 *   - always in strict mode
 *   - browsers use it
 *   - statically analyzable (tree-shaking)
 *   - supports dynamic imports
 * 
 * CommonJS
 *   - loads and executes synchronously
 * 
 * "Loading and parsing imported modules happens in parallel and
 * asynchronously. The execution needs to be synchronous, but loading and
 * parsing don't have to be."
*************************************************/
