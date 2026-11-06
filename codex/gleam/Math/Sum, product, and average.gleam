// gleam, math, sum, product, average, mean, median, total, add up a list

// gleam add gleam_community_maths    (only for the median)

import gleam/float
import gleam/int
import gleam/list
import gleam_community/maths

pub fn main() {
  let numbers = [10, 8, 20, 3, 17, 19]

  assert int.sum(numbers) == 77
  assert int.product([1, 2, 3, 4]) == 24
  assert float.sum([1.5, 2.5]) == 4.0

  // an average is a Float, so the Ints get converted on the way
  assert mean(numbers) == Ok(12.833333333333334)
  assert mean([]) == Error(Nil)

  assert maths.median([10.0, 8.0, 20.0, 3.0, 17.0]) == Ok(10.0)
}

fn mean(numbers: List(Int)) -> Result(Float, Nil) {
  case numbers {
    [] -> Error(Nil)
    _ ->
      Ok(int.to_float(int.sum(numbers)) /. int.to_float(list.length(numbers)))
  }
}
