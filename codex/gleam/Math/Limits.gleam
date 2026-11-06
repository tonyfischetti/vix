// gleam, math, limits, max safe integer, big integers, bigint, arbitrary precision, float precision, epsilon, comparing floats, overflow

import gleam/float

pub fn main() {
  // on the Erlang target an Int is as big as it needs to be. nothing
  // overflows and nothing gets rounded
  let past_js_safe = 9_007_199_254_740_993
  assert past_js_safe + 1 == 9_007_199_254_740_994
  assert past_js_safe * 2 == 18_014_398_509_481_986
  //  WARN  on the JavaScript target an Int is a JS number (a double), so
  //        after 2^53 - 1 (9_007_199_254_740_991) there are round-off
  //        errors. that literal comes out as ...992 over there

  // a Float is a double on both targets. this is the biggest one
  let max_float = 1.7976931348623157e308
  assert max_float >. 1.0e308
  //  WARN  there's no Infinity to overflow into. on Erlang, going past the
  //        biggest float crashes (`max_float *. 10.0` is a runtime error)

  // the usual trouble with floats
  let sum = 0.1 +. 0.2
  assert sum != 0.3
  assert float.to_string(sum) == "0.30000000000000004"

  // so compare them with some slack
  assert float.loosely_equals(sum, 0.3, tolerating: 0.000001)
}
