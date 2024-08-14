// js, filesystem, check if path exists, home directory, return a promise, fs, stat, reject, resolve

import * as fs from 'node:fs/promises';
import * as os from 'node:os';

const doesExist   = `${os.homedir()}/Desktop/Carlos IV/Backups/Pictures/Cool Pictures/Breakfast Club.gif`;
const doesntExist = `${os.homedir()}/Desktop/Carlos IV/Backups/Pictures/Cool Pictures/Breakfast Club2.gif`;

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

pathExistsP(doesExist).then(console.log);
pathExistsP(doesntExist).then(console.log);
