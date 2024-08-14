// js, math, random numbers, cryptography, cryptographically secure random numbers, floor, Uint8Array, webcrypto

Math.random();          // random number between 0 and (less than) 1

const getRandomInRange = (min, max) => {
  return (Math.floor(Math.random() * (max-min)) + min);
};

/*
 * THESE ARE NOT FIT FOR CRYPTOGRAPHY!
 * You should use these instead
 */

import * as crypto from 'node:crypto';

crypto.randomInt(10); // between 0 and 9

// or

const arr = new Uint8Array(10000);
crypto.webcrypto.getRandomValues(arr);

// or

crypto.randomBytes(4);                  // Buffer(4) [ 75, 86, 88, 132 ]
crypto.randomBytes(4).toString('hex');  // 8050e2f9


// For the browser
const arr = new Uint8Array(10000);
self.crypto.getRandomValues(arr);
