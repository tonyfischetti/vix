// gleam, strings, replace, capture, capture groups, regex, regexp, scan, submatches, match_map, backreference, replace first occurrence

// gleam add gleam_regexp

import gleam/option.{Some}
import gleam/regexp.{Match}
import gleam/string

pub fn main() {
  let str = "Hello"

  // a plain string replace does EVERY occurrence
  assert string.replace(in: str, each: "l", with: "L") == "HeLLo"

  // so does a regex one
  let assert Ok(ls) = regexp.from_string("l+")
  assert regexp.replace(each: ls, in: str, with: "*") == "He*o"

  // just the first: split once and put it back together
  let assert Ok(#(before, after)) = string.split_once(str, on: "l")
  assert before <> "L" <> after == "HeLlo"

  // capture groups. `scan` gives back every match, with its submatches
  let assert Ok(first_four) = regexp.from_string("^(.{4}).+$")
  assert regexp.scan(first_four, str)
    == [Match(content: "Hello", submatches: [Some("Hell")])]

  // ...which you take apart with a pattern
  let assert [Match(submatches: [Some(captured)], ..)] =
    regexp.scan(first_four, str)
  assert captured == "Hell"

  // using what was captured in the replacement: a function of the match
  let assert Ok(double_ls) = regexp.from_string("l{2}")
  assert regexp.match_map(double_ls, str, fn(match) {
      "_" <> match.content <> "_"
    })
    == "He_ll_o"
  //  WARN  a backreference in the replacement string works, but it's
  //        spelled differently on each target. `match_map` is the same
  //        everywhere
  //          regexp.replace(first_four, str, "\\1")    "Hell" on Erlang
  //          regexp.replace(first_four, str, "$1")     "Hell" on JavaScript
}
