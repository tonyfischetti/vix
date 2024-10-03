
import { PotentialPalindrome } from './types.js';
import { reverseString } from './reverser.js';

export const isPalindrome = (str: PotentialPalindrome): boolean => {
  const reversed = reverseString(str);
  return str === reversed;
};

