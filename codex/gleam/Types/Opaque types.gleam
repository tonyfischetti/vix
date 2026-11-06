// gleam, types, opaque types, smart constructor, validation, encapsulation, private fields, invariants, parse don't validate

// Other modules can name an opaque type, but only THIS module can build
// one or look inside one. The only way to get a value is through your
// functions, so if someone has one, it's valid.

import gleam/result
import gleam/string

pub opaque type Username {
  Username(value: String)
}

pub type UsernameError {
  TooShort
  HasSpaces
}

/// The only way in
pub fn new(raw: String) -> Result(Username, UsernameError) {
  let trimmed = string.trim(raw)
  case string.length(trimmed) < 3, string.contains(trimmed, " ") {
    True, _ -> Error(TooShort)
    _, True -> Error(HasSpaces)
    False, False -> Ok(Username(string.lowercase(trimmed)))
  }
}

/// The only way out
pub fn to_string(username: Username) -> String {
  username.value
}

pub fn main() {
  assert new("  Tony ") |> result.map(to_string) == Ok("tony")
  assert new("al") == Error(TooShort)
  assert new("mad hatter") == Error(HasSpaces)
  //  NOTE  from any other module, all of these are compile errors
  //          Username("x")
  //          username.value
  //          let Username(value) = username
}
