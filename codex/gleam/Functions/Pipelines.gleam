// gleam, functions, pipe, pipeline, pipe operator, threading operator, method chaining, function capture

import gleam/int
import gleam/list
import gleam/string

pub fn main() {
  // without pipes you read from the inside out
  let nested =
    string.join(list.map(string.split("a,b,c", on: ","), string.uppercase), "-")
  assert nested == "A-B-C"

  // `a |> f(b)` means `f(a, b)`. the left side becomes the FIRST argument
  let piped =
    "a,b,c"
    |> string.split(on: ",")
    |> list.map(string.uppercase)
    |> string.join("-")
  assert piped == "A-B-C"

  // a function that takes nothing else doesn't need the parentheses
  assert "  hello  " |> string.trim |> string.uppercase == "HELLO"

  // to pipe into some other position, mark it with `_`
  assert "World" |> string.append("Hello, ", _) == "Hello, World"

  // this is what there is instead of method chaining. it's why functions
  // in the standard library take "the thing they work on" first
  let total =
    ["1", "2", "x", "4"]
    |> list.filter_map(int.parse)
    |> list.map(fn(n) { n * 10 })
    |> int.sum
  assert total == 70
}
