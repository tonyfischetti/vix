let rainbow = [ 'red', 'orange', 'yellow', 'green', 'blue', 'indigo', 'violet' ];
rainbow.reverse();
rainbow               // it was reversed in place!

rainbow = [ 'red', 'orange', 'yellow', 'green', 'blue', 'indigo', 'violet' ];
let reved = [...rainbow].reverse();
rainbow               // unchanged
reved                 // new reversed array

// or

rainbow.toReversed();