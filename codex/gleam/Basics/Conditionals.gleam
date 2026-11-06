// gleam, basics, conditionals, case, if else, else if, elif, elseif, ternary operator, switch case, guards, pattern matching, bool.guard, early return

import gleam/bool
import gleam/int
import gleam/io

pub fn main() {
  let between_1_and_10 = 7
  let yes_or_no = "yes"

  // there's no `if`. a two way choice is a `case` on a Bool
  case between_1_and_10 > 5 {
    True -> io.println("> 5")
    False -> io.println("<= 5")
  }

  // `case` is an expression, so this is also the ternary
  let size = case between_1_and_10 > 5 {
    True -> "big"
    False -> "small"
  }
  assert size == "big"

  // if / else if / else: guards. the first clause that matches wins
  let range = case between_1_and_10 {
    n if n > 6 -> "7+"
    n if n <= 4 -> "4-"
    _ -> "between 4 and 7"
  }
  assert range == "7+"

  // switch-case. there's no fall-through: alternatives are spelled out
  // with `|`
  let answer = case yes_or_no {
    "yes" | "y" -> "yes, indeed"
    "no" | "n" -> "no, indeed"
    _ -> "idk"
  }
  assert answer == "yes, indeed"

  assert fizzbuzz(9) == "Fizz"
  assert fizzbuzz(10) == "Buzz"
  assert fizzbuzz(15) == "FizzBuzz"
  assert fizzbuzz(16) == "16"

  assert describe(-5) == "negative"
  assert describe(0) == "zero"
  assert describe(5) == "positive"
  //  NOTE  the compiler checks that a `case` covers every possible value.
  //        `_` is the catch-all
}

// matching on more than one value at once
fn fizzbuzz(n: Int) -> String {
  case n % 3, n % 5 {
    0, 0 -> "FizzBuzz"
    0, _ -> "Fizz"
    _, 0 -> "Buzz"
    _, _ -> int.to_string(n)
  }
}

// an early return is `bool.guard` with `use`
fn describe(n: Int) -> String {
  use <- bool.guard(when: n < 0, return: "negative")
  use <- bool.guard(when: n == 0, return: "zero")
  "positive"
}
