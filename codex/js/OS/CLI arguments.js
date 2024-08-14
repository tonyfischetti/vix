// js, os, argv, splice, cli arguments, check if undefined

// ./script.js 1 2 3
process.argv;               // /usr/bin/node /path/to/script.js 1 2 3
process.argv.length;        // 5
process.argv.splice(2);     // [ '1', '2', '3' ]

process.argv[5];                        // undefined
typeof(process.argv[5])==='undefined';  // true

