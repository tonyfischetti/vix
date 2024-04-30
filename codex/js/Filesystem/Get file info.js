import * as fs from 'node:fs/promises';
import * as os from 'node:os';

/*
 * has atime, blocks, blksize, isFile, isDirectory, mode, mtime, size, etc...
 */
fs.stat(`${os.homedir()}/.zsh/.zshrc`).
  then(console.log);
