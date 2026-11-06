// gleam, lists, iota, range, sequence, int.range, yielder, step

// gleam add gleam_yielder    (only for the last example)

import gleam/int
import gleam/list
import gleam/yielder

pub fn main() {
  // `int.range` is a fold over the numbers `from` (inclusive) up to `to`
  // (exclusive). counting DOWN and prepending leaves the list in order
  let range = int.range(from: 9, to: -1, with: [], run: list.prepend)
  assert range == [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

  // counting up and prepending gives it to you backwards
  let range2 = int.range(from: 1, to: 10, with: [], run: list.prepend)
  assert range2 == [9, 8, 7, 6, 5, 4, 3, 2, 1]

  assert iota(5, from: 0, by: 1) == [0, 1, 2, 3, 4]
  assert iota(5, from: 10, by: 5) == [10, 15, 20, 25, 30]

  // often you don't need the list at all: do the work in the fold
  assert int.range(from: 1, to: 11, with: 0, run: int.add) == 55

  // a lazy range (both ends inclusive), for when it's big or infinite
  assert yielder.range(from: 0, to: 4) |> yielder.to_list == [0, 1, 2, 3, 4]
  assert yielder.iterate(1, fn(n) { n * 2 })
    |> yielder.take(8)
    |> yielder.to_list
    == [1, 2, 4, 8, 16, 32, 64, 128]
}

/// `length` numbers, starting at `start`, `step` apart
fn iota(length: Int, from start: Int, by step: Int) -> List(Int) {
  int.range(from: length - 1, to: -1, with: [], run: fn(acc, i) {
    [start + i * step, ..acc]
  })
}
