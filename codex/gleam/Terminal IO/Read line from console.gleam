// gleam, terminal io, read line from console, stdin, prompt, user input, readline, read until end of input

// gleam add input

import gleam/int
import gleam/io
import gleam/string
import input

pub fn main() {
  // prints the prompt and waits for a line. the newline is taken off
  case input.input(prompt: "say what?: ") {
    Ok(say_what) -> io.println("what: " <> string.uppercase(say_what))
    // the end of the input (ctrl-d, or a pipe that ran dry)
    Error(Nil) -> io.println("\nnothing to say?")
  }

  // everything else on stdin, a line at a time
  let line_count = count_lines(0)
  io.println(int.to_string(line_count) <> " more lines")
}

fn count_lines(count: Int) -> Int {
  case input.input(prompt: "") {
    Ok(_line) -> count_lines(count + 1)
    Error(Nil) -> count
  }
}
