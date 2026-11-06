// gleam, lists, list destructuring, pattern matching, car, cdr, cadr, first, rest, head, tail, spread, let assert

import gleam/int
import gleam/list

pub fn main() {
  let part1 = ["red", "orange", "yellow"]
  let part2 = ["green", "blue", "indigo", "violet"]
  let rainbow = list.append(part1, part2)

  // `let assert` because this pattern doesn't match every list
  // (it crashes on a list with fewer than three elements)
  let assert [car, cadr, caddr, ..rest] = rainbow
  assert car == "red"
  assert cadr == "orange"
  assert caddr == "yellow"
  assert rest == ["green", "blue", "indigo", "violet"]

  // you can skip elements
  let nums = [1, 2, 3, 4, 5]
  let assert [one, _, three, _, five] = nums
  assert #(one, three, five) == #(1, 3, 5)

  // or ignore everything after the ones you want
  let assert [first, ..] = nums
  assert first == 1

  // the safe way is `case`, which makes you handle every shape
  assert describe([]) == "empty"
  assert describe([1]) == "just 1"
  assert describe(nums) == "1, then 4 more"

  // the spread only works at the END of a list (it's how you prepend)
  assert [0, ..nums] == [0, 1, 2, 3, 4, 5]
  // [..part1, ..part2]   <- not allowed. use list.append(part1, part2)
}

fn describe(nums: List(Int)) -> String {
  case nums {
    [] -> "empty"
    [only] -> "just " <> int.to_string(only)
    [first, ..rest] ->
      int.to_string(first)
      <> ", then "
      <> int.to_string(list.length(rest))
      <> " more"
  }
}
