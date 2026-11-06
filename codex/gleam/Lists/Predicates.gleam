// gleam, lists, list predicates, any, all, contains, some, every, includes, count, function capture, anaphors

import gleam/list
import gleam/string

pub fn main() {
  let rainbow = ["red", "orange", "yellow", "green", "blue", "indigo", "violet"]

  // `string.contains(_, "r")` is a function capture. it's short for
  // `fn(color) { string.contains(color, "r") }`
  assert list.all(rainbow, fn(color) { string.length(color) >= 3 })
  assert !list.all(rainbow, string.contains(_, "r"))
  assert list.any(rainbow, string.contains(_, "r"))
  assert !list.any(rainbow, string.contains(_, "z"))

  assert list.contains(rainbow, "red")
  assert !list.contains(rainbow, "RED")

  // how many satisfy it
  assert list.count(rainbow, string.contains(_, "r")) == 3
}
