// gleam, math, parse integer, parse float, string to number, parseInt, parseFloat, base_parse, hex string to number, validation

import gleam/float
import gleam/int
import gleam/result
import gleam/string

pub fn main() {
  // the whole string has to be a number, or it's an Error.
  // (there's none of parseInt's "use what you can and ignore the rest")
  assert int.parse("850") == Ok(850)
  assert int.parse("000850") == Ok(850)
  assert int.parse("-850") == Ok(-850)
  assert int.parse("+850") == Ok(850)

  assert int.parse("  850") == Error(Nil)
  assert int.parse("-850!") == Error(Nil)
  assert int.parse("850.11") == Error(Nil)
  assert int.parse("1_000") == Error(Nil)
  assert int.parse("") == Error(Nil)

  // so clean it up first
  assert "  850\n" |> string.trim |> int.parse == Ok(850)

  // a Float has to have digits on both sides of a decimal point
  assert float.parse("1.618") == Ok(1.618)
  assert float.parse("-1.5") == Ok(-1.5)
  assert float.parse("1.5e-3") == Ok(0.0015)

  assert float.parse("1") == Error(Nil)
  assert float.parse(".5") == Error(Nil)
  assert float.parse("1.618#") == Error(Nil)

  // "a number, I don't care which kind"
  assert parse_number("1.5") == Ok(1.5)
  assert parse_number("1") == Ok(1.0)
  assert parse_number("one") == Error(Nil)

  // other bases
  assert int.base_parse("ff", 16) == Ok(255)
  assert int.base_parse("10001", 2) == Ok(17)
}

fn parse_number(input: String) -> Result(Float, Nil) {
  float.parse(input)
  |> result.lazy_or(fn() { int.parse(input) |> result.map(int.to_float) })
}
