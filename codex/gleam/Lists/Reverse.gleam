// gleam, lists, reverse a list

import gleam/list

pub fn main() {
  let rainbow = ["red", "orange", "yellow", "green", "blue", "indigo", "violet"]

  let reversed = list.reverse(rainbow)
  assert reversed
    == ["violet", "indigo", "blue", "green", "yellow", "orange", "red"]

  // nothing is ever reversed in place: `rainbow` is unchanged
  assert list.first(rainbow) == Ok("red")
}
