// js, filesystem, manipulate paths, join paths, normalize paths, relative path, parse path, basename, directory separator, dirname, extname, isAbsolute, home directory, destructuring, apply, do.call

import * as fs from 'node:fs/promises';
import * as path from 'node:path';
import * as os from 'node:os';

const afile = `${os.homedir()}/Desktop/Carlos IV/Backups/Pictures/Cool Pictures/Breakfast Club.gif`;

path.basename(afile);             // 'Breakfast Club.gif'
path.basename(afile, ".gif");     // 'Breakfast Club'
path.sep;                         // '/'
path.delimiter;                   // ':'
path.dirname(afile);              // '/home/tony/Desktop/Carlos IV/Pictures/Cool Pictures'
path.extname(afile);              // '.gif'
path.isAbsolute(afile);           // true

path.join(...["/home", "tony", ".zshrc"]);      // ...["",""] is like apply/do.call
// /home/tony/.zshrc

path.normalize("/home/tony/../tony/.zsh/bin/.././.zshrc");
// /home/tony/.zshrc

path.relative(`${os.homedir()}/Desktop/Carlos IV`, afile);
// Backups/Pictures/Cool Pictures/Breakfast Club.gif

path.parse(afile);
/*
{
  root: "/",
  dir: "/home/tony/Desktop/Carlos IV/Backups/Pictures/Cool Pictures",
  base: "Breakfast Club.gif",
  ext: ".gif",
  name: "Breakfast Club",
}
*/
