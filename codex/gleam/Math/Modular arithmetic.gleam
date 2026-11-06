// gleam, math, modular arithmetic, modulo, remainder, integer division, floor division, negative numbers, division by zero, even, odd

import gleam/float
import gleam/int

pub fn main() {
  let five = 5

  assert 25 % five == 0
  assert 27 % five == 2
  assert 3 % five == 3
  assert 0 % five == 0

  // `%` is the remainder: with a negative number it keeps the sign of the
  // left side. `int.modulo` wraps around to the sign of the right side
  assert -7 % five == -2
  assert int.modulo(-7, by: five) == Ok(3)

  // integer division cuts off towards zero. `int.floor_divide` goes down
  assert -7 / 2 == -3
  assert int.floor_divide(-7, by: 2) == Ok(-4)

  //  WARN  the operators give 0 when dividing by zero. the functions give
  //        an Error
  assert five % 0 == 0
  assert int.modulo(five, by: 0) == Error(Nil)
  assert int.remainder(five, by: 0) == Error(Nil)

  // `%` is only for Ints
  assert float.modulo(7.5, by: 2.0) == Ok(1.5)

  assert int.is_even(4)
  assert int.is_odd(five)
}
