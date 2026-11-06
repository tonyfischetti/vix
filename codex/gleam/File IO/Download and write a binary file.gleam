// gleam, file io, download a file, binary, bytes, bit array, blobs, http, GET, web, write a binary file, write_bits, httpc

// gleam add gleam_http gleam_httpc simplifile

import gleam/bit_array
import gleam/http/request
import gleam/httpc
import gleam/int
import gleam/io
import simplifile

pub fn main() {
  let assert Ok(req) = request.to("https://thepolygram.com/pluto-p.png")

  // `send_bits` takes and gives back bodies that are BitArrays (raw
  // bytes) and not Strings, which is what anything that isn't text needs
  let assert Ok(resp) = req |> request.set_body(<<>>) |> httpc.send_bits

  assert resp.status == 200
  io.println(int.to_string(bit_array.byte_size(resp.body)) <> " bytes")
  // 243788 bytes

  let assert Ok(Nil) = simplifile.write_bits(to: "pluto-p.png", bits: resp.body)
  io.println("done")
}
