// js, strings, splitting strings, regex, case-insensitive regex, RegExp

const str = "Hello";

str.split(/l+/);              // [ 'He', 'o' ]
str.split(/L+/i);             // (case insensitive)
str.split(new RegExp("l+"));  // [ 'He', 'o' ]
