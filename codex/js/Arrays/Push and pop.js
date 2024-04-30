// `push`/`pop` adds/removes from end
// `unshift`/`shift` add/removes from beginning

let rainbow = ["orange", "yellow", "green"];
rainbow.push("blue");
rainbow.push("indigo");
rainbow.push("violet");
rainbow.push("ultraviolet");
rainbow
// [ 'orange', 'yellow', 'green', 'blue', 'indigo', 'violet', 'ultraviolet' ]
let tmp = rainbow.pop();    
rainbow
// [ 'orange', 'yellow', 'green', 'blue', 'indigo', 'violet' ]
tmp                         // ultraviolet

rainbow.unshift("red");
rainbow.unshift("infrared");
rainbow
[
    'infrared', 'red',
    'orange',   'yellow',
    'green',    'blue',
    'indigo',   'violet'
]
let tmp2 = rainbow.shift();
rainbow
// [ 'red', 'orange', 'yellow', 'green', 'blue', 'indigo', 'violet' ]
tmp2                        // infrared