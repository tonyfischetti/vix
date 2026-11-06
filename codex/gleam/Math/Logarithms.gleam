// gleam, math, logarithms, natural logarithm, log2, log10, log base, exponentiation, exponential

// gleam add gleam_community_maths    (for bases other than e)

import gleam/float
import gleam_community/maths

pub fn main() {
  // the natural logarithm is in the standard library
  assert float.logarithm(float.exponential(3.0)) == Ok(3.0)

  // a Result, because there's no logarithm of zero or of a negative number
  assert float.logarithm(0.0) == Error(Nil)

  assert maths.logarithm_2(16.0) == Ok(4.0)
  assert maths.logarithm_10(1000.0) == Ok(3.0)

  // any base
  assert maths.logarithm(81.0, 3.0) == Ok(4.0)
}
