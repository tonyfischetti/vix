// gleam, math, absolute value, abs, negate, distance between two numbers

import gleam/float
import gleam/int

pub fn main() {
  let n = -11

  assert int.absolute_value(n) == 11
  assert float.absolute_value(-1.5) == 1.5

  // how far apart two numbers are
  assert int.absolute_value(3 - 10) == 7

  // flip the sign
  assert int.negate(n) == 11
  assert -n == 11
}
