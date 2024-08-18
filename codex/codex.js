#!/usr/bin/env node

import * as proc  from 'node:child_process';
import Database   from 'better-sqlite3';

/* GLOBALS */
let DEBUG       = false;
let LANG        = "";
let CODEX_ROOT  = "";
let DB          = null;



// a function that takes an exit code and returns a closure that takes
// an Error, prints it, and exits with the exit code
const printErrorAndBailOut = (exitCode, customMessage) => {
  return (error) => {
    customMessage ? console.error(customMessage) : console.error(error);
    if (DEBUG) console.error(error);
    process.exit(exitCode);
  };
};

const cantFindCodexRootBailOut  = printErrorAndBailOut(1, "Can't find environment variable $CODEX_ROOT");
const cantFindFzfBailOut        = printErrorAndBailOut(2, "Can't find FZF. is it installed?");
const cantOpenDBBailOut         = printErrorAndBailOut(3, "Unable to open database");
const noFzfSelectionBailOut     = printErrorAndBailOut(4, "Nothing selected");



const setGlobalCODEX_ROOT = () => {
  CODEX_ROOT = process.env["CODEX_ROOT"] ?? "";
  if (CODEX_ROOT === "") throw Error("Environment variable 'CODEX_ROOT' not defined");
};

const openDatabaseAndSetGlobalDB = () => {
  try {
    DB = new Database(`${CODEX_ROOT}/codex.db`, {readonly: true, fileMustExist: true});
  } catch (error) {
    throw Error("unable to open database");
  }
};


const getLanguage = () => {
  const lang = process.argv[2] ?? "";
  if (lang === "") throw Error("no language supplied");
  return lang;
}

const setGlobalLANG = (lang) => { LANG = lang; };

const promSpawn = (command, more) => {
  return new Promise((resolve, reject) => {
    try {
      const com = proc.spawn(command, more);
      let out = ""; let err = "";
      com.on('error',       (err) => reject(err));
      com.stdout.on('data', (data) => out = out + data.toString());
      com.stderr.on('data', (data) => err = err + data.toString());
      com.on('close', (code, signal) => {
        resolve({out: out.trim(), err: err.trim(), code: code, signal: signal});
      });
    } catch(err) {
      reject(err);
    }
  });
};

const getAllLangs = () => {
  const q = `
    SELECT DISTINCT files.subDir
      FROM files`;
  const stm = DB.prepare(q);
  const r = stm.all();
  return r.map(i => i.subDir);
};

const getAllTagsForLang = (subDir) => {
  const q = `
    SELECT DISTINCT tags.tag
      FROM files
        INNER JOIN tags USING (fileID)
      WHERE subDir=?`;
  const r = DB.prepare(q).bind(subDir);
  return r.all().map(i => i.tag);
};

const getRelevantFiles = (atag) => {
  const q = `
    SELECT DISTINCT files.relPath
      FROM files
        INNER JOIN tags USING (fileID)
        WHERE tag=? AND
              subDir=?`;
  const r = DB.prepare(q).bind(atag, LANG);
  return r.all().map(i => i.relPath);
};

const callFzf = (listOfOptions) => {
  const combedOptions = listOfOptions.join('\n');
  return promSpawn(`printf '${combedOptions}' | fzf -1`, { shell: true });
};

const cmdResponseIsSaneP = (cmdResponse) => {
  if (cmdResponse.code !== 0)
    throw Error("received non-zero error code from external command");
  return cmdResponse;
};

const relayErrorAndExit = (error) => {
  console.error(error);
  process.exit(3);
}

const getChosenTag = (listOfTags) => callFzf(listOfTags);

const getChosenFile = (listOfRelevantFiles) => callFzf(listOfRelevantFiles);

const openFileAndExit = (file) => {
  return promSpawn(`vi ${file}`, { shell: true });
};

const tee = (something) => {
  console.log(something);
  return something;
};

const getChosenLang = () => {
  const allLangs = getAllLangs();
  return callFzf(allLangs).
    then(i => i.out);
};

const findFzf = () => {
  return promSpawn("which fzf", { shell: true });
};


Promise.resolve().
  then(setGlobalCODEX_ROOT).
  catch(cantFindCodexRootBailOut).
  then(findFzf).
  then(cmdResponseIsSaneP).
  catch(cantFindFzfBailOut).
  then(openDatabaseAndSetGlobalDB).
  catch(cantOpenDBBailOut).
  then(getLanguage).
  catch(getChosenLang).
  then(setGlobalLANG).
  then(_ => getAllTagsForLang(LANG)).
  then(getChosenTag).
  then(cmdResponseIsSaneP).
  catch(noFzfSelectionBailOut).
  then(({out}) => getRelevantFiles(out)).
  then(getChosenFile).
  then(cmdResponseIsSaneP).
  catch(noFzfSelectionBailOut).
  then(({out}) => console.log(out));

