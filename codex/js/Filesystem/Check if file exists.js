// js, filesystem, check if file exists, home directory, return a promise, fs, stat, reject, resolve

import * as fs from 'node:fs/promises';
import * as path from 'node:path';
import * as os from 'node:os';

// doesn't have to be an absolute path
const doesExist   = `${os.homedir()}/.zshrc`;
const doesntExist = `${os.homedir()}/.zeeshrc`

const pathExistsP = (apath) => {
  return new Promise((resolve, reject) => {
    fs.stat(apath).
      then(() => resolve(true)).
      catch((err) => {
        if (err.code === 'ENOENT')
          resolve(false);
        reject(err);
      });
  });
};

pathExistsP(doesExist). then(i => console.log(`does1: ${i}`));
pathExistsP(doesntExist). then(i => console.log(`doesnt1: ${i}`));
