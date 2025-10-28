// js, filesystem, check if path exists, home directory, return a promise, fs, stat, reject, resolve

import * as fs from 'node:fs/promises';
import * as os from 'node:os';

const doesExist   = `${os.homedir()}/Desktop/Carlos IV/Backups/Pictures/Cool Pictures/Breakfast Club.gif`;
const doesntExist = `${os.homedir()}/Desktop/Carlos IV/Backups/Pictures/Cool Pictures/Breakfast Club2.gif`;

const pathExistsP = apath => {
  return fs.stat(apath)
    .then(() => true)
    .catch((err) => {
      if (err.code === 'ENOENT') return false;
      throw err;
    });
};

pathExistsP(doesExist).then(console.log);
pathExistsP(doesntExist).then(console.log);
