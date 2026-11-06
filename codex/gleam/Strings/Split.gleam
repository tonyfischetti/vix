// gleam, strings, splitting strings, split, split_once, regex, regexp, split on whitespace, split into lines, split into characters, graphemes

// gleam add gleam_regexp    (only for the regex ones)

import gleam/regexp
import gleam/string

pub fn main() {
  assert string.split("a,b,c", on: ",") == ["a", "b", "c"]

  // every occurrence splits, so two in a row leave an empty string
  assert string.split("Hello", on: "l") == ["He", "", "o"]

  // on a regex
  let assert Ok(ls) = regexp.from_string("l+")
  assert regexp.split(ls, "Hello") == ["He", "o"]

  // case insensitive
  let options = regexp.Options(case_insensitive: True, multi_line: False)
  let assert Ok(ls) = regexp.compile("L+", with: options)
  assert regexp.split(ls, "Hello") == ["He", "o"]

  // only at the first one
  assert string.split_once("key=value=more", on: "=")
    == Ok(#("key", "value=more"))
  assert string.split_once("no equals sign", on: "=") == Error(Nil)

  // into characters
  assert string.to_graphemes("Hello") == ["H", "e", "l", "l", "o"]

  // into lines
  assert string.split("Twinkle\ntwinkle\nlittle bat", on: "\n")
    == ["Twinkle", "twinkle", "little bat"]

  // on runs of whitespace (trim first, or the ends give you empty strings)
  let assert Ok(whitespace) = regexp.from_string("\\s+")
  assert regexp.split(whitespace, string.trim("  How I   wonder\t"))
    == ["How", "I", "wonder"]
}
