// gleam, math, round, ceiling, floor, truncate, round to decimal places, to_precision

import gleam/float

pub fn main() {
  // to the nearest Int. halves go away from zero
  assert float.round(3.14159) == 3
  assert float.round(2.5) == 3
  assert float.round(-2.5) == -3

  // chop off the fraction (also an Int)
  assert float.truncate(1.8) == 1
  assert float.truncate(-1.8) == -1

  //  NOTE  these two give back a Float
  assert float.ceiling(1.2) == 2.0
  assert float.floor(1.8) == 1.0

  // to some number of decimal places
  assert float.to_precision(2.0 /. 3.0, 2) == 0.67
  assert float.to_precision(2.0 /. 3.0, 4) == 0.6667
}
