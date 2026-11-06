// gleam, types, type alias, alias, newtype, wrapper type

/// An alias is another NAME for a type that already exists
pub type Headers =
  List(#(String, String))

pub type Path =
  String

/// A wrapper is a whole new type with one thing inside it
pub type UserId {
  UserId(Int)
}

pub fn main() {
  let headers: Headers = [#("accept", "text/html")]

  // it's the very same type, so they're interchangeable
  let plain: List(#(String, String)) = headers
  assert plain == headers

  //  WARN  which means an alias adds no safety. a Path is any old String
  let path: Path = "definitely not a path"
  assert path == "definitely not a path"

  // a wrapper can't be mixed up with what it wraps. `UserId(850) == 850`
  // doesn't compile
  let UserId(number) = UserId(850)
  assert number == 850
}
