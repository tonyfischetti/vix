// gleam, uuid, guid, random id, v4, v7, cryptography, youid

// gleam add youid

import gleam/string
import youid/uuid

pub fn main() {
  // random
  echo uuid.v4_string()
  // "fe44665d-ad6d-4844-a3bd-7cead3a74caa"

  // starts with the time, so they sort in the order they were made
  // (good for database keys)
  echo uuid.v7_string()
  // "01a1ae3d-7278-7f6e-8e4e-7aaaa39df31d"

  // as a value instead of a String
  let id = uuid.v4()
  assert uuid.version(id) == uuid.V4
  assert string.length(uuid.to_string(id)) == 36

  // parsing one checks it
  assert uuid.from_string(uuid.to_string(id)) == Ok(id)
  assert uuid.from_string("not a uuid") == Error(Nil)

  // without the dashes
  assert string.length(uuid.format(id, uuid.Hex)) == 32
}
