// gleam, math, trigonometry, sin, cos, tan, asin, acos, atan, atan2, radians, degrees, mathematical constants

// gleam add gleam_community_maths

import gleam/float
import gleam_community/maths

pub fn main() {
  let pi = maths.pi()

  // radians, like everywhere else
  assert maths.sin(pi /. 2.0) == 1.0
  assert maths.cos(pi) == -1.0

  // floats being floats
  assert maths.tan(pi /. 4.0) == 0.9999999999999999
  assert float.loosely_equals(maths.sin(pi), 0.0, tolerating: 0.000001)

  assert maths.degrees_to_radians(180.0) == pi
  assert maths.radians_to_degrees(pi) == 180.0

  assert maths.atan2(1.0, 1.0) == pi /. 4.0

  // asin and acos are Results: the input has to be between -1 and 1
  assert maths.asin(1.0) == Ok(pi /. 2.0)
  assert maths.acos(2.0) == Error(Nil)
  // there's also atan, sinh, cosh, tanh, asinh, acosh, atanh
}
