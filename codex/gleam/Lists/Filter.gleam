// gleam, lists, filter, remove-if-not, remove-if, partition, filter_map, index and value, anaphors

import gleam/int
import gleam/list
import gleam/pair
import gleam/string

pub fn main() {
  let rainbow = ["red", "orange", "yellow", "green", "blue", "indigo", "violet"]

  assert list.filter(rainbow, string.contains(_, "r"))
    == ["red", "orange", "green"]

  // remove-if: negate the predicate
  assert list.filter(rainbow, fn(color) { !string.contains(color, "r") })
    == ["yellow", "blue", "indigo", "violet"]

  // both halves at once
  assert list.partition(rainbow, string.contains(_, "r"))
    == #(["red", "orange", "green"], ["yellow", "blue", "indigo", "violet"])

  // filter and transform in one pass: keeps what's inside the `Ok`s
  assert list.filter_map(["1", "two", "3"], int.parse) == [1, 3]

  // the predicate only gets the value. to filter on the index as well,
  // pair each element with its index first
  let numbers = [1, 2, 3, 4, 5, 4, 3, 2, 1]
  assert numbers
    |> list.index_map(fn(value, index) { #(value, index) })
    |> list.filter(fn(entry) { entry.0 % 3 == 0 && entry.1 % 3 == 0 })
    |> list.map(pair.first)
    == [3]
}
