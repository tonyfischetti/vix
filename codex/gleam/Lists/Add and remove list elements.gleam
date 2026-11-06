// gleam, lists, push, pop, unshift, shift, prepend, append, cons, add an element to a list, remove an element from a list, delete

// Nothing is modified in place: all of these give you a new list.
// The FRONT of a list is cheap to work on. The END means copying it.

import gleam/list

pub fn main() {
  let rainbow = ["orange", "yellow", "green"]

  // add to the END (`push`)
  let rainbow =
    list.append(rainbow, ["blue", "indigo", "violet", "ultraviolet"])

  // remove from the END (`pop`)
  let assert [last, ..reversed] = list.reverse(rainbow)
  let rainbow = list.reverse(reversed)
  assert last == "ultraviolet"
  assert rainbow == ["orange", "yellow", "green", "blue", "indigo", "violet"]

  // add to the FRONT (`unshift`)
  let rainbow = ["infrared", "red", ..rainbow]
  // (same thing as a function, for pipelines: `list.prepend(rainbow, "red")`)

  // remove from the FRONT (`shift`)
  let assert [first, ..rainbow] = rainbow
  assert first == "infrared"
  assert rainbow
    == ["red", "orange", "yellow", "green", "blue", "indigo", "violet"]

  // `let assert` crashes if the list is empty. when it might be, match both
  // cases (see `shift`, below)
  assert shift([1, 2, 3]) == Ok(#(1, [2, 3]))
  assert shift([]) == Error(Nil)

  // remove by value
  assert list.filter(rainbow, fn(color) { color != "indigo" })
    == ["red", "orange", "yellow", "green", "blue", "violet"]
  //  NOTE  when building a list up in a loop, prepend and `list.reverse`
  //        once at the end. appending each time copies the list each time
}

fn shift(items: List(a)) -> Result(#(a, List(a)), Nil) {
  case items {
    [] -> Error(Nil)
    [first, ..rest] -> Ok(#(first, rest))
  }
}
