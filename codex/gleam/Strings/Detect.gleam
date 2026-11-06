// gleam, strings, detect, contains, starts_with, ends_with, match, regex, regexp, case-insensitive regex, compile a regex

// gleam add gleam_regexp

import gleam/regexp
import gleam/result
import gleam/string

pub fn main() {
  let str = "Hello"

  // the simple cases don't need a regex
  assert string.contains(str, "ell")
  assert string.starts_with(str, "He")
  assert string.ends_with(str, "lo")
  assert !string.contains(str, "HELL")

  // regular expressions are a package. there are no regex literals: you
  // compile one from a string (so a backslash has to be doubled, "\\d+")
  // and get a Result back
  let assert Ok(re) = regexp.from_string("Hel{2}")
  assert regexp.check(re, str)

  // case insensitive
  let options = regexp.Options(case_insensitive: True, multi_line: False)
  let assert Ok(re) = regexp.compile("HeL", with: options)
  assert regexp.check(re, str)

  // a bad pattern is an Error (that says what's wrong, and where)
  assert result.is_error(regexp.from_string("[0-9"))
}
