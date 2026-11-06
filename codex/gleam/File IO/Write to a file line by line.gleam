// gleam, file io, open file, write to a file line by line, write stream, file_streams, close file, each, forEach, cli arguments, append

// gleam add file_streams argv

import argv
import file_streams/file_open_mode
import file_streams/file_stream
import gleam/io
import gleam/list

pub fn main() {
  let assert [output_file, ..] = argv.load().arguments as "which file?"
  let write_these_lines = [
    "Twinkle twinkle little bat",
    "How I wonder what you're at",
  ]

  // opened to add to the end. `Write` instead of `Append` would empty
  // the file first
  let assert Ok(stream) = file_stream.open(output_file, [file_open_mode.Append])

  list.each(write_these_lines, fn(line) {
    let assert Ok(Nil) = file_stream.write_chars(stream, line <> "\n")
  })

  let assert Ok(Nil) = file_stream.close(stream)
  io.println("done!")
  //  NOTE  when all the lines are already in hand, join them and write the
  //        file in one go (see "Write to a file all at once")
  //
  //          simplifile.write(output_file, string.join(lines, "\n") <> "\n")
}
