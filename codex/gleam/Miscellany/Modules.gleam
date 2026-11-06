// gleam, modules, import, export, pub, private, qualified import, unqualified import, alias, as, type import, internal, namespace

// A module is a file, and its name is its path: `src/utils/maths.gleam`
// IS the module `utils/maths`. There's nothing to declare, and nothing is
// visible to other modules unless it says `pub`.

// the usual import. things are used through the last part of the name,
// `list.map`
import gleam/list

// under another name
import gleam/string as text

// particular things, to use with no qualifier. a type needs the word
// `type`, its constructors (Some, None) don't
import gleam/option.{type Option, None, Some}

// functions can be imported that way too, but mostly aren't: with
// `int.to_string` you can see where it came from
import gleam/int.{to_string}

// ***************** what this module exports *****************

pub const magic_constant = 2.46

pub fn square(x: Int) -> Int {
  x * x
}

// the type and its constructor are both public: other modules can make
// one, and can pattern match on one
pub type Cow {
  Cow(name: String, nickname: Option(String))
}

pub fn speak(cow: Cow) -> String {
  text.capitalise(display_name(cow)) <> " says \"Moo\""
}

// no `pub`: only this file can see it
fn display_name(cow: Cow) -> String {
  case cow.nickname {
    Some(nickname) -> nickname
    None -> cow.name
  }
}

pub fn main() {
  assert list.map([1, 2, 3], square) == [1, 4, 9]
  assert to_string(square(2)) == "4"
  assert speak(Cow(name: "bessie", nickname: None)) == "Bessie says \"Moo\""
  assert speak(Cow("bessie", Some("bess"))) == "Bess says \"Moo\""
  assert magic_constant >. 2.0
}
// ***************** using it from another module *****************
//
// if this file were `src/farm/cows.gleam`...
//
//   import farm/cows
//
//   cows.square(2)
//   cows.Cow(name: "bessie", nickname: option.None) |> cows.speak
//
//   import farm/cows.{type Cow, Cow, speak}
//
//   speak(Cow("bessie", option.None))
//
//  NOTE  - there's no default export and no re-exporting
//        - there are no relative imports. it's always the whole path,
//          starting from src/
//        - two modules can't import each other (it's a compile error)
//        - an import that isn't used is a warning
//        - `pub opaque type` exports a type without its insides (see
//          "Opaque types")
