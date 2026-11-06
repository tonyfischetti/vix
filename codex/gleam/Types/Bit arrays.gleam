// gleam, types, bit arrays, binary data, bytes, typed arrays, bitstring, utf8, base64, hex, pattern matching on bytes, parse binary, endianness

import gleam/bit_array

pub fn main() {
  // bytes
  let bytes = <<255, 216, 255>>
  assert bit_array.byte_size(bytes) == 3

  // the UTF-8 bytes of a string
  let hello = <<"Hello":utf8>>
  assert hello == bit_array.from_string("Hello")
  assert bit_array.to_string(hello) == Ok("Hello")
  // (not every pile of bytes is a string)
  assert bit_array.to_string(bytes) == Error(Nil)

  // each segment can say how many bits it is and which way round
  let big = <<258:size(16)>>
  let little = <<258:size(16)-little>>
  assert big == <<1, 2>>
  assert little == <<2, 1>>

  // gluing them together
  assert bit_array.append(<<1>>, <<2, 3>>) == <<1, 2, 3>>
  assert <<0, hello:bits, 0>> == <<0, 72, 101, 108, 108, 111, 0>>

  // slicing: start and length, in bytes
  assert bit_array.slice(<<1, 2, 3, 4>>, at: 1, take: 2) == Ok(<<2, 3>>)

  // taking a binary format apart is pattern matching
  let png_header = <<137, "PNG":utf8, 13, 10, 26, 10, 0, 0, 0, 13, "IHDR":utf8>>
  assert is_png(png_header)
  assert !is_png(hello)
  assert dimensions(<<800:size(32), 600:size(32), 8, 6>>) == Ok(#(800, 600))
  assert dimensions(<<1, 2, 3>>) == Error(Nil)

  // to and from text encodings
  assert bit_array.base64_encode(hello, True) == "SGVsbG8="
  assert bit_array.base64_decode("SGVsbG8=") == Ok(hello)
  assert bit_array.base16_encode(bytes) == "FFD8FF"
  assert bit_array.base16_decode("FFD8FF") == Ok(bytes)

  // for looking at one
  assert bit_array.inspect(<<1, 2, 3>>) == "<<1, 2, 3>>"
  //  WARN  `echo` and `string.inspect` print bytes that happen to be valid
  //        UTF-8 as a string (on Erlang they're the same thing underneath)
}

fn is_png(data: BitArray) -> Bool {
  case data {
    <<137, "PNG":utf8, 13, 10, 26, 10, _rest:bits>> -> True
    _ -> False
  }
}

// two 32 bit big endian integers, and whatever comes after
fn dimensions(data: BitArray) -> Result(#(Int, Int), Nil) {
  case data {
    <<width:size(32), height:size(32), _rest:bits>> -> Ok(#(width, height))
    _ -> Error(Nil)
  }
}
