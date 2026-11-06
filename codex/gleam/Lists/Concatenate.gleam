// gleam, lists, concat, append, flatten, combine two lists, spread

import gleam/list

pub fn main() {
  let part1 = ["red", "orange", "yellow"]
  let part2 = ["green", "blue", "indigo", "violet"]

  let rainbow = list.append(part1, part2)
  assert rainbow
    == ["red", "orange", "yellow", "green", "blue", "indigo", "violet"]

  // any number of lists
  assert list.flatten([["infrared"], part1, part2, ["ultraviolet"]])
    == [
      "infrared", "red", "orange", "yellow", "green", "blue", "indigo", "violet",
      "ultraviolet",
    ]

  // the spread syntax only puts single elements in front of ONE list
  assert ["infrared", ..rainbow]
    == [
      "infrared", "red", "orange", "yellow", "green", "blue", "indigo", "violet",
    ]
  // [..part1, ..part2]   <- not allowed
}
