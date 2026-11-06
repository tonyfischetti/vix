// gleam, os, process, system, run system command, shell, spawn, exec, exit code, stdout, stderr, capture output, which, environment, shellout

// gleam add shellout

import gleam/result
import gleam/string
import shellout

pub fn main() {
  // run it, wait for it, get what it printed.
  // the command, its arguments, the directory to run it in, and options
  assert shellout.command(run: "echo", with: ["twinkle"], in: ".", opt: [])
    == Ok("twinkle\n")

  // an exit code other than 0 is an Error, with the code and the output.
  // stderr is captured along with stdout
  let script = "echo little bat; echo How I wonder 1>&2; exit 3"
  assert shellout.command(run: "sh", with: ["-c", script], in: ".", opt: [])
    == Error(#(3, "little bat\nHow I wonder\n"))

  // there's no shell in between, so no pipes, no wildcards, no `~` and no
  // $VARIABLES...
  let assert Error(#(_code, complaint)) =
    shellout.command(run: "ls", with: ["~"], in: ".", opt: [])
  assert string.contains(complaint, "No such file or directory")

  // ...unless what you run IS a shell
  assert shellout.command(
      run: "sh",
      with: ["-c", "echo twinkle twinkle | wc -w"],
      in: ".",
      opt: [],
    )
    |> result.map(string.trim)
    == Ok("2")

  // environment variables for the command
  let env = shellout.SetEnvironment([#("GREETING", "howdy")])
  assert shellout.command(
      run: "sh",
      with: ["-c", "echo $GREETING"],
      in: ".",
      opt: [env],
    )
    == Ok("howdy\n")

  // let the output go straight to the terminal (as it happens) instead of
  // collecting it
  assert shellout.command(
      run: "echo",
      with: ["how I wonder what you're at"],
      in: ".",
      opt: [shellout.LetBeStdout],
    )
    == Ok("")

  // a command that doesn't exist is an Error too
  assert shellout.command(run: "dimension_x", with: [], in: ".", opt: [])
    == Error(#(1, "command `./dimension_x` not found\n"))

  // is it installed, and where?
  assert shellout.which("sh") == Ok("/bin/sh")
  assert shellout.which("dimension_x")
    == Error("command `dimension_x` not found\n")
  //  NOTE  this blocks until the command is done. to carry on with other
  //        things in the meantime, run it in another process (see
  //        "Processes and messages")
}
