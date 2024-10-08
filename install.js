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



let COUNTER = 0;

class PromisePlus extends Promise {

  errorIfFalse() {
    return this.then(bool => { if (!bool) { throw Error("False!"); } return bool; });
  }

	tee(fn=console.log) {
		return this.then(x => { fn(x); return x; });
	}

  info(message, fn=consola.info) {
		return this.then(x => { fn(message); return x; });
  }

  debug(prefix="debug", fn=consola.debug) {
		return this.then(x => {
      fn(`${prefix}: ${x}`);
      return x;
    });
  }

  confirm(message) {
		return this.then(x => {
      return PromisePlus.resolve().
        then(_ => {
          return consola.prompt(message, { type: 'confirm' });
        }).
        errorIfFalse();
    });
  }

  yes() {
    return this.then(x => { return x; });
  }

  no() {
    return this.catch(x => { return x; });
  }

  printState() {
    console.log("printing state");
    console.log(this);
    return this.then(x => {
      // console.log({this.state});
      return x;
    });
  }

  state = {
    thatiamin: Date.now(),
    name: `${++COUNTER}`
  };

  printTime() {
    return this.then(x => {
      console.log({currentTime: Date.now()});
    });
  }

}


class StatefulPromise extends Promise {
  state = {
    thatiamin: Date.now(),
    name: `#${++COUNTER}`
  };

	tee(fn=console.log) {
		return this.then(x => { fn(x); return x; });
	}

  static start() {
    return StatefulPromise.resolve();
    // return ([StatefulPromise.resolve(), this.state]);
  }

  next2 () {
    return this.then(x => { console.log(`returning: ${x}`); return x; });
  }

  then2(something) {
    console.log("in then2");
    // return this.then(x => { return x; });
    return this.then(_ => something(_));
  }

  // `next` wraps `then` to pass state along, as well
  next(flow) {
    const state = this.state;
    console.log(`received state: ${JSON.stringify(state)}`);
    return this
      .then(x => {
        console.log(`my state is this: ${JSON.stringify(state, null, 2)}`);
        console.log(`going to return: ${flow(x)}`);
        return flow(x);
      });
  };
  
  addToState(symId) {
    const state = this.state;
    return this.
      next(({arg, state}) => {
        stateToPass[symId] = arg;
        return ({arg, stateToPass});
      });
  };

  printState() {
    const state = this.state;
    console.log("printing state");
    console.log(state);
    return this.next(x => {
      console.log("");
      return x;
    });
  }

}

const returnPP = () => {
  return "pp";
  // return StatefulPromise.resolve().then(_ => "pp");
};

const addAnother = x => `${x} + pp`;

StatefulPromise.resolve().
  next(returnPP).
  next(addAnother).
  tee();

  // printState();
  // next(returnPP).
  // printState();

  // printState();
  // next(returnPP).
  // printState();


// const info = (message, fn=consola.info, label) => {
//   return (arg) => { fn(message ?? `${label ?? "debug"}: ${arg}`); return arg; }
// };

// const debug = (message, fn=consola.debug) => {
//   return (arg) => { fn(`${message ?? "debug: "}${arg}`); return arg; }
// };




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
// const tee = (arg) => { console.log(arg); return arg; }

// const info = (message, fn=consola.info, label) => {
//   return (arg) => { fn(message ?? `${label ?? "debug"}: ${arg}`); return arg; }
// };
//
// const debug = (message, fn=consola.debug) => {
//   return (arg) => { fn(`${message ?? "debug: "}${arg}`); return arg; }
// };




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

  return PromisePlus.resolve().
    then(ensurePathDoesntExist).catch(recoverPlugFileAlreadyExists).
    then(writeToFS);
};


/*****************************************************************
 * Helper functions
 */
const ensureCondition = (thenable) => {
  const x = Math.random();
  if (x > 0.0001)
    throw Error ("condition not met");
  return thenable;
}

const ensurePlugDotVimInstallation = ensureCondition;



/*****************************************************************
 * First-order chains
 */
const downloadPlugBootstrapper = (idk) => {
  return PromisePlus.resolve().
    info("Downloading Plug plugin bootstrapper").
    then(getNvimAutoloadPrefix).
      catch(fatalCantFindPrefix).
    then(formDownloadOutputPath).
    then(mkdirDashP).
    debug("path").
    then(downloadPlug).
    then(writePlugFile).
      catch(fatalCantWriteFile).
    info("plug.vim written");
};




/*****************************************************************
 * Main
 */
const dontInvoke = () => {

PromisePlus.resolve().
  printState().
  info("Installing vix", box).
  // printTime().
  printState().catch(error => console.error(error)).
  printState().catch(error => console.error(error)).
  confirm("Download plug.vim?").
    yes().then(downloadPlugBootstrapper).
    no().info("skipping...").
  printTime().
  // printState().catch(error => console.error(error)).
  info("done", success);
  
};

// StatefulPromise.resolve().
//   printState();



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


"I promise you, it's not just helpful for point-less.... I mean 'point-free' programming like this
 it's a helpful exercise"


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

""you may ask "why"?""... "so I can have a main that looks like <this>"


 performance penalty?... idgaf

it essentially aliases then and catch to give the semantics

as it turns out, you can create a DSL in Node by subclassing promise

 holy shit... can I get the program to be an Instance of a subclass of promise?!





-----
Ideas from other exercises...

Promise.resolve([energyDrinkA, energyDrinkB]).
  then(getAllPossibleMoves).
  then(getAllTotalEnergy).
  then(getWinner).
  then(console.log);


CustomPromise.beginFlow([energyDrinkA, energyDrinkB]).
  ensure	(bothEqualLength).
  split	  (returnAllPaths).
  apply	  (getTotalEnergy).
  combine (getWinner).
  check   (testsPass).
  end();


And then try with files in directory and lowest hash
(parameterize hash function)

...
  split   (getAllFilesInDirectory).
  apply   (getHash).
  combine (getBiggest);

...
  split     (getAllFilesInDirectory).
  findFirst (getHash).
  matching  (isHashWeAreLookingFor);




  .share()

  exposes the parameter as a binding in the closure returned
  


  you don't have to use this style all the way down
  start by expressing your main like this
  then start working on the adding it, if you'd like, on the way down,
    provided it's deemed helpful

`
