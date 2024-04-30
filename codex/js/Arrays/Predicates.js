let rainbow = [ 'red', 'orange', 'yellow', 'green', 'blue', 'indigo', 'violet' ];

rainbow.every(i => i.match(/\w/));  // true
rainbow.every(i => i.match(/r/));   // false
rainbow.some(i => i.match(/r/));    // true
rainbow.some(i => i.match(/z/));    // false
rainbow.includes("red");            // true
rainbow.includes("RED");            // false