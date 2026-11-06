// gleam, basics, variables, declaring variables, let, immutable, shadowing, rebinding, constants, const, type annotations, discard, blocks

// module constants live outside of functions and have to be literals
const magic_constant = 2.46

const primary: List(String) = ["red", "yellow", "blue"]

pub fn main() {
  // every binding is immutable. there's no `var` and no reassignment
  let x = 1

  // a second `let` makes a NEW binding with the same name (shadowing).
  // anything that captured the old `x` still has the old one
  let get_x = fn() { x }
  let x = x + 1
  assert x == 2
  assert get_x() == 1

  // type annotations are optional (and checked)
  let name: String = "Alice"
  assert name == "Alice"

  // names are snake_case. a leading underscore means "unused, on purpose"
  // and turns off the unused variable warning
  let _ignored = "whatever"

  // a block is an expression. its value is its last line
  let total = {
    let a = 1
    let b = 2
    a + b
  }
  assert total == 3

  assert magic_constant *. 2.0 == 4.92
  assert primary == ["red", "yellow", "blue"]
}
