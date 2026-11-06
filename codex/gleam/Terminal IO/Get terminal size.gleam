// gleam, terminal io, terminal size, window size, rows, columns, width, height, tput cols, center text, horizontal rule, full width

// gleam add term_size

import gleam/int
import gleam/io
import gleam/result
import gleam/string
import term_size

fn center(text: String, width: Int) -> String {
  let margin = int.max(0, { width - string.length(text) } / 2)
  string.repeat(" ", margin) <> text
}

pub fn main() {
  assert center("tea", 9) == "   tea"

  // rows first
  case term_size.get() {
    Ok(#(rows, columns)) ->
      io.println(
        int.to_string(columns) <> " columns, " <> int.to_string(rows) <> " rows",
      )
    // there's no terminal to measure (a cron job, or a program with its
    // input and its output both piped)
    Error(Nil) -> io.println("no terminal")
  }

  // or one at a time. it's a Result, so decide what to fall back on
  let width = term_size.columns() |> result.unwrap(80)

  // a line across the whole window, and a title in the middle of it
  io.println(string.repeat("─", width))
  io.println(center("A Mad Tea-Party", width))
  io.println(string.repeat("─", width))
  //  NOTE  it's measured when you ask. ask again after the window has
  //        been resized
}
