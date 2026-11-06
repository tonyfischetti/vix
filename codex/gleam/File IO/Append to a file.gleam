// gleam, file io, append to a file, simplifile, cli arguments, character encoding, error handling

// gleam add simplifile argv

import argv
import gleam/io
import simplifile

pub fn main() {
  let assert [output_file, ..] = argv.load().arguments as "which file?"

  // will create the file if it doesn't exist
  case simplifile.append(to: output_file, contents: "  - Mad Hatter\n") {
    Ok(Nil) -> io.println("done!")
    Error(error) ->
      io.println_error("nope: " <> simplifile.describe_error(error))
  }
}
