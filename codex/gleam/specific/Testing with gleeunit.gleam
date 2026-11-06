// gleam, testing, unit tests, gleeunit, assert, gleam test, test file, test runner

// gleam add --dev gleeunit      (`gleam new` already did)

// This is what goes in test/<project name>_test.gleam. `gleam test`
// runs its `main`, and gleeunit goes looking in every module under test/
// for public functions whose names end in `_test`.

import gleam/int
import gleam/list
import gleam/string
import gleeunit

pub fn main() -> Nil {
  gleeunit.main()
}

// a test passes if it doesn't crash. `assert` is how you make it crash
pub fn reverse_test() {
  assert list.reverse([1, 2, 3]) == [3, 2, 1]
}

// when one fails it shows the values on both sides of the `==`.
// a message is for saying what it means
pub fn parse_test() {
  assert int.parse("850") == Ok(850) as "plain digits should parse"
  assert int.parse("pp") == Error(Nil)
}

// `let assert` for when you need what's inside to carry on
pub fn split_test() {
  let assert Ok(#(key, value)) = string.split_once("color=red", on: "=")
  assert key == "color"
  assert value == "red"
}

// not a test (the name doesn't end in `_test`), just a helper
pub fn shout(string: String) -> String {
  string.uppercase(string) <> "!"
}

pub fn shout_test() {
  assert shout("moo") == "MOO!"
}
//  NOTE  $ gleam test
//        ....
//        4 passed, no failures
//
//        and a failure looks like this
//
//        assert test/my_project_test.gleam:20
//         test: my_project_test.reverse_test
//         code: assert list.reverse([1, 2, 3]) == [3, 2, 9]
//         left: [3, 2, 1]
//        right: [3, 2, 9]
//         info: Assertion failed.
//
//        the code being tested lives in src/ and gets imported like any
//        other module. test/ can have as many files and folders as you
//        like
