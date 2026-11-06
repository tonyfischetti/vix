// gleam, math, representing numbers, number literals, binary, octal, hex, thousands separator, scientific notation, decimal to binary string, number to string, int to float, formatting

import gleam/float
import gleam/int
import gleam/list
import gleam/string

pub fn main() {
  // Int and Float are different types (it's not all doubles)
  let whole = 2_110_000
  let scientific = 2.11e6
  let small = 1.1e-1
  assert int.to_float(whole) == scientific
  assert small == 0.11

  // binary, hex, octal
  let binary = 0b10001
  let hex = 0x0e
  let octal = 0o010
  assert #(binary, hex, octal) == #(17, 14, 8)

  // as strings
  assert int.to_string(whole) == "2110000"
  assert int.to_base2(17) == "10001"
  assert int.to_base8(8) == "10"
  assert int.to_base16(14) == "E"
  assert int.to_base_string(255, 36) == Ok("73")

  // a Float always prints with a decimal point, and big or small ones
  // come out in scientific notation
  assert float.to_string(2.0) == "2.0"
  assert float.to_string(scientific) == "2.11e6"

  // between the two. going to an Int, you choose what happens to the rest
  assert int.to_float(3) == 3.0
  assert float.round(2.5) == 3
  assert float.truncate(2.5) == 2

  // there's no number formatting built in
  assert with_commas(whole) == "2,110,000"
  assert with_commas(850) == "850"
}

// (non-negative numbers only)
fn with_commas(n: Int) -> String {
  n
  |> int.to_string
  |> string.to_graphemes
  |> list.reverse
  |> list.sized_chunk(into: 3)
  |> list.map(fn(digits) { digits |> list.reverse |> string.concat })
  |> list.reverse
  |> string.join(with: ",")
}
