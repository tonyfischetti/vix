// gleam, functions, use, use expressions, callbacks, result.try, bool.guard, early return, callback hell, async await, do notation

// `use` is sugar for "the rest of this block is the callback"
//
//   use x <- f(a)        is        f(a, fn(x) {
//   more code                        more code
//                                  })
//
// It works with ANY function whose last argument is a function. It's how
// you stay out of a staircase of nested callbacks.

import gleam/bool
import gleam/int
import gleam/list
import gleam/result

pub fn main() {
  assert add_strings_nested("1", "2") == Ok(3)
  assert add_strings("1", "2") == Ok(3)
  assert add_strings("1", "two") == Error(Nil)

  assert safe_divide(10, 2) == Ok(5)
  assert safe_divide(10, 0) == Error("can't divide by zero")

  // it isn't only for errors. here the rest of the block is the function
  // handed to `list.map`
  let doubled = {
    use n <- list.map([1, 2, 3])
    n * 2
  }
  assert doubled == [2, 4, 6]
}

// without `use`, every step that can fail goes one level deeper
fn add_strings_nested(a: String, b: String) -> Result(Int, Nil) {
  result.try(int.parse(a), fn(x) {
    result.try(int.parse(b), fn(y) { Ok(x + y) })
  })
}

// with `use` it's flat, and reads like async/await.
// `result.try` only runs its callback (the rest of the function) for an
// `Ok`. on an `Error` it returns that error and we're done
fn add_strings(a: String, b: String) -> Result(Int, Nil) {
  use x <- result.try(int.parse(a))
  use y <- result.try(int.parse(b))
  Ok(x + y)
}

// `bool.guard`'s callback takes no arguments, so there's nothing in front
// of the arrow. this is the early return
fn safe_divide(a: Int, b: Int) -> Result(Int, String) {
  use <- bool.guard(when: b == 0, return: Error("can't divide by zero"))
  Ok(a / b)
}
