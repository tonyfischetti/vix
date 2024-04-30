const str = "Hello";
str.match(/Hel{2}/);  // [ 'Hell', index: 0, input: 'Hello', groups: undefined ]
str.match(/Hel{2}/) ? "yes" : "no"
str.match(new RegExp("Hel{2}"));
str.match(/HeL/i) ? "yes" : "no"  // case insensitive