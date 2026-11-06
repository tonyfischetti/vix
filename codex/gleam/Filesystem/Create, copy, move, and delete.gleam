// gleam, filesystem, create directory, mkdir, mkdir -p, copy file, cp, move, rename, mv, delete, rm, rm -rf, temporary directory, touch, simplifile

// gleam add simplifile envoy filepath

import envoy
import filepath
import gleam/result
import simplifile

pub fn main() {
  // there's no function for the temp directory. ask the environment
  let tmp = envoy.get("TMPDIR") |> result.unwrap("/tmp")
  let dir = filepath.join(tmp, "codex-example")

  // (in case an earlier run left it behind. the result is ignored on
  // purpose: it's an Error when there's nothing to delete)
  let _ = simplifile.delete(dir)

  // mkdir -p
  let assert Ok(Nil) = simplifile.create_directory_all(dir <> "/a/b")
  assert simplifile.is_directory(dir <> "/a/b") == Ok(True)

  // plain mkdir won't make the parents, and won't make it twice
  assert simplifile.create_directory(dir <> "/x/y") == Error(simplifile.Enoent)
  assert simplifile.create_directory(dir <> "/a") == Error(simplifile.Eexist)

  // touch
  let original = dir <> "/a/hatter.txt"
  let assert Ok(Nil) = simplifile.create_file(original)
  let assert Ok(Nil) = simplifile.write(original, "  - Mad Hatter\n")

  // cp
  let copy = dir <> "/a/b/hatter-copy.txt"
  let assert Ok(Nil) = simplifile.copy_file(at: original, to: copy)
  assert simplifile.read(copy) == Ok("  - Mad Hatter\n")

  // mv (works on files and on directories)
  let moved = dir <> "/hare.txt"
  let assert Ok(Nil) = simplifile.rename(at: copy, to: moved)
  assert simplifile.is_file(copy) == Ok(False)
  assert simplifile.is_file(moved) == Ok(True)

  // cp -r
  let assert Ok(Nil) =
    simplifile.copy_directory(at: dir <> "/a", to: dir <> "/c")
  assert simplifile.is_file(dir <> "/c/hatter.txt") == Ok(True)

  // rm
  let assert Ok(Nil) = simplifile.delete_file(moved)

  //  WARN  rm -rf. `delete` takes a file OR a whole directory with
  //        everything in it
  let assert Ok(Nil) = simplifile.delete(dir)
  assert simplifile.is_directory(dir) == Ok(False)
}
