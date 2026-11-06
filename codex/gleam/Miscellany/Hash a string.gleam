// gleam, cryptography, hash, sha256, md5, hmac, digest, checksum, hex, secure compare

// gleam add gleam_crypto

import gleam/bit_array
import gleam/crypto
import gleam/string

pub fn main() {
  // hashing works on bytes and gives back bytes, so a String goes in as a
  // BitArray and the digest gets encoded on the way out
  assert hex(crypto.hash(crypto.Sha256, <<"hello":utf8>>))
    == "2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824"

  // (don't use this one for anything that matters)
  assert hex(crypto.hash(crypto.Md5, <<"hello":utf8>>))
    == "5d41402abc4b2a76b9719d911017c592"

  // also Sha1, Sha224, Sha384 and Sha512

  // a hash with a key (for signing things)
  let mac = crypto.hmac(<<"message":utf8>>, crypto.Sha256, <<"secret":utf8>>)
  assert hex(mac)
    == "8b5f48702995c1598c573db1e21866a9b825d4a794d169d7060a03605796360b"

  // comparing secrets: use this and not `==`, which gives away how much
  // of it matched by how long it takes
  assert crypto.secure_compare(mac, mac)
}

fn hex(bytes: BitArray) -> String {
  bytes |> bit_array.base16_encode |> string.lowercase
}
