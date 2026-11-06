// gleam, basics, comments, documentation, doc comments, module documentation, deprecated, gleam docs

// Two slashes is a regular comment. There are no block comments

import gleam/io

/// Three slashes is documentation for whatever comes right after it: a
/// function, a type, a constant. It's markdown, it shows up when you hover
/// in the editor, and `gleam docs build` makes HTML out of it
pub fn main() {
  // a comment in the middle of the code
  io.println(greeting())
}

/// How we say hello
pub const salutation = "Hello"

/// A person to greet
pub type Person {
  /// constructors and their fields can be documented as well
  Person(name: String)
}

@deprecated("Use `greeting` instead")
pub fn hello() -> String {
  greeting()
}

fn greeting() -> String {
  salutation <> ", " <> Person("Joe").name <> "!"
}
//  NOTE  four slashes (`////`) documents the whole module, and it goes at
//        the very top of the file. it's not used anywhere in the codex
//        because `gleam format` moves it above everything else, including
//        the line with the tags
