// gleam, lists, reduce, fold, fold_right, foldl, foldr, accumulator, initial value, scan, min max

import gleam/int
import gleam/list

type MinMax {
  MinMax(min: Int, max: Int)
}

pub fn main() {
  let numbers = [0, 1, 2, 3, 4, 5, 6, 7]

  // `fold` always takes the starting value for the accumulator
  assert list.fold(numbers, 0, fn(acc, n) { acc + n }) == 28
  // (for this one in particular there's `int.sum(numbers)`)

  // `reduce` uses the first element as the starting value, so it returns a
  // Result: there's nothing to give back for an empty list
  assert list.reduce(numbers, fn(acc, n) { acc + n }) == Ok(28)
  assert list.reduce([], fn(acc, n) { acc + n }) == Error(Nil)

  let rainbow = ["red", "orange", "yellow"]
  assert list.reduce(rainbow, fn(acc, color) { acc <> ", " <> color })
    == Ok("red, orange, yellow")

  // from the right
  assert list.fold_right(rainbow, "", fn(acc, color) { acc <> color <> " " })
    == "yellow orange red "

  // folding a list back into a list: prepend, and it comes out reversed
  assert list.fold(numbers, [], fn(acc, n) { [n * n, ..acc] })
    == [49, 36, 25, 16, 9, 4, 1, 0]

  // `scan` is `fold` that keeps all the intermediate values
  assert list.scan([1, 2, 3, 4, 5], 0, fn(acc, n) { acc + n })
    == [1, 3, 6, 10, 15]

  assert find_min_max([10, 8, 20, 3, 17, 19]) == Ok(MinMax(min: 3, max: 20))
  assert find_min_max([]) == Error(Nil)
}

// there's no Infinity to start from, so the first element is the seed
fn find_min_max(numbers: List(Int)) -> Result(MinMax, Nil) {
  case numbers {
    [] -> Error(Nil)
    [first, ..rest] ->
      Ok(
        list.fold(rest, MinMax(min: first, max: first), fn(acc, n) {
          MinMax(min: int.min(acc.min, n), max: int.max(acc.max, n))
        }),
      )
  }
}
