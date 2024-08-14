#!/usr/bin/env node
// vi: ft=javascript

/* TODO:
 *
 *   - check for fzf
 *   - check for no lang
 *
 */

import * as proc  from 'node:child_process';
import Database   from 'better-sqlite3';


const CODEX_ROOT = process.env["CODEX_ROOT"];

if (CODEX_ROOT === undefined || CODEX_ROOT === "") {
  console.log("Environment variable 'CODEX_ROOT` not defined");
  process.exit(1);
}

const db = new Database(`${CODEX_ROOT}/codex.db`, {readonly: true, fileMustExist: true});

const lang = process.argv[2] ?? "";

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
  const stm = db.prepare(q);
  const r = stm.all();
  return r.map(i => i.subDir);
};

const getAllTagsForLang = (subDir) => {
  const q = `
    SELECT DISTINCT tags.tag
      FROM files
        INNER JOIN tags USING (fileID)
      WHERE subDir=?`;
  const r = db.prepare(q).bind(subDir);
  return r.all().map(i => i.tag);
};

const getRelevantFiles = (atag) => {
  const q = `
    SELECT DISTINCT files.relPath
      FROM files
        INNER JOIN tags USING (fileID)
        WHERE tag=?`;
  const r = db.prepare(q).bind(atag);
  return r.all().map(i => i.relPath);
};

const callFzf = (listOfOptions) => {
  const combedOptions = listOfOptions.join('\n');
  return promSpawn(`printf '${combedOptions}' | fzf -1`, { shell: true });
};

const cmdResponseIsSaneP = (cmdResponse) => {
  if (cmdResponse.code !== 0)
    throw Error("no result from fzf");
  return cmdResponse;
};

const relayErrorAndExit = (error) => {
  console.error(error);
  process.exit(1);
}

const getChosenTag = (listOfTags) => callFzf(listOfTags);

const getChosenFile = (listOfRelevantFiles) => callFzf(listOfRelevantFiles);

const openFileAndExit = (file) => {
  return promSpawn(`vi ${file}`, { shell: true });
};


Promise.resolve().
  then(_ => getAllTagsForLang(lang)).
  then(getChosenTag).
  then(cmdResponseIsSaneP).
  catch(relayErrorAndExit).
  then(({out}) => getRelevantFiles(out)).
  then(getChosenFile).
  then(cmdResponseIsSaneP).
  catch(relayErrorAndExit).
  then(({out}) => console.log(out));



