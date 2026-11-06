// gleam, lists, join, join list elements, string.join, intersperse

import gleam/int
import gleam/list
import gleam/string

pub fn main() {
  let rainbow = ["red", "orange", "yellow", "green", "blue", "indigo", "violet"]

  assert string.join(rainbow, with: ", ")
    == "red, orange, yellow, green, blue, indigo, violet"

  // only strings can be joined. anything else gets converted first
  assert [1, 2, 3] |> list.map(int.to_string) |> string.join("-") == "1-2-3"

  // no separator
  assert string.concat(["a", "b", "c"]) == "abc"
}
