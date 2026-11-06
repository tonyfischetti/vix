// gleam, types, custom types, records, classes, constructor, define class, methods, static methods, inheritance, variants, field access, record update, toString

// There are no classes, objects, methods or inheritance. There's
//
//   - a custom type, that holds the data
//   - plain functions that take one as an argument
//
// The module is what groups them together. A "subclass" is another variant
// of the type, and "overriding a method" is another clause in a `case`.

import gleam/string

/// One type, two variants. A variant is also its constructor
pub type Animal {
  Animal(name: String)
  LoudAnimal(name: String, sound: String)
}

/// A constant is the `static` property
pub const note = "hi!"

/// A function that returns one is the `static` factory method
pub fn from_full_name(full_name: String) -> Result(Animal, Nil) {
  case string.split(full_name, on: ", ") {
    [_, name] -> Ok(Animal(name:))
    _ -> Error(Nil)
  }
}

/// A "getter". `animal.name` works because every variant has a `name`
pub fn honorific(animal: Animal) -> String {
  "SIR " <> string.uppercase(animal.name)
}

/// Behaviour that's different for each variant: pattern match
pub fn to_string(animal: Animal) -> String {
  case animal {
    Animal(name:) -> "An animal named " <> name
    LoudAnimal(name:, sound:) ->
      "An animal named " <> name <> " (that says \"" <> sound <> "\")"
  }
}

/// Behaviour that only some variants have: say so in the return type
pub fn speak(animal: Animal) -> Result(String, Nil) {
  case animal {
    LoudAnimal(name:, sound:) -> Ok(name <> " says \"" <> sound <> "\"")
    Animal(..) -> Error(Nil)
  }
}

pub fn main() {
  // constructors are just functions. there's no `new`
  let birb = Animal("Captain")
  let raccoon = from_full_name("Raccoon, Rocky")
  let cow = LoudAnimal(name: "Bessie", sound: "moo")

  assert birb == Animal(name: "Captain")
  assert raccoon == Ok(Animal("Rocky"))

  assert birb.name == "Captain"
  assert cow.name == "Bessie"

  // "methods" are function calls
  assert to_string(birb) == "An animal named Captain"
  assert to_string(cow) == "An animal named Bessie (that says \"moo\")"
  assert honorific(birb) == "SIR CAPTAIN"
  assert honorific(cow) == "SIR BESSIE"
  assert speak(cow) == Ok("Bessie says \"moo\"")
  assert speak(birb) == Error(Nil)
  assert string.length(note) == 3

  // records are immutable. an update is a copy with some fields changed
  let quiet_cow = LoudAnimal(..cow, sound: "...")
  assert quiet_cow == LoudAnimal("Bessie", "...")
  assert cow.sound == "moo"

  // any value can be printed (`echo cow` shows the same thing).
  // the labels are gone at runtime on Erlang. on the JavaScript target
  // it's `LoudAnimal(name: "Bessie", sound: "moo")`
  assert string.inspect(cow) == "LoudAnimal(\"Bessie\", \"moo\")"
}
