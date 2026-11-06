// gleam, file io, read a file line by line, read stream, file_streams, open file, close file, cli arguments, end of file, eof, recursion, line count

// gleam add file_streams argv

import argv
import file_streams/file_stream.{type FileStream}
import file_streams/file_stream_error
import gleam/int
import gleam/io

pub fn main() {
  let assert [input_file, ..] = argv.load().arguments as "which file?"

  let assert Ok(stream) = file_stream.open_read(input_file)
  let line_count = count_lines(stream, 0)
  let assert Ok(Nil) = file_stream.close(stream)

  io.println("line count: " <> int.to_string(line_count))
}

// only one line is in memory at a time. the "\n" is still on the end of it
fn count_lines(stream: FileStream, count: Int) -> Int {
  case file_stream.read_line(stream) {
    Ok(_line) -> count_lines(stream, count + 1)
    Error(file_stream_error.Eof) -> count
    Error(error) -> panic as file_stream_error.describe(error)
  }
}
//  NOTE  this is for files too big to hold in memory. otherwise it's less
//        bother to read the whole thing and split it (see "Read file all
//        at once")
