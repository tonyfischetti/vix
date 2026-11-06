// gleam, functions, functional, compose, function composition, higher-order functions, fold_right, pipe

import gleam/list
import gleam/string

pub fn main() {
  // most of the time you don't compose, you pipe
  let shout = fn(s) {
    s |> string.trim |> string.uppercase |> string.append("!")
  }
  assert shout("  hello ") == "HELLO!"

  // but to make one function out of a list of them...
  let shout2 = compose([string.append(_, "!"), string.uppercase, string.trim])
  assert shout2("  hello ") == "HELLO!"

  // two functions whose types line up (String -> String, then String -> Int)
  let trimmed_length = and_then(string.trim, string.length)
  assert trimmed_length("  hello ") == 5
}

/// Right to left, like in maths: `compose([f, g, h])(x)` is `f(g(h(x)))`.
/// They all have to have the same type, since a list holds one type
fn compose(functions: List(fn(a) -> a)) -> fn(a) -> a {
  fn(input) { list.fold_right(functions, input, fn(acc, f) { f(acc) }) }
}

/// Left to right, for two functions of different types
fn and_then(first: fn(a) -> b, second: fn(b) -> c) -> fn(a) -> c {
  fn(input) { second(first(input)) }
}
