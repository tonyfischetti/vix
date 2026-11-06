// gleam, filesystem, read directory, list files, recursive, find, ls, readdir, filter, map, file extension, simplifile

// gleam add simplifile filepath

import filepath
import gleam/io
import gleam/list
import simplifile

pub fn main() {
  // can handle spaces
  let look_in_this_directory = "src"

  // every FILE under it, however deep, as a path (not just the name)
  let assert Ok(files) = simplifile.get_files(in: look_in_this_directory)
  list.each(files, io.println)

  // only the gleam ones, and only their names
  files
  |> list.filter(fn(path) { filepath.extension(path) == Ok("gleam") })
  |> list.map(filepath.base_name)
  |> list.each(io.println)

  // one level only. these are bare names, and directories are in there too
  let assert Ok(entries) = simplifile.read_directory(at: ".")
  assert list.contains(entries, "gleam.toml")
  assert list.contains(entries, "src")

  assert simplifile.get_files(in: "no such directory")
    == Error(simplifile.Enoent)
}
