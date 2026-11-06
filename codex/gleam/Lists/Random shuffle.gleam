// gleam, lists, random shuffle, shuffle a list, sample, random element, fisher-yates

import gleam/list
import gleam/string

pub fn main() {
  let rainbow = ["red", "orange", "yellow", "green", "blue", "indigo", "violet"]

  // returns a new list. `rainbow` is unmodified
  let shuffled = list.shuffle(rainbow)
  echo shuffled

  // same elements, some other order
  assert list.sort(shuffled, string.compare)
    == list.sort(rainbow, string.compare)

  // n random elements
  let three = list.sample(rainbow, 3)
  echo three
  assert list.length(three) == 3

  // one random element (a Result, in case the list is empty)
  echo rainbow |> list.sample(1) |> list.first
}
