// gleam, strings, trim, strip, whitespace, trim_start, trim_end, collapse whitespace, chomp

// gleam add gleam_regexp    (only for the last one)

import gleam/regexp
import gleam/string

pub fn main() {
  let str = "  \t Hello \n"

  assert string.trim(str) == "Hello"
  assert string.trim_start(str) == "Hello \n"
  assert string.trim_end(str) == "  \t Hello"

  // the trims only know about whitespace. for anything else, there's
  // `remove_prefix` and `remove_suffix`
  assert "--Hello" |> string.remove_prefix("--") == "Hello"

  // squeeze runs of whitespace down to one space
  let assert Ok(whitespace) = regexp.from_string("\\s+")
  assert regexp.replace(each: whitespace, in: "How  I \n wonder", with: " ")
    == "How I wonder"
}
