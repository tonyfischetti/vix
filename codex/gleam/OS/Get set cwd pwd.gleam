// gleam, os, current working directory, cwd, chdir, change directory, getwd, pwd, absolute path, run a command in a directory

// gleam add simplifile filepath shellout

import filepath
import gleam/string
import shellout
import simplifile

pub fn main() {
  let assert Ok(cwd) = simplifile.current_directory()
  echo cwd
  // "/Users/tony/projects/thing"

  // a relative path, against it
  echo filepath.join(cwd, "src")
  assert simplifile.resolve("src") == Ok(filepath.join(cwd, "src"))

  // there's nothing for changing it. the working directory belongs to the
  // whole VM, not to your bit of code, so the habit is to pass paths
  // around. the usual reason to `cd` is to run something somewhere, and
  // that's an argument
  let assert Ok(output) =
    shellout.command(run: "pwd", with: [], in: "src", opt: [])
  assert string.ends_with(string.trim(output), "/src")
  //  NOTE  if you really have to, Erlang can
  //
  //          @external(erlang, "file", "set_cwd")
  //          fn set_cwd(path: String) -> Dynamic
}
