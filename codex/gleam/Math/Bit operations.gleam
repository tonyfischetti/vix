// gleam, math, bit operations, bitwise, binary, shift, and, or, xor, not, decimal to binary string, bit manipulation, test a bit, set a bit

import gleam/int
import gleam/string

pub fn main() {
  // there are no bitwise operators, they're functions in `gleam/int`
  let example = 0b00001011
  assert example == 11
  assert binary(example) == "00001011"

  assert binary(int.bitwise_shift_right(example, 1)) == "00000101"
  assert binary(int.bitwise_shift_right(example, 2)) == "00000010"
  assert binary(int.bitwise_shift_left(example, 1)) == "00010110"

  assert binary(int.bitwise_and(example, 0b0110)) == "00000010"
  assert binary(int.bitwise_or(example, 0b0110)) == "00001111"
  assert binary(int.bitwise_exclusive_or(example, 0b0110)) == "00001101"

  // is bit 3 set?
  let bit_3 = int.bitwise_shift_left(1, 3)
  assert binary(bit_3) == "00001000"
  assert int.bitwise_and(example, bit_3) != 0

  // set the top four bits
  let top_four = int.bitwise_shift_left(0b1111, 4)
  assert binary(top_four) == "11110000"
  assert binary(int.bitwise_or(example, top_four)) == "11111011"

  // Ints aren't a fixed number of bits wide, so `not` gives a negative
  // number rather than a big one
  assert int.bitwise_not(example) == -12
  //  NOTE  for taking binary data apart (file formats, packets) don't do
  //        this by hand. that's what bit arrays are for
}

fn binary(n: Int) -> String {
  n |> int.to_base2 |> string.pad_start(to: 8, with: "0")
}
