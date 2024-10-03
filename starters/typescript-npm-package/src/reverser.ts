
import { PotentialPalindrome } from './types.js';

export const reverseString = (str: PotentialPalindrome): PotentialPalindrome => {
  return str.split("").reverse().join("");
};
