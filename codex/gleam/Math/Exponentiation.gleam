// gleam, math, pow, power, exponentiation, square root, sqrt, cube root, nth root, exponential

// gleam add gleam_community_maths    (only for the nth root)

import gleam/float
import gleam/int
import gleam_community/maths

pub fn main() {
  // there's no `**`. the exponent is a Float and so is the answer, even
  // for `int.power`
  assert int.power(2, of: 4.0) == Ok(16.0)
  assert float.power(2.0, of: 4.0) == Ok(16.0)
  assert float.power(4.0, of: 0.5) == Ok(2.0)

  assert int.square_root(4) == Ok(2.0)
  assert float.square_root(4.0) == Ok(2.0)
  assert maths.nth_root(27.0, 3) == Ok(3.0)

  // they're Results because some of the answers aren't (real) numbers
  assert float.square_root(-1.0) == Error(Nil)
  assert float.power(-8.0, of: 0.5) == Error(Nil)
  assert float.power(0.0, of: -1.0) == Error(Nil)

  // back to an Int
  let assert Ok(power) = int.power(2, of: 10.0)
  assert float.round(power) == 1024

  // e to the x
  assert float.exponential(0.0) == 1.0
}
