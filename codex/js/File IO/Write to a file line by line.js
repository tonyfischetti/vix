// js, file io, open file, write to a file line by line, forEach, fs, cli arguments, fs.open

const fs = require("node:fs/promises");

const inputFile = process.argv[2];
const writeTheseLines = ["Twinkle twinkle little bat",
                         "How I wonder what you're at"];

fs.open(inputFile, 'a').
  then((fh) => {
    writeTheseLines.forEach((line) => {
      fh.write(`${line}\n`);
    });
});
