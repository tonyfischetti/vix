#!/usr/bin/env node

/*
 * TODO: handle Control-C
 */

import * as os            from 'node:os';
import * as fs            from 'node:fs/promises';
import * as path          from 'node:path';
import { Command }        from 'commander';
import { createConsola }  from "consola";


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
    return promise;
  };

  return wrapPromise(apromise);
};

/*** ¿¿¿ can I add methods to the Promise class ??? ***/




/*****************************************************************
 * Globals
 */
const DESCRIPTION = "Install vix (a specific neo-vim environment)";
const VERSION = "0.0.1";
let   DEBUG = false;
let   consola = null;
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
const { box, success } = consola;


/*****************************************************************
 * Error functions
 */

const makeFatalErrorHandler = (exitCode, customMessage) => {
  return (error) => {
    customMessage ? console.error(customMessage) : console.error(error.message);
    if (DEBUG) console.error(error);
    process.exit(exitCode);
  };
}

const makeRecoverableErrorHandler = (fatalVariety,
                                     prompt="Continue? ",
                                     customMessage) => {
  const errorIfFalse = (bool) => { if (!bool) { throw fatalVariety; } return bool; };
  return (error) => {
    return consola.prompt(prompt, { type: 'confirm' }).
      then(errorIfFalse).
      catch(fatalVariety);
  };
};


const fatalCantFindPrefix           = makeFatalErrorHandler(1);
const fatalCantDownloadPlug         = makeFatalErrorHandler(2, "Can't download Plug");
const fatalCantWriteFile            = makeFatalErrorHandler(2, "Can't write file");
const fatalPlugFileAlreadyExists    = makeFatalErrorHandler(3, "Plug already exists");
const recoverPlugFileAlreadyExists	= makeRecoverableErrorHandler(fatalPlugFileAlreadyExists,
  "Plug bootstrapper already exixts... continue installing?");


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
const getNvimAutoloadPrefix = () => {
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
  return fs.mkdir(subdirectory, { recursive: true }).
    then(_ => subdirectory);
};

const downloadPlug = (downloadTo) => {
  const plugURL = "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim";
  const extractText = (response) => response.text();
  const returnBothPathAndText = (text) => { return {downloadTo, text} };
  return fetch(plugURL).
    then(extractText).catch(fatalCantDownloadPlug).
    then(returnBothPathAndText);
};

const writePlugFile = ({downloadTo, text}) => {
  const finalPath = `${downloadTo}/plug.vim`;
  const ensurePathDoesntExist = () => {
    return new Promise((resolve, reject) => {
      fs.stat(finalPath).
        then(() => reject(new Error ("file exists"))).
        catch((err) => {
          if (err.code === 'ENOENT')
            resolve(true);
          reject(err);
        });
    });
  };
  const writeToFS = () => fs.writeFile(finalPath, text, 'utf-8');


  const recover = () => {
    return consola.prompt("Continue?", { type: 'confirm' }).
      then(errorIfFalse);
  };

  // const tmp = makeRecoverableErrorHandler(
  //   fatalPlugFileAlreadyExists,
  //   "Plug bootstrapper already exists... continue installing? "
  // );

  return Promise.resolve().
    then(ensurePathDoesntExist).catch(recoverPlugFileAlreadyExists).
    then(writeToFS);
};


/*****************************************************************
 * Helper functions
 */
const ensureCondition = (thenable) => {
  const x = Math.random();
  console.warn(x);
  if (x > 0.5)
    throw Error ("condition not met");
  return thenable;
}

const ensurePlugDotVimInstallation = ensureCondition;



/*****************************************************************
 * First-order chains
 */
const downloadPlugBootstrapper = () => {
  return Promise.resolve().
    then(info("Downloading Plug plugin bootstrapper")).
    then(getNvimAutoloadPrefix).
      catch(fatalCantFindPrefix).
    then(formDownloadOutputPath).
    then(mkdirDashP).
    then(debug("path: ")).
    then(downloadPlug).
    then(writePlugFile).
      catch(fatalCantWriteFile).
    then(info("plug.vim written"));
};




/*****************************************************************
 * Main
 */
Promise.resolve().
  then(info("Installing vix", box)).
  then(ensurePlugDotVimInstallation).
    catch(downloadPlugBootstrapper).
  then(info("done", success));
  



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

 composing promises

 in "monad"-land.... in "async"-land


 then and catch are branching structures


`
