// js, array, loop through array, entries, index and value, let of, get elements from an array, anaphors

let rainbow = [ 'red', 'orange', 'yellow', 'green', 'blue', 'indigo', 'violet' ];

for (let value of rainbow ){
  console.log(`  - ${value}`);
}

for (let [index, value] of rainbow.entries()) {
  console.log(`  - [${index}] => '${value}'`);
}
