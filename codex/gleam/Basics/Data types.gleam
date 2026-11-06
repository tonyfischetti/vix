// gleam, basics, data types, int, float, string, bool, nil, list, tuple, bit array, function type, type annotations, type conversion, inspect

import gleam/float
import gleam/int
import gleam/string

pub fn main() {
  // Int and Float are different types and never convert on their own
  let whole: Int = 850
  let fraction: Float = 1.618

  // always double quotes, always UTF-8, can span lines
  let text: String = "Twinkle twinkle little bat"

  let yes: Bool = True

  // Nil is what a function returns when it has nothing to say (like
  // `io.println`). it is NOT null: a String can never be Nil
  let nothing: Nil = Nil

  // a list: any length, one element type
  let many: List(Int) = [1, 2, 3]

  // a tuple: fixed length, any mix of types
  let pair: #(Int, String) = #(1, "one")

  // raw bytes
  let bytes: BitArray = <<255, 216, 255>>

  // functions are values, and have types too
  let double: fn(Int) -> Int = fn(n) { n * 2 }
  assert double(21) == 42

  // converting is always explicit
  assert int.to_float(whole) == 850.0
  assert float.round(fraction) == 2
  assert float.truncate(fraction) == 1
  assert int.to_string(whole) == "850"
  assert float.to_string(fraction) == "1.618"

  // `string.inspect` turns ANY value into text (the way you'd write it in
  // Gleam source)
  assert string.inspect(text) == "\"Twinkle twinkle little bat\""
  assert string.inspect(yes) == "True"
  assert string.inspect(nothing) == "Nil"
  assert string.inspect(many) == "[1, 2, 3]"
  assert string.inspect(pair) == "#(1, \"one\")"
  assert string.inspect(bytes) == "<<255, 216, 255>>"
  //  NOTE  you make your own types with `type` (see "Custom types and
  //        records"). Result and Option are just two of those
}
