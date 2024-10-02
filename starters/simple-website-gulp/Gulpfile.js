'use strict';

import 'dotenv/config';
import gulp           from 'gulp';
import nunjucksRender from 'gulp-nunjucks-render';
import prettier       from 'gulp-prettier';
import less           from 'gulp-less';
import shell          from 'shelljs';
import ts             from 'gulp-typescript';
import cache          from 'gulp-cache';
import browserSync    from 'browser-sync';
import imagemin,
  { mozjpeg }         from 'gulp-imagemin';

const tsProject = ts.createProject("tsconfig.json");
const { series, parallel, src, dest, watch } = gulp;
const server = browserSync.create();


export const clean = (cb) => {
  shell.rm('-rf', 'dist');
  return cb();
};

export const mrproper = (cb) => {
  return cache.clearAll(cb);
};

export const moveRootThings = () => {
  return src('root/**/*.*', { encoding: false }).
    pipe(dest('dist/'));
};

export const moveJS = () => {
  return tsProject.
    src().
    pipe(tsProject()).
    js.
    pipe(dest("dist/js"));
};

/**
 * If you want to bundle with ESBuild
 *
 * import gulpEsbuild    from 'gulp-esbuild';
 * export const moveJS = () => {
 *   return src('src/main.ts').
 *     pipe(gulpEsbuild({
 *       outfile: 'bundle.js',
 *       bundle: true,
 *       loader: { '.tsx': 'tsx', },
 *     })).
 *     pipe(dest('dist/js/'));
 * };
 */


export const moveHTML = () => {
  return src("pages/**/*.+(html|njk)").
    pipe(nunjucksRender({ path: ['templates'], envOptions: { trimBlocks: true, } })).
    pipe(prettier()).
    pipe(dest('dist/'));
};

export const moveCSS = () => {
  return src("styles/less/**/*.+(less|css)").
    pipe(less({ paths: "styles/includes/" })).
    pipe(dest('dist/styles/'));
};

export const moveImages = () => {
  return src('assets/images/**/*.+(png|jpg|gif|svg)', { encoding: false }).
    pipe(cache(imagemin([
      mozjpeg({quality: 75, progressive: true}),
    ], { verbose: true }))).
    pipe(dest('dist/assets/images/'));
};


const reload = (cb) => {
  server.reload();
  return cb();
}

export const serve = (cb) => {
  server.init({
    server: {
      baseDir: 'dist'
    }
  });
  return cb();
}

export const monitor = () => {
  const andReload = (fn) => series(fn, reload);
  watch('root/**/*',          andReload(moveRootThings));
  watch('src/**/*',           andReload(moveJS));
  watch('pages/**.*',         andReload(moveHTML));
  watch('templates/**.*',     andReload(moveHTML));
  watch('styles/less/**.*',   andReload(moveCSS));
  watch('assets/images/**/*', andReload(moveImages));
};



export const build = series(clean,
                            parallel(moveRootThings,
                                     moveJS,
                                     moveCSS,
                                     moveHTML,
                                     moveImages),
                            reload,
                            serve,
                            monitor);

const defaultTask = build;
export default defaultTask;
