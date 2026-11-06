// gleam, functions, labelled arguments, named parameters, keyword arguments, label shorthand, argument order

import gleam/string

pub fn main() {
  // with labels the arguments can go in any order...
  assert replace(in: "Hello", each: "l", with: "L") == "HeLLo"
  assert replace(each: "l", with: "L", in: "Hello") == "HeLLo"

  // ...and they're optional: positional still works
  assert replace("Hello", "l", "L") == "HeLLo"

  // positional first and labels for the rest is what you want for pipes
  assert "Hello" |> replace(each: "l", with: "L") == "HeLLo"

  // when a variable has the same name as the label, `width:` is short for
  // `width: width`
  let width = 7
  let fill = "_"
  assert pad("Hello", width:, fill:) == "__Hello"
}

// two names per argument: the label the CALLER writes, then the name used
// inside the function. so the call reads like a sentence and the body still
// has sensible variable names
fn replace(
  in string: String,
  each pattern: String,
  with replacement: String,
) -> String {
  string.replace(in: string, each: pattern, with: replacement)
}

// when one name does for both, it's written twice. the first argument has
// no label, so it's always positional
fn pad(string: String, width width: Int, fill fill: String) -> String {
  string.pad_start(string, to: width, with: fill)
}
