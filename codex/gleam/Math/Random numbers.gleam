// gleam, math, random numbers, random integer, random float, random in range, cryptography, cryptographically secure random numbers, random bytes

// gleam add gleam_crypto    (for the secure ones)

import gleam/bit_array
import gleam/crypto
import gleam/float
import gleam/int

pub fn main() {
  // 0.0 up to (but not including) 1.0
  let fraction = float.random()
  assert fraction >=. 0.0 && fraction <. 1.0

  // 0 up to (but not including) 10
  let digit = int.random(10)
  assert digit >= 0 && digit < 10

  let roll = random_in_range(1, 7)
  assert roll >= 1 && roll <= 6

  //  WARN  THESE ARE NOT FIT FOR CRYPTOGRAPHY! use these instead

  let bytes = crypto.strong_random_bytes(4)
  assert bit_array.byte_size(bytes) == 4

  // as hex, something like "8050E2F9"
  echo bit_array.base16_encode(bytes)

  // as a number: read the four bytes as one 32 bit integer
  let assert <<number:size(32)>> = bytes
  echo number
}

/// `min` up to (but not including) `max`
fn random_in_range(min: Int, max: Int) -> Int {
  int.random(max - min) + min
}
