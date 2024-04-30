let rainbow = [ 'red', 'orange', 'yellow', 'green', 'blue', 'indigo', 'violet' ];

rainbow.map(i => i.toUpperCase());  // [ 'RED', 'ORANGE', etc...]

rainbow.map((value, index) => {
  return `  - [${index}] => '${value}'`
});