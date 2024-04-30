import * as fs from 'node:fs/promises';
import * as path from 'node:path';
import * as os from 'node:os';

const doesExist   = `${os.homedir()}/Desktop/Carlos IV/Backups/Pictures/Cool Pictures/Breakfast Club.gif`;
const doesntExist = `${os.homedir()}/Desktop/Carlos IV/Backups/Pictures/Cool Pictures/Breakfast Clubz.gif`;

path.basename(doesExist);
// Breakfast Club.gif

path.basename(doesExist, ".gif");
// Breakfast Club

path.delimiter;
// :

path.dirname(doesExist);
// /home/tony/Desktop/Carlos IV/Pictures/Cool Pictures

path.extname(doesExist);
// .gif


// console.log(path.parse(doesExist));


const fileExistsP = (apath) => {
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

fileExistsP(doesExist).
  then(i => console.log(`does1: ${i}`));

fileExistsP(doesntExist).
  then(i => console.log(`doesnt1: ${i}`));


