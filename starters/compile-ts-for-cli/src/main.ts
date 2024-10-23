
import * as fs from 'node:fs/promises';
import * as os from 'node:os';


type FileContents = string;
type LineCount    = number;


const readMyOwnLineCount = (): Promise<LineCount> => {
  const myself = import.meta.filename;
  return fs.readFile(myself, 'utf-8').
    then((contents: FileContents) => {
      return contents.split(os.EOL).length-1;
  });
}

const main = () => {
  Promise.resolve().
    then(readMyOwnLineCount).
    then(console.log);
};

main();
