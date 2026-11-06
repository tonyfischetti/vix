// gleam, basics, operators, arithmetic, float operators, comparison, equality, booleans, boolean operators, string concatenation, pipe, division by zero

import gleam/int
import gleam/string

pub fn main() {
  let seven = 7
  let seven_point = 7.0

  // Int arithmetic
  assert seven + 2 == 9
  assert seven - 2 == 5
  assert seven * 2 == 14
  assert seven / 2 == 3
  assert seven % 2 == 1

  // Float arithmetic has its own operators, with a dot.
  // `7.0 + 2.0` and `7 + 2.0` are type errors
  assert seven_point +. 2.0 == 9.0
  assert seven_point -. 2.0 == 5.0
  assert seven_point *. 2.0 == 14.0
  assert seven_point /. 2.0 == 3.5

  // comparing numbers: same split
  assert seven > 2 && seven >= 7 && 2 < seven && 7 <= seven
  assert seven_point >. 2.0 && seven_point >=. 7.0
  assert 2.0 <. seven_point && 7.0 <=. seven_point

  // == and != work on any type (both sides have to be the same type) and
  // compare by value, all the way down
  let nested = #("a", [1, 2, 3])
  assert nested == #("a", [1, 2, 3])
  assert nested != #("a", [1, 2, 4])

  // booleans. && and || short circuit
  let yes = True
  assert yes && !False
  assert False || yes

  // strings
  assert "Hello, " <> "World" == "Hello, World"

  // the pipe: the left side becomes the FIRST argument of the right side
  assert "hello" |> string.uppercase |> string.append("!") == "HELLO!"

  //  WARN  dividing by zero doesn't crash. the answer is 0
  assert seven / 0 == 0
  assert seven_point /. 0.0 == 0.0
  // if you'd rather know about it...
  assert int.divide(seven, by: 0) == Error(Nil)
  //  NOTE  there's no ++ or +=, no ternary, and no operator overloading
}
