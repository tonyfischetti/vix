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

// CHECK IF EXISTS
// will directories work?!
const fileExistsP = async (apath) => {
  try {
    const ret = await fs.stat(apath);
    console.log(ret);
    return true;
  }
  catch (err) {
    if (err.code !== 'ENOENT')
      throw err;
    return false;
  }
};


fileExistsP(doesExist).
  then(console.log);

fileExistsP(doesntExist).
  then(console.log);




