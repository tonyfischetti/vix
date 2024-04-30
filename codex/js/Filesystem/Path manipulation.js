import * as path from 'node:path';
import * as os from 'node:os';

const doesExist   = `${os.homedir()}/Desktop/Carlos IV/Backups/Pictures/Cool Pictures/Breakfast Club.gif`;

path.basename(doesExist);           // Breakfast Club.gif
path.basename(doesExist, ".gif");   // Breakfast Club
path.sep;                           // /
path.delimiter;                     // :
path.dirname(doesExist);            // /home/tony/Desktop/Carlos IV/Pictures/Cool Pictures
path.extname(doesExist);            // .gif

path.normalize("/home/tony/Desktop/../.zsh/./.zshrc");
// /home/tony/.zsh/.zshrc

path.relative(`${os.homedir()}/Desktop`, doesExist);
// Carlos IV/Backups/Pictures/Cool Pictures/Breakfast Club.gif

path.isAbsolute(path.relative(`${os.homedir()}/Desktop`, doesExist));
// false

path.isAbsolute(doesExist); // true

path.parse(doesExist);
/*
{
    root: "/",
      dir: "/home/tony/Desktop/Carlos IV/Backups/Pictures/Cool Pictures",
      base: "Breakfast Club.gif",
      ext: ".gif",
      name: "Breakfast Club",
}
*/

path.join(...[os.homedir(), ".zsh", ".zshrc"]);
// /home/tony/.zsh/.zshrc
