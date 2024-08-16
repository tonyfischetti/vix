#!/usr/bin/env node


import * as os            from 'node:os';
import * as fs            from 'node:fs/promises';
import * as path          from 'node:path';
import { Command }        from 'commander';
import { createConsola }  from "consola";



/*****************************************************************
 * Globals
 */
const DESCRIPTION = "Install vix (a specific neo-vim environment)";
const VERSION = "0.0.1";
let   DEBUG = false;
let   consola = null;
const PLUG_URL = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim";
const PROGRAM = new Command();


/*****************************************************************
 * CLI argument parsing
 */
PROGRAM.
  name("install.js").
  description(DESCRIPTION).
  version(VERSION);

PROGRAM.
  option("-d, --debug", "turn on DEBUG");

PROGRAM.parse(process.argv);

const OPTS = PROGRAM.opts();
if (OPTS.debug) { DEBUG = true; }

consola = createConsola({ level: 3 + DEBUG });
const { box } = consola;


/*****************************************************************
 * Error functions
 */
const printErrorAndBailOut = (exitCode, customMessage) => {
  return (error) => {
    customMessage ? console.error(customMessage) : console.error(error.message);
    if (DEBUG) console.error(error);
    process.exit(exitCode);
  };
};

const fatalCantFindPrefix  = printErrorAndBailOut(1);


/*****************************************************************
 * Info / logging functions
 */
const tee = (arg) => { console.log(arg); return arg; }

const info = (message, fn=consola.info, label) => {
  return (arg) => { fn(message ?? `${label ?? "debug"}: ${arg}`); return arg; }
};

const debug = (message, fn=consola.debug) => {
  return (arg) => { fn(`${message ?? "debug: "}${arg}`); return arg; }
};


/*****************************************************************
 * Main functions
 */
const getNvimPrefix = () => {
  const prefix = process.env["XDG_DATA_HOME"] ??
                   `${os.homedir()}/.local/share/` ?? "";
  if (prefix) return prefix;
  throw Error("couldn't find nvim prefix");
}

const formDownloadOutputPath = (prefix) => {
  const PLUG_SUBPATH = "/nvim/site/autoload/";
  return path.join(prefix, PLUG_SUBPATH);
};

const formPlugPath = (parentDir) => `${parentDir}/plug.vim`;

const mkdirDashP = (subdirectory) => {
  return fs.mkdir(subdirectory, { recursive: true });
};





/*****************************************************************
 * Experimentation
 */
const metah = (promise) => {
  promise.metah
}




/*****************************************************************
 * Main
 */
Promise.resolve().
  then(info("Installing vix", box)).
  then(getNvimPrefix).catch(fatalCantFindPrefix).
  then(info("found prefix")).
  then(debug("prefix: ")).
  then(formDownloadOutputPath).
  then(info("found prefix. making directory")).
  then(mkdirDashP).
  then(debug("path: ")).
  then(_ => "peepee/poopoo");
  



// curl -Lo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim 
// nvim --headless +PlugInstall +qall
// ln -s $HOME/.config/nvim ~/.vim



`
/***************************************************************************
 ********** Point-free Promises ********************************************

## history

"in lisp. Well..... ... in a language _implemented_ in lisp"
"that is __NOT__ an easy thing to give up"

## javascript
promises
"¿how is this going to change my workflow?"
"¿how can I take this idea and
  ~make it my own | abuse it | take it and run ~?"
bringing that to what i'm used to

## install.sh

  Having the period at the end of the line makes ``then``a
  then(debug("prefix: ")).


"but what about relatively stateful application"...

## beyond
  - closure that glues state
  - adding to promises
  - poly-wrapped promises

 ***************************************************************************
 ***************************************************************************/

`
