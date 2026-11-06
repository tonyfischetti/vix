// gleam, strings, string length, byte size, graphemes, is_empty, empty string

import gleam/string

pub fn main() {
  let str = "Hello"

  assert string.length(str) == 5

  // it counts what a person would call characters (graphemes), however
  // many code points or bytes each one takes. see "Unicode awareness"
  let accented = "e\u{0301}"
  assert string.length(accented) == 1

  // the number of bytes (UTF-8)
  assert string.byte_size(str) == 5
  assert string.byte_size(accented) == 3

  assert string.is_empty("")
  assert !string.is_empty(str)
  //  NOTE  `length` has to walk the whole string to count. `byte_size` and
  //        `is_empty` don't
}
