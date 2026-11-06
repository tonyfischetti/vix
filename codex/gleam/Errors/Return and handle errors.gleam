// gleam, errors, exceptions, throw, raise, catch, try catch block, error handling, result, ok, error, unwrap, result.try, result.map, result.all

// There are no exceptions to throw or catch. A function that can fail
// returns a Result, which is `Ok(value)` or `Error(reason)`, and the caller
// has to do something about both.

import gleam/int
import gleam/io
import gleam/result

pub fn main() {
  assert divide_10_by(5) == Ok(2)
  assert divide_10_by(0) == Error("can't divide by zero")

  // the try/catch is a `case`
  case divide_10_by(0) {
    Ok(n) -> io.println(int.to_string(n))
    Error(_) -> io.println("nope")
  }

  // fall back to a default
  assert result.unwrap(divide_10_by(0), or: 0) == 0

  // change what's in the Ok, and pass an Error along untouched
  assert divide_10_by(5) |> result.map(fn(n) { n * 100 }) == Ok(200)
  assert divide_10_by(0) |> result.map(fn(n) { n * 100 })
    == Error("can't divide by zero")

  // the first one that worked
  assert result.or(divide_10_by(0), divide_10_by(2)) == Ok(5)

  // a list of Results into a Result of a list (all or nothing)...
  assert result.all([divide_10_by(1), divide_10_by(2)]) == Ok([10, 5])
  assert result.all([divide_10_by(1), divide_10_by(0)])
    == Error("can't divide by zero")
  // ...or just the ones that worked
  assert result.values([divide_10_by(1), divide_10_by(0)]) == [10]

  // several steps that can each fail
  assert parse_and_divide("5") == Ok(2)
  assert parse_and_divide("0") == Error("can't divide by zero")
  assert parse_and_divide("five") == Error("not a number: five")
}

fn divide_10_by(x: Int) -> Result(Int, String) {
  case x {
    0 -> Error("can't divide by zero")
    _ -> Ok(10 / x)
  }
}

// `result.try` runs the rest of the function only if the step was `Ok`.
// on an `Error` the function returns that error on the spot, like a throw
// (see "Use expressions"). the error types have to agree, so the Nil that
// `int.parse` fails with gets replaced with a String
fn parse_and_divide(input: String) -> Result(Int, String) {
  use x <- result.try(
    int.parse(input) |> result.replace_error("not a number: " <> input),
  )
  divide_10_by(x)
}
