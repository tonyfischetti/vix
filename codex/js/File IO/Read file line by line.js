const fs = require("node:fs");
const readline = require('node:readline');

const inputFile = process.argv[2];

let lineCount = 0;

const rl = readline.createInterface({
  input: fs.createReadStream(inputFile),
  crlfDelay: Infinity,
});

rl.on('line',     (line) => { lineCount += 1 });
rl.once('close',  (res) => { console.log(`line count: ${lineCount}`) });