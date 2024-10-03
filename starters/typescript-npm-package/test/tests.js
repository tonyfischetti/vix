
import assert from 'assert';


import { reverseString } from '../dist/reverser.js';
import { isPalindrome } from '../dist/isPalindrome.js';


describe('check whole package', () => {

  describe('check reverseString', () => {
    it("should handle simple case", () => {
      assert.equal(reverseString("this"), "siht");
    });
    it("should handle palindrome", () => {
      assert.equal(reverseString("radar"), "radar");
    });
    it("should handle string with whitespace", () => {
      assert.equal(reverseString("radar love"), "evol radar");
    });
    it("should handle empty string", () => {
      assert.equal(reverseString(""), "");
    });
  });

  describe('check isPalindrome', () => {
    it("should handle NOT palindrome", () => {
      assert.equal(isPalindrome("this"), false);
    });
    it("should handle palindrome", () => {
      assert.equal(isPalindrome("amanaplanacanalpanama"), true);
    });
  });


});

