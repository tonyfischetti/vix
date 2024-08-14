#!/usr/bin/env node


import * as fs    from 'node:fs/promises';
import * as os    from 'node:os';
import * as path  from 'node:path';

import * as rmrf  from 'rimraf';
import Database   from 'better-sqlite3';


const CODEX_ROOT = process.env["CODEX_ROOT"];

if (CODEX_ROOT === undefined || CODEX_ROOT === "") {
  console.log("Environment variable 'CODEX_ROOT` not defined");
  process.exit(1);
}


const blacklistedPaths = [
  "node_modules",
  "make-db.js",
  "package.json",
  "package-lock.json",
  "codex.db",
  "cdx.js",
  "codex.js",
  "TOC.md",
].map(i => `${CODEX_ROOT}/${i}`);

const commentChars = [
  "#", "//", ";", "--"
];





const createSQL = `
  DROP TABLE IF EXISTS files;
  DROP TABLE IF EXISTS tags;
  CREATE TABLE files (
    fileID INTEGER PRIMARY KEY,
    relPath TEXT,
    subDir TEXT);
  CREATE TABLE tags (
    tag TEXT,
    fileID INTEGER REFERENCES files);`;

const insertFileSQL = `
  INSERT INTO files (fileID, relPath, subDir)
    VALUES (?, ?, ?)`;

const insertTagSQL = `
  INSERT INTO tags (tag, fileID)
    VALUES (?, ?)`;






const createDB = () => { db.exec(createSQL) };

const getAllFilesRecursively = () => {
  return fs.readdir(CODEX_ROOT, { withFileTypes: true, recursive: true });
};

const filterOnlyFiles = (lst) => lst.filter(i => i.isFile());

const addAltPathsAsKeys = (listOfFiles) => {
  const addAltPathsAsKey = (fileObj) => {
    const fullPath = `${fileObj.parentPath}/${fileObj.name}`
    const relPath  = path.relative(CODEX_ROOT, fullPath);
    //const subDir = path.dirname(relPath);
    const subDir   = relPath.split(path.sep)[0];
    return {
      ...fileObj,
      fullPath,
      relPath,
      subDir
    };
  };

  return listOfFiles.map(addAltPathsAsKey);
};


const filterNonBlacklisted = (lst) => {
  const isBlacklistedP = ({fullPath}) => {
    return !blacklistedPaths.some(bl => fullPath.match(`${bl}`));
  }

  return lst.filter(isBlacklistedP);
};

const addFirstLinesAsKeys = (listOfFiles) => {
  const addFirstLineAsKey = (fileObj) => {
    return fs.readFile(fileObj.fullPath, 'utf-8').
      then(contents => contents.split(os.EOL)[0]).
      then(firstLine => {
        return {
          ...fileObj,
          firstLine: firstLine
        };
      });
  };

  return Promise.all(listOfFiles.map(addFirstLineAsKey));
};

const addTags = (listOfFiles) => {
  const removeComment = (astring) => {
    commentChars.forEach((cc) => {
      astring = astring.replace(new RegExp(`^${cc}\\s+`), "");
    });
    return astring;
  };

  return listOfFiles.map(i => {
    const tags = [i.subDir, ...removeComment(i.firstLine).split(/\s*,\s*/)];
    return {
      ...i,
      tags: [...new Set(tags)]
    };
  });
};

const addFilesIDs = (listOfFiles) => {
  let counter = 1;
  const addFileID = (fileObj) => {
    return {
      ...fileObj,
      fileID: counter++
    };
  };

  return listOfFiles.map(addFileID);
}

const insertAllFiles = (listOfFiles) => {
  const insertFileStm = db.prepare(insertFileSQL);
  listOfFiles.forEach(({fileID, relPath, subDir}) => {
    insertFileStm.run(fileID, relPath, subDir);
  });
  return listOfFiles;
}

const insertAllTags = (listOfFiles) => {
  const insertTagStm = db.prepare(insertTagSQL);
  listOfFiles.forEach(({fileID, tags}) => {
    tags.forEach(tag => {
      if (tag != "") insertTagStm.run(tag, fileID)
    });
  });
  return listOfFiles;
}

const tee = (listOfFiles) => {
  console.log(listOfFiles);
  return listOfFiles;
};

rmrf.rimrafSync("codex.db")
const db = new Database('codex.db');

Promise.resolve().
  then(createDB).
  then(getAllFilesRecursively).
  then(filterOnlyFiles).
  then(addAltPathsAsKeys).
  then(filterNonBlacklisted).
  then(addFirstLinesAsKeys).
  then(addTags).
  then(addFilesIDs).
  then(insertAllFiles).
  then(insertAllTags).
  then(tee);


