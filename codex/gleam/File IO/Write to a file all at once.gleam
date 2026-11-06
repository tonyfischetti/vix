// gleam, file io, open file, write to a file all at once, simplifile, cli arguments, overwrite, create a file, character encoding, barf

// gleam add simplifile argv

import argv
import gleam/io
import simplifile

pub fn main() {
  let assert [output_file, ..] = argv.load().arguments as "which file?"

  // creates the file, or replaces everything that was in it
  let assert Ok(Nil) =
    simplifile.write(to: output_file, contents: "  - Mad Hatter\n")

  // or, adds to the end (also creates it if it isn't there)
  let assert Ok(Nil) =
    simplifile.append(to: output_file, contents: "  - March Hare\n")

  assert simplifile.read(output_file) == Ok("  - Mad Hatter\n  - March Hare\n")
  io.println("done!")
  //  NOTE  for bytes instead of a String: `write_bits` and `append_bits`
}
