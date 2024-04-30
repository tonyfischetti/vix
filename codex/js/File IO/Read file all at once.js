const fs = require("node:fs/promises");

const inputFile = process.argv[2];
let lineCount = 0;

fs.readFile(inputFile, 'utf-8').
  then((contents) => {
    console.log(`line count: ${contents.split("\n").length-1}`);
});

/* OR ******************************************************** */

const fs = require("node:fs/promises");

const inputFile = process.argv[2];
let lineCount = 0;

fs.open(inputFile, 'r').
  then((fh) => { return fh.read(); }).
  then(({bytesRead, buffer}) => {
    const fileContents = buffer.toString();
    console.log(fileContents.split("\n").length-1);
});