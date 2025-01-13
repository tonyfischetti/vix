// js, file io, open file, write to a file all at once, fs, cli arguments, fs.open, fs.appendFile, fs.writeFile, character encoding, barf

const fs = require("node:fs/promises");

const inputFile = process.argv[2];

// will create a file if it doesn't exists
fs.appendFile(inputFile, "  - Mad Hatter", 'utf-8').
  then(() => { console.log("done!"); });

// or

fs.writeFile(inputFile, "  - Mad Hatter", 'utf-8').
  then(() => { console.log("done!"); });
