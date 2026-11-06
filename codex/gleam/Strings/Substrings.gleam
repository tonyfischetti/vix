// gleam, strings, substring, slice, drop_start, drop_end, first, last, prefix, suffix, pattern matching on strings, string indexing

import gleam/string

pub fn main() {
  let str = "Hello"

  // a start index and a LENGTH (not an end index)
  assert string.slice(str, at_index: 0, length: 4) == "Hell"
  assert string.slice(str, at_index: 3, length: 2) == "lo"

  // a negative index counts from the end
  assert string.slice(str, at_index: -2, length: 2) == "lo"

  // chop some off either end
  assert string.drop_start(str, up_to: 3) == "lo"
  assert string.drop_end(str, up_to: 1) == "Hell"

  // the first and last character (Results: the string might be empty)
  assert string.first(str) == Ok("H")
  assert string.last(str) == Ok("o")
  assert string.first("") == Error(Nil)

  // a known prefix or suffix
  assert string.remove_prefix("Hello, Joe", "Hello, ") == "Joe"
  assert string.remove_suffix("pluto-p.png", ".png") == "pluto-p"

  // from a substring onwards
  assert string.crop("Hello, World", before: "World") == "World"

  // a prefix can also be matched as a pattern, binding what's left
  assert greeted("Hello, Joe") == Ok("Joe")
  assert greeted("Goodbye, Joe") == Error(Nil)
}

fn greeted(message: String) -> Result(String, Nil) {
  case message {
    "Hello, " <> name -> Ok(name)
    _ -> Error(Nil)
  }
}
