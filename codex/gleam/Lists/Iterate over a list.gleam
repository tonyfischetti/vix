// gleam, lists, loop through a list, each, for each, index and value, entries, index_fold, use, anaphors

import gleam/int
import gleam/io
import gleam/list

pub fn main() {
  let rainbow = ["red", "orange", "yellow", "green", "blue", "indigo", "violet"]

  // run a function for its side effects on every element
  list.each(rainbow, fn(color) { io.println("  - " <> color) })

  // with the index: fold with nothing (Nil) to accumulate
  list.index_fold(rainbow, Nil, fn(_, color, index) {
    io.println("  - [" <> int.to_string(index) <> "] => '" <> color <> "'")
  })

  // `use` turns the rest of the block into the callback. reads like a
  // `for ... of` loop
  use color <- list.each(rainbow)
  io.println(color <> "!")
}
