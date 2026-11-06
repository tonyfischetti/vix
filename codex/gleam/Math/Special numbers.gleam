// gleam, math, special numbers, Infinity, NaN, division by zero, parse, limits

import gleam/float
import gleam/int

pub fn main() {
  let zero = 0
  let zero_point = 0.0

  //  WARN  there is no Infinity and no NaN. dividing by zero is zero
  assert 1 / zero == 0
  assert zero / 1 == 0
  assert zero / zero == 0
  assert 1.0 /. zero_point == 0.0
  assert zero_point /. zero_point == 0.0

  // if you want to hear about it, use the functions
  assert int.divide(1, by: zero) == Error(Nil)
  assert float.divide(1.0, by: zero_point) == Error(Nil)

  // what would be NaN in JS is an Error here
  assert int.parse("pp") == Error(Nil)
  assert float.square_root(-1.0) == Error(Nil)
  assert float.logarithm(zero_point) == Error(Nil)
  //  NOTE  what would be Infinity is a crash (on Erlang, a float that gets
  //        too big is a runtime error)
}
