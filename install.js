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

const promisePlus = (promise) => {
  promise.metah = (flow) => {
    console.log("peepee");
    return promise.then(flow);
  };
  return promise;
}

const StateFlow0 = () => {
  const apromise = Promise.resolve();
  apromise.metah = (flow) => {
    console.log("peepee");
    return apromise.then(flow);
  };
  return apromise;
};

const StateFlow = () => {
  const apromise = Promise.resolve();

  const wrapPromise = (promise) => {
    promise.metah = (flow) => {
      console.log("peepee");
      return wrapPromise(promise.then(flow));
    };
    return wrapPromise(promise);
  };

  return wrapPromise(apromise);
};

/*** ¿¿¿ can I add methods to the Promise class ??? ***/



/*****************************************************************
 * Main
 */
StateFlow().
  metah(info("Installing vix", box)).
  metah(getNvimPrefix).catch(fatalCantFindPrefix).
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

  Having the period at the end of the line makes 'then' a
  then(debug("prefix: ")).


"but what about a relatively stateful application"...

## beyond
  - closure that glues state
  - adding to promises
  - poly-wrapped promises

we _could_ subclass Promise...
it returns a object with a method added that is then invoked
  - (a16c31688582) StateFlow().metah()

but that doesn't work after the first 'meta'
¿want to guess what the error is? (TypeError: StateFlow(...).metah(...).metah is not a function)

::commit after 7824a0cb6a026b23c9da::
¿want to guess what the error is? (Maximum call stack exceeded)



## Screenshots

--
 ╭──────────────────╮
 │                  │
 │  Installing vix  │
 │                  │
 ╰──────────────────╯

ℹ found prefix                                                               6:31:20 PM
⚙ prefix: /Users/tony/.local/share/                                          6:31:20 PM
ℹ found prefix. making directory                                             6:31:20 PM
⚙ path: undefined                                                            6:31:20 PM
--

--
 ╭──────────────────╮
 │                  │
 │  Installing vix  │
 │                  │
 ╰──────────────────╯

ℹ found prefix                                                               6:47:15 PM
file:///Users/tony/.config/nvim/install.js:138
  metah(formDownloadOutputPath).
  ^

TypeError: StateFlow(...).metah(...).then(...).catch(...).then(...).then(...).metah is not a function
    at file:///Users/tony/.config/nvim/install.js:138:3
--

or
TypeError: StateFlow(...).metah(...).metah is not a function


--
file:///Users/tony/.config/nvim/install.js:120
  const wrapPromise = (promise) => {
                      ^

RangeError: Maximum call stack size exceeded
    at wrapPromise (file:///Users/tony/.config/nvim/install.js:120:23)
    at wrapPromise (file:///Users/tony/.config/nvim/install.js:125:12)
    at wrapPromise (file:///Users/tony/.config/nvim/install.js:125:12)
    at wrapPromise (file:///Users/tony/.config/nvim/install.js:125:12)
    at wrapPromise (file:///Users/tony/.config/nvim/install.js:125:12)
    at wrapPromise (file:///Users/tony/.config/nvim/install.js:125:12)
    at wrapPromise (file:///Users/tony/.config/nvim/install.js:125:12)
    at wrapPromise (file:///Users/tony/.config/nvim/install.js:125:12)
    at wrapPromise (file:///Users/tony/.config/nvim/install.js:125:12)
    at wrapPromise (file:///Users/tony/.config/nvim/install.js:125:12)
--






 ***************************************************************************
 ***************************************************************************/


`
