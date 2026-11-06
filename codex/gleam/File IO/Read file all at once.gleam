// gleam, file io, open file, read a file all at once, simplifile, cli arguments, character encoding, bytes read, end of line character, slurp, line count

// gleam add simplifile argv

import argv
import gleam/bit_array
import gleam/int
import gleam/io
import gleam/list
import gleam/string
import simplifile

pub fn main() {
  let assert [input_file, ..] = argv.load().arguments as "which file?"

  // the whole file as a String. it has to be UTF-8
  case simplifile.read(from: input_file) {
    Ok(contents) -> {
      let lines = string.split(contents, on: "\n")
      io.println("line count: " <> int.to_string(list.length(lines) - 1))
    }
    // the error says what happened: Enoent, Eacces, Eisdir, NotUtf8...
    Error(error) ->
      io.println_error(
        "can't read " <> input_file <> ": " <> simplifile.describe_error(error),
      )
  }

  // OR as bytes, for when it isn't text
  let assert Ok(bytes) = simplifile.read_bits(from: input_file)
  io.println("bytes read: " <> int.to_string(bit_array.byte_size(bytes)))
}
