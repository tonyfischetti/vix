import * as proc from 'node:child_process';

/*
 * TEST.SH
 * #!/bin/bash
 * 
 * echo twinkle
 * sleep 1
 * echo twinkle
 * sleep 1
 * echo little
 * sleep 1
 * echo bat
 * sleep 1
 * echo How I wonder what youre at 1>&2
 */

/* ***** `spawn` is asychronous ***** */
const com = proc.spawn('./test.sh');
// in this case, equivalent to
// const com = proc.execFile('./test.sh');

com.on('spawn', () => console.log(`PID: ${com.pid}`));

com.stdout.on('data', (data) => {
  console.log(`new stdout: ${data.toString().trim()}`);
});

com.stderr.on('data', (data) => {
  console.log(`new stderr: ${data.toString().trim()}`);
});

com.on('close', (code, signal) => {
  // only one of these will be null / non-null
  console.log(`process exited with code ${code}`);
  console.log(`process exited with signal ${signal}`);
});

/*
 * You can send a signal to the subprocess like so
 * com.kill("SIGHUP");
 */

/*
 * proc.spawn(command, [args], {options});
 * options include...
 *   - cwd  (default: `pwd`)
 *   - env  (default: process.env)
 *   - stdio (default: pipe)
 *     * pipe
 *     * ipc
 *         (enables parent to theprocs.send() and theproc.disconnect()
 *          and child to register to 'message' and 'disconnect' events)
 *     * inherit
 *   - detached (default: false)
 *   - shell (default: false | if true, unix default: /bin/sh) [SEE BELOW]
 *   - timeout (default: undefined)
 *       milliseconds to wait before child gets options killSignal
 *       (which defaults to SIGTERM)
 *
 * `{shell: true}` allows the usage of shell "nice-to-haves" like
 *  pipes, filename wildcards, environment variable expansion, and
 * expansion of ~ to a user’s home directory
 * For example, the following line won't work, but the one that follows will
 * const pl = proc.spawn("ls", ["~"], {shell: false});
 * const pl = proc.spawn("ls", ["~"], {shell: true});
 * 
 */

     
/*
 * Other options...
 *
 *  --- ASYNCHRONOUS --------------------------------------
 * 
 *   child_process.exec(command[, options][, callback])
 * Spawns a shell then executes the command within that shell, buffering
 * any generated output. The command string passed to the exec function is
 * processed directly by the shell and special characters (vary based on
 * shell) need to be dealt with accordingly....
 * Instead of, for example ("ls", ["-al"]) {like in `spawn`}
 * you use the whole string: "ls -al"
 * It takes a callback with the following three args (error, stdout, stderr)
 *
 *   child_process.execFile(file[, args][, options][, callback])
 * The child_process.execFile() function is similar to child_process.exec()
 * except that it does not spawn a shell by default. Rather, the specified
 * executable file is spawned directly as a new process making it slightly
 * more efficient than child_process.exec().
 * 
 *   child_process.fork()
 * The child_process.fork() method is a special case of child_process.spawn()
 * used specifically to spawn new Node.js processes. Like
 * child_process.spawn(), a ChildProcess object is returned. The returned
 * ChildProcess will have an additional communication channel built-in that
 * allows messages to be passed back and forth between the parent and child.
 * See subprocess.send() for details.
 *
 *  --- SYNCHRONOUS --------------------------------------
 *
 *   child_process.spawnSync(command[, args][, options])
 * The child_process.spawnSync() method is generally identical to
 * child_process.spawn() with the exception that the function will not
 * return until the child process has fully closed. When a timeout has been
 * encountered and killSignal is sent, the method won't return until the
 * process has completely exited. If the process intercepts and handles the
 * SIGTERM signal and doesn't exit, the parent process will wait until the
 * child process has exited.
 * It returns an object with the following properties...
 *   {pid, output (array), stdout, stderr, status (exit code), signal, error}
 *
 * AND SO ON...
 *
 */
