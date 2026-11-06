// gleam, types, tuples, pair, destructuring, multiple return values, tuple access, swap

import gleam/pair

pub fn main() {
  let point = #(3, 4)
  let mixed = #("red", 255, True)

  // by position
  assert point.0 == 3
  assert mixed.1 == 255

  // destructuring
  let #(x, y) = point
  assert x + y == 7

  // the way to return more than one thing
  let #(quotient, remainder) = div_mod(17, 5)
  assert quotient == 3
  assert remainder == 2

  // helpers, for pairs
  assert pair.first(point) == 3
  assert pair.second(point) == 4
  assert pair.swap(point) == #(4, 3)
  assert pair.map_second(point, fn(n) { n * 10 }) == #(3, 40)
  //  NOTE  once there are more than two or three things in it, or it's
  //        getting passed around, a record with named fields is kinder
}

fn div_mod(a: Int, b: Int) -> #(Int, Int) {
  #(a / b, a % b)
}
