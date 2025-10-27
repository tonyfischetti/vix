#!/usr/bin/env -S NODE_OPTIONS='--no-warnings' node


import * as fs          from 'node:fs/promises';
import * as path        from 'node:path';
import * as os          from 'node:os';
import { DatabaseSync } from 'node:sqlite';
import { consola }      from 'consola';
import { TacitPromise } from 'taciturn';


/***************************************************************
  * sqlite statements
  */

const createTablesSQL = `
  DROP TABLE IF EXISTS files;
  DROP TABLE IF EXISTS tags;
  CREATE TABLE files (
    fileID INTEGER PRIMARY KEY,
    relPath TEXT,
    subDir TEXT);
  CREATE TABLE tags (
    tag TEXT,
    fileID INTEGER REFERENCES files);`;

const createTables = db => { db.exec(createTablesSQL); return db };

const insertFileSQL = `
  INSERT INTO files (fileID, relPath, subDir)
    VALUES (?, ?, ?)`;

const insertTagSQL = `
  INSERT INTO tags (tag, fileID)
    VALUES (?, ?)`;


/***************************************************************/

const log = (message, fn=consola.info) => {
  return (arg) => {
    fn(message);
    return arg;
  }
};

const pathExistsP = (apath) => {
  // console.log(`checking ${apath}`);
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

// a function that takes an exit code and returns a closure that takes
// an Error, prints it, and exits with the exit code
const printErrorAndBailOut = (exitCode, customMessage) => {
  return (error) => {
    customMessage ? consola.error(customMessage) : consola.error(error.message);
    // if (DEBUG) console.error(error);
    process.exit(exitCode);
  };
};

const removeOldDB = fs.rm;

const fatalCantFindCodexRoot  = printErrorAndBailOut(1);
const fatalCantOpenDB         = printErrorAndBailOut(2);

const getCodexRoot = () => {
  const CODEX_ROOT = process.env["CODEX_ROOT"] ?? "";
  if (CODEX_ROOT === "") throw Error("Environment variable 'CODEX_ROOT' not defined");
  return CODEX_ROOT;
};

const updateBlacklistPaths = (pathRoot, { blacklistedPaths }) => {
  return blacklistedPaths.map(_ => `${pathRoot}/${_}`);
}

const createDB = (fn) => {
  try {
    return new DatabaseSync(fn);
  } catch (error) {
    throw Error(`unable to open database: ${error}`);
  }
}

const getAllFilesRecursively = (root) => {
  return fs.readdir(root, { withFileTypes: true, recursive: true });
};

const filesOnly = i => i.isFile() && !i.name.match(/^\./);

const notBlacklistedP = (i, _, { blacklistedPaths }) => {
  return !blacklistedPaths.some(bl => i.fullPath.match(bl));
}

const addAltPathsAsKey = (fileObj, _, { codexRoot }) => {
  const fullPath = path.join(fileObj.parentPath, fileObj.name);
  const relPath  = path.relative(codexRoot, fullPath);
  const subDir   = relPath.split(path.sep)[0];
  return {
    ...fileObj,
    fullPath,
    relPath,
    subDir
  };
};

const addFirstLineAsKey = (fileObj) => {
  return fs.readFile(fileObj.fullPath, 'utf-8').
    then(contents => contents.split(os.EOL)[0]).
    then(firstLine => {
      return {
        ...fileObj,
        firstLine
      };
    });
}

const addTags = (fileObj, _, { commentChars }) => {
  const removeComment = (astring) => {
    commentChars.forEach((cc) => {
      astring = astring.replace(new RegExp(`^\\s*${cc}\\s+`), "");
    });
    return astring;
  };

  const tags = [fileObj.subDir, ...removeComment(fileObj.firstLine).split(/\s*,\s*/)];
  return {
    ...fileObj,
    tags: [...new Set(tags)]
  };
};

const addAFileID = (fileObj, i) => {
  return {
    ...fileObj,
    fileID: i
  };
};

const insertFile = (fileObj, _, { db }) => {
  const { fileID, relPath, subDir } = fileObj;
  const insertFileStm = db.prepare(insertFileSQL);
  insertFileStm.run(fileID, relPath, subDir);
  return fileObj
};

const insertTags = (fileObj, _, { db }) => {
  const { fileID, tags } = fileObj;
  const insertTagStm = db.prepare(insertTagSQL);
  tags.forEach(tag => {
    if (tag !== "") insertTagStm.run(tag, fileID)
  });
  return fileObj
};

const closeDB = ({ db }) => { db.close(); }

/***************************************************************/

/* starting context */
const context = {
  DEBUG: false,
  commentChars: [ "#", "//", ";", "--" ],
  blacklistedPaths: ["node_modules", "make-db.js", "package.json",
                     "make-codex-db.js", "package-lock.json", "codex.db",
                     "cdx.js", "codex.js", "TOC.md", "another.js"]
};

/***************************************************************/

TacitPromise.create(context).
  then(log("making codex SQLite DB", consola.box)).

  then(getCodexRoot).
    catch(fatalCantFindCodexRoot).
    tap("codexRoot").

  then(updateBlacklistPaths).
    tap("blacklistedPaths").

  focus('codexRoot').
    then(root => `${root}/codex.db`).
    tap("codexDBPath").
  
  when(pathExistsP, removeOldDB).

  then(log("creating sqlite db")).
    then(createDB).
    catch(fatalCantOpenDB).
    tap('db').
    then(createTables).

  focus('codexRoot').
    then(getAllFilesRecursively).
    filter(filesOnly).
    map(addAltPathsAsKey).
    filter(notBlacklistedP).

  then(log("parsing tags")).
    map(addFirstLineAsKey, { concurrency: 10 }).
    map(addTags).
    map(addAFileID).

  then(log("inserting tags and files")).
    map(insertFile).
    map(insertTags).

  finally(closeDB).
  
  catch(consola.error).
  then(log("done", consola.success));

