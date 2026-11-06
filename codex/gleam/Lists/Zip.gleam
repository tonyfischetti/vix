// gleam, lists, zip, unzip, strict_zip, map2, tuples, index and value

import gleam/list

pub fn main() {
  let nums = [0, 1, 2]
  let rainbow = ["red", "orange", "yellow"]

  // a list of tuples
  let zipped = list.zip(nums, rainbow)
  assert zipped == [#(0, "red"), #(1, "orange"), #(2, "yellow")]

  // and back
  assert list.unzip(zipped) == #(nums, rainbow)

  // `zip` stops at the end of the shorter list...
  assert list.zip([0, 1, 2, 3, 4], rainbow) == zipped

  // ...and `strict_zip` refuses if the lengths are different
  assert list.strict_zip([0, 1, 2, 3, 4], rainbow) == Error(Nil)
  assert list.strict_zip(nums, rainbow) == Ok(zipped)

  // zip and combine in one step
  assert list.map2(nums, rainbow, fn(n, color) { #(color, n * n) })
    == [#("red", 0), #("orange", 1), #("yellow", 4)]
}
