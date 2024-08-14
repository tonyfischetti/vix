// js, file io, fs.appendFile, append to a file, character encoding

const fs = require("node:fs/promises");

const inputFile = process.argv[2];

// will create a file if it doesn't exists
fs.appendFile(inputFile, "  - Mad Hatter", 'utf-8').
  then(() => { console.log("done!"); });
