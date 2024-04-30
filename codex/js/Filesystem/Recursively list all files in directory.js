import * as fs from 'node:fs/promises';
import * as os from 'node.os';

// can handle spaces
const lookInThisDirectory = `${os.homedir()}/Desktop/Carlos IV/Backups/Pictures`;

/*
 * `withFileTypes` option returns Dirent objects instead of just strings
 * and have methods like `isFile`, `isDirectory`, `isSymbolicLink`, etc...
 */
fs.readdir(lookInThisDirectory, { recursive: true, withFileTypes: true }).
  then(res => res.filter(i => i.isFile())).
  then(res => res.map(i => i.name)).
  then(console.log);
