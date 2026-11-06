// gleam, lists, finding elements in a list, find, find_map, index of, indexOf, lastIndexOf, key_find, recursion, guards, anaphors

import gleam/int
import gleam/list

pub fn main() {
  let numbers = [1, 2, 3, 4, 5, 4, 3, 2, 1]

  // the first element that satisfies the predicate
  // (the value, not the index)
  assert list.find(numbers, fn(n) { n > 3 }) == Ok(4)
  assert list.find(numbers, fn(n) { n > 30 }) == Error(Nil)

  // there's no `indexOf`. it's a short recursive function (below)
  assert index_of(numbers, 3) == Ok(2)
  assert index_of(numbers, 30) == Error(Nil)

  // `lastIndexOf`: keep overwriting the answer as you fold along
  assert list.index_fold(numbers, Error(Nil), fn(found, n, index) {
      case n == 3 {
        True -> Ok(index)
        False -> found
      }
    })
    == Ok(6)

  // find and transform at once: the first `Ok` that the function returns
  assert list.find_map(["x", "12", "y", "7"], int.parse) == Ok(12)

  // a list of pairs used as a little lookup table
  let paints = [#("red", "cadmium"), #("blue", "cobalt")]
  assert list.key_find(paints, "blue") == Ok("cobalt")
  assert list.key_find(paints, "green") == Error(Nil)
}

fn index_of(items: List(a), target: a) -> Result(Int, Nil) {
  index_of_loop(items, target, 0)
}

fn index_of_loop(items: List(a), target: a, index: Int) -> Result(Int, Nil) {
  case items {
    [] -> Error(Nil)
    [first, ..] if first == target -> Ok(index)
    [_, ..rest] -> index_of_loop(rest, target, index + 1)
  }
}
