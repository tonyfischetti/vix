// js, file io, open file, read a file all at once, fs, cli arguments, fs.open, fs.readFile, character encoding, bytes read, end of line character, slurp

const fs = require("node:fs/promises");
const os = require("node:os");


const inputFile = process.argv[2];
let lineCount = 0;

fs.readFile(inputFile, 'utf-8').
  then((contents) => {
    console.log(`line count: ${contents.split(os.EOL).length-1}`);
});

/* OR ******************************************************** */

const fs = require("node:fs/promises");
const os = require("node:os");

const inputFile = process.argv[2];
let lineCount = 0;

fs.open(inputFile, 'r').
  then((fh) => { return fh.read(); }).
  then(({bytesRead, buffer}) => {
    const fileContents = buffer.toString();
    console.log(fileContents.split(os.EOL).length-1);
});
