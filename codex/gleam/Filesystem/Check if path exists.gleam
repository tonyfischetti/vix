// gleam, filesystem, check if path exists, check if file exists, is_file, is_directory, home directory, simplifile, stat

// gleam add simplifile envoy

import envoy
import simplifile

pub fn main() {
  // (`gleam run` always runs from the top of the project, so these two
  // are there for any project)
  let does_exist = "gleam.toml"
  let doesnt_exist = "gleam.tomlllll"

  // doesn't have to be an absolute path
  assert simplifile.is_file(does_exist) == Ok(True)
  assert simplifile.is_file(doesnt_exist) == Ok(False)

  assert simplifile.is_directory("src") == Ok(True)
  assert simplifile.is_directory(doesnt_exist) == Ok(False)

  // it's there, but it's not a directory
  assert simplifile.is_directory(does_exist) == Ok(False)

  // there's no function for the home directory. it's in the environment
  let assert Ok(home) = envoy.get("HOME")
  assert simplifile.is_directory(home) == Ok(True)
  //  NOTE  `Ok(False)` means it isn't there. an `Error` means it couldn't
  //        find out (no permission to look, for one)
}
