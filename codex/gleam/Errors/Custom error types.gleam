// gleam, errors, exceptions, custom errors, error types, throw, raise, catch, replace_error, map_error, describe an error

import gleam/int
import gleam/result
import gleam/string

/// One type, with a variant for each thing that can go wrong, each carrying
/// whatever details are worth having
pub type TonyError {
  DivideByZero
  NotANumber(input: String)
  TooBig(value: Int, limit: Int)
}

pub fn main() {
  assert divide_10_by("5") == Ok(2)
  assert divide_10_by("0") == Error(DivideByZero)
  assert divide_10_by("five") == Error(NotANumber("five"))
  assert divide_10_by("500") == Error(TooBig(value: 500, limit: 100))

  // the caller can tell them apart, and the compiler checks that none
  // were forgotten
  let message = case divide_10_by("five") {
    Ok(n) -> int.to_string(n)
    Error(error) -> "Tony Error: " <> describe(error)
  }
  assert message == "Tony Error: \"five\" isn't a number"
}

fn divide_10_by(input: String) -> Result(Int, TonyError) {
  // `int.parse` fails with Nil. swap that for one of ours
  use x <- result.try(
    int.parse(input) |> result.replace_error(NotANumber(input)),
  )
  case x {
    0 -> Error(DivideByZero)
    _ if x > 100 -> Error(TooBig(value: x, limit: 100))
    _ -> Ok(10 / x)
  }
}

fn describe(error: TonyError) -> String {
  case error {
    DivideByZero -> "can't divide by zero"
    NotANumber(input:) -> string.inspect(input) <> " isn't a number"
    TooBig(value:, limit:) ->
      int.to_string(value) <> " is over the limit of " <> int.to_string(limit)
  }
}
//  NOTE  when a function calls things that fail with different error types,
//        give your type a variant that wraps each of them...
//
//          pub type AppError {
//            FileError(simplifile.FileError)
//            JsonError(json.DecodeError)
//          }
//
//        ...and convert as you go, with `result.map_error(FileError)`
