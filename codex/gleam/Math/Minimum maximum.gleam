// gleam, math, max, min, maximum, minimum, clamp, largest, smallest, do.call, apply

import gleam/float
import gleam/int
import gleam/list
import gleam/string

pub fn main() {
  // of two
  assert int.max(1, 2) == 2
  assert int.min(1, 2) == 1
  assert float.max(1.5, 2.5) == 2.5

  // of a list. Results, because an empty list has neither
  let tmp = [3, 1, 5, 2, 4]
  assert list.max(tmp, int.compare) == Ok(5)
  assert list.reduce(tmp, int.min) == Ok(1)
  assert list.max([], int.compare) == Error(Nil)

  // `list.max` takes a compare function, so it works on anything
  let rainbow = ["red", "orange", "yellow", "green"]
  assert list.max(rainbow, fn(a, b) {
      int.compare(string.length(a), string.length(b))
    })
    == Ok("orange")

  // keep a number inside a range
  assert int.clamp(15, min: 0, max: 10) == 10
  assert int.clamp(-5, min: 0, max: 10) == 0
  assert int.clamp(7, min: 0, max: 10) == 7
}
