// gleam, strings, padding strings, pad_start, pad_end, padStart, padEnd, zero padding, leading zeros

import gleam/int
import gleam/string

pub fn main() {
  let str = "Hello"

  // you always say what to pad with
  assert string.pad_start(str, to: 7, with: " ") == "  Hello"
  assert string.pad_start(str, to: 7, with: "_") == "__Hello"
  assert string.pad_end(str, to: 7, with: " ") == "Hello  "

  // it never cuts anything off
  assert string.pad_start(str, to: 3, with: "_") == "Hello"

  // leading zeros on a number
  assert 7 |> int.to_string |> string.pad_start(to: 3, with: "0") == "007"
}
