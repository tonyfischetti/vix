// gleam, lists, slice, take, drop, split, list subsetting, list indexing, multiple indices, take_while, drop_while

import gleam/list

pub fn main() {
  let rainbow = ["red", "orange", "yellow", "green", "blue", "indigo", "violet"]

  // the first n / everything but the first n
  assert list.take(rainbow, 2) == ["red", "orange"]
  assert list.drop(rainbow, 5) == ["indigo", "violet"]

  // slice(1, 3): drop up to the start, take the difference
  assert rainbow |> list.drop(1) |> list.take(2) == ["orange", "yellow"]

  // there are no negative indices. to count from the end, do the arithmetic
  let length = list.length(rainbow)
  // slice(-1)
  assert list.drop(rainbow, length - 1) == ["violet"]
  // slice(4, -1)
  assert rainbow |> list.drop(4) |> list.take(length - 4 - 1)
    == ["blue", "indigo"]

  // both sides of an index
  assert list.split(rainbow, at: 3)
    == #(["red", "orange", "yellow"], ["green", "blue", "indigo", "violet"])

  // with a predicate instead of a count
  let numbers = [1, 2, 3, 4, 5, 4, 3, 2, 1]
  assert list.take_while(numbers, fn(n) { n < 4 }) == [1, 2, 3]
  assert list.drop_while(numbers, fn(n) { n < 4 }) == [4, 5, 4, 3, 2, 1]
  assert list.split_while(numbers, fn(n) { n < 4 })
    == #([1, 2, 3], [4, 5, 4, 3, 2, 1])
}
