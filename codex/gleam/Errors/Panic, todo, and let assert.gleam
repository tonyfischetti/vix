// gleam, errors, panic, todo, let assert, assert, crash, exceptions, unreachable, unwrap, runtime error, placeholder

// For when carrying on would make no sense. All of these crash, with the
// file and line number. They're for "this can't happen" and for scripts,
// not for errors you expect: those are Results.

import gleam/int

pub fn main() {
  // `let assert`: "I know this pattern matches. crash if I'm wrong"
  // (it's the `.unwrap()`)
  let assert Ok(n) = int.parse("42")
  assert n == 42

  // with a message for whoever has to read the crash
  let assert [first, ..] = [1, 2, 3] as "the list should never be empty here"

  // `assert`: crash unless this is True. tests are made out of these
  assert first == 1
  assert first < 10 as "first got too big somehow"

  assert weekday(1) == "Monday"
}

// `panic`: crash on purpose.
// a message that's built up needs the braces. without them `as` only grabs
// the first string
fn weekday(n: Int) -> String {
  case n {
    1 -> "Monday"
    2 -> "Tuesday"
    3 -> "Wednesday"
    4 -> "Thursday"
    5 -> "Friday"
    _ -> panic as { "not a weekday: " <> int.to_string(n) }
  }
}
//  NOTE  `todo` is `panic` for code you haven't written yet. it type checks
//        as anything at all, so the rest of the program compiles, and you
//        get a warning to remind you
//
//          fn weekend(n: Int) -> String {
//            todo as "weekends"
//          }
