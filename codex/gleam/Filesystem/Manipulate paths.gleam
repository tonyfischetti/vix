// gleam, filesystem, manipulate paths, join paths, normalize paths, basename, dirname, extname, file extension, isAbsolute, split a path, absolute path, filepath

// gleam add filepath simplifile

import filepath
import gleam/list
import simplifile

pub fn main() {
  let afile =
    "/home/tony/Desktop/Carlos IV/Backups/Pictures/Cool Pictures/Breakfast Club.gif"

  assert filepath.base_name(afile) == "Breakfast Club.gif"
  assert filepath.directory_name(afile)
    == "/home/tony/Desktop/Carlos IV/Backups/Pictures/Cool Pictures"

  // the extension comes without its dot, and there might not be one
  assert filepath.extension(afile) == Ok("gif")
  assert filepath.extension("/home/tony/.zshrc") == Error(Nil)
  assert filepath.extension("archive.tar.gz") == Ok("gz")

  // the name without the extension
  assert afile |> filepath.base_name |> filepath.strip_extension
    == "Breakfast Club"

  assert filepath.is_absolute(afile)
  assert !filepath.is_absolute("tony/.zshrc")

  // it takes care of the slashes in between
  assert filepath.join("/home/tony", ".zshrc") == "/home/tony/.zshrc"
  assert filepath.join("/home/tony/", ".zshrc") == "/home/tony/.zshrc"

  // more than two pieces: fold
  assert list.fold(["tony", ".zsh", ".zshrc"], "/home", filepath.join)
    == "/home/tony/.zsh/.zshrc"

  assert filepath.split("/home/tony/.zshrc") == ["/", "home", "tony", ".zshrc"]

  // normalize (this only looks at the text, not at the disk)
  assert filepath.expand("/home/tony/../tony/.zsh/bin/.././.zshrc")
    == Ok("/home/tony/.zsh/.zshrc")
  // (an Error if it would climb out of the top)
  assert filepath.expand("../../etc") == Error(Nil)

  // relative to absolute (this one does look at the disk: it has to exist)
  let assert Ok(cwd) = simplifile.current_directory()
  assert simplifile.resolve("src/../gleam.toml")
    == Ok(filepath.join(cwd, "gleam.toml"))
}
