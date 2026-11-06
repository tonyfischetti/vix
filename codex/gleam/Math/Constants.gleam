// gleam, math, mathematical constants, pi, e, tau, golden ratio

// gleam add gleam_community_maths

import gleam/float
import gleam_community/maths

pub fn main() {
  // nothing in the standard library. they're functions in this package
  assert maths.pi() == 3.141592653589793
  assert maths.tau() == 6.283185307179586
  assert maths.e() == 2.718281828459045
  assert maths.golden_ratio() == 1.618033988749895

  // `e` without the package
  assert float.exponential(1.0) == maths.e()
}
