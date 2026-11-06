// gleam, strings, string interpolation, concatenation, template strings, format, string builder, string_tree, inspect

import gleam/float
import gleam/int
import gleam/string
import gleam/string_tree

pub fn main() {
  let str = "Hello"

  // there's no interpolation and there are no format strings. it's `<>`
  assert str <> ", World" == "Hello, World"

  // and only strings go in, so everything else gets converted
  let bats = 3
  assert "there are " <> int.to_string(bats) <> " bats" == "there are 3 bats"
  assert "about " <> float.to_string(1.618) == "about 1.618"

  // `string.inspect` for anything else (it prints it like source code)
  assert "got " <> string.inspect(#(1, [2.0])) == "got #(1, [2.0])"

  // a lot of pieces
  assert string.concat(["Twinkle", " ", "twinkle"]) == "Twinkle twinkle"
  assert string.join(["little", "bat"], with: " ") == "little bat"

  // building a big string bit by bit: a StringTree doesn't copy anything
  // until you ask for the string
  let tree =
    string_tree.new()
    |> string_tree.append("How I wonder")
    |> string_tree.append(" what you're at")
    |> string_tree.prepend("> ")
  assert string_tree.to_string(tree) == "> How I wonder what you're at"
}
