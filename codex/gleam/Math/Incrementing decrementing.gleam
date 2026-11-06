// gleam, math, increment, decrement, counter, immutable, rebinding, accumulator

import gleam/list

pub fn main() {
  // no `++`, `--`, `+=` or `-=`: nothing can be changed in place.
  // you make a new binding (it can have the same name)
  let i = 0
  let i = i + 1
  assert i == 1
  let i = i - 1
  assert i == 0

  // a counter in a loop is an accumulator instead: the "next value" is
  // what the function returns
  let count = list.fold(["a", "b", "c"], 0, fn(count, _) { count + 1 })
  assert count == 3
}
