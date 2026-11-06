// gleam, functions, function capture, partial application, currying, underscore, placeholder, higher-order functions

import gleam/int
import gleam/list
import gleam/string

pub fn main() {
  // a `_` in a call makes a new one-argument function: "call this, with
  // the argument put where the hole is"
  let add_ten = int.add(10, _)
  assert add_ten(5) == 15

  // it's short for this
  let add_ten_long = fn(n) { int.add(10, n) }
  assert add_ten_long(5) == 15

  // the hole can be in any position (but there can only be one)
  let exclaim = string.append(_, "!")
  let greet = string.append("Hello, ", _)
  assert exclaim("Hello") == "Hello!"
  assert greet("Joe") == "Hello, Joe"

  // mostly you see it written right where it's used
  assert list.map(["a", "b"], string.append(_, "!")) == ["a!", "b!"]

  // and in pipelines, to pipe into something other than the first argument
  assert "Joe" |> string.append("Hello, ", _) == "Hello, Joe"

  // operators can't be captured. that's what `fn` is for
  assert list.filter([1, 5, 10], fn(n) { n > 3 }) == [5, 10]

  // functions are NOT curried. `int.add(10)` isn't a partial application,
  // it's a compile error. you can curry by hand, though
  let curried_add = fn(a) { fn(b) { a + b } }
  let add_one = curried_add(1)
  assert add_one(2) == 3
  assert curried_add(1)(2) == 3
}
