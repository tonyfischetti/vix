// js, file io, open file, write to a file all at once, fs, cli arguments, fs.open, fs.appendFile, fs.writeFile, character encoding, barf

const fs = require("node:fs/promises");

const outputFile = process.argv[2];

// will create a file if it doesn't exists
fs.appendFile(outputFile, "  - Mad Hatter", 'utf-8').
  then(() => { console.log("done!"); });

// or

fs.writeFile(outputFile, "  - Mad Hatter", 'utf-8').
  then(() => { console.log("done!"); });
