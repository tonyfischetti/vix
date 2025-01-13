// js, basics, for loops, for in, for of, boomer loops


/**************************************************
 * `for of` iterates over the elements of an _iterable object_
 * (most commonly, an array or string
 *
 */

let arr = [1, 2, 3, 4]

for (const element of arr) {
  console.log(`current element: ${element}`);
}

let nfc = "Όλοι οι άνθρωποι";
let nfd = "Όλοι οι άνθρωποι";

// does exactly what you want with a __NFC__ unicode string
for (const codePoint of nfc) {
  console.log(`current codePoint: ${codePoint}`);
}

// this, too
Array.from(nfc).forEach((value, index) => console.log({ value, index }));

// ONLY NFC!!!


/**************************************************
 * `for in` is for objects
 */

let obj = {
  "red": "cadmium",
  "blue": "cobalt",
  "green": ["hookers", "viridian"]
};

for (const key in obj) {
  console.log(`obj[${key}] = ${obj[key]}`);
};
// obj[red] = cadmium
// obj[blue] = cobalt
// obj[green] = hookers,viridian

const nums = [1, 2, 3, 4];

for (let i = 0; i < nums.length; i++) {
  console.log(nums[i]);
}
// 1\n2\n3\n4



/**************************************************
 * Boomer loop
 */

for (let i = 0; i < nums.length; i++ ) {
  if (i > 1) break;
  console.log(nums[i]);
}
// 1, 2



/**************************************************
 * While and do-while
 */

let count = 0;
while (count < 5) {
  console.log("Count:", count);
  count++;
}

let num = 1;
do {
  console.log("Number:", num);
  num++;
} while (num < 5);

