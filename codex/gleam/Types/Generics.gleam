// gleam, types, generics, type parameters, type variables, generic type, generic function, parametric polymorphism, stack

/// A generic type. `a` gets filled in by whoever uses it
pub type Stack(a) {
  Stack(items: List(a))
}

pub fn new() -> Stack(a) {
  Stack([])
}

pub fn push(stack: Stack(a), item: a) -> Stack(a) {
  Stack([item, ..stack.items])
}

pub fn pop(stack: Stack(a)) -> Result(#(a, Stack(a)), Nil) {
  case stack.items {
    [] -> Error(Nil)
    [top, ..rest] -> Ok(#(top, Stack(rest)))
  }
}

/// A generic function. A lowercase name in a type is a type variable:
/// any type at all, but the same one everywhere that name appears
pub fn pair_up(first: a, second: b) -> #(a, b) {
  #(first, second)
}

/// More than one parameter. This is how Result is defined, give or take:
///
///   pub type Result(value, error) {
///     Ok(value)
///     Error(error)
///   }
pub type Either(left, right) {
  Left(left)
  Right(right)
}

pub fn main() {
  // this one is a Stack(Int). `push(numbers, "three")` wouldn't compile
  let numbers = new() |> push(1) |> push(2)
  let assert Ok(#(top, rest)) = pop(numbers)
  assert top == 2
  assert rest == Stack([1])

  // and this is a Stack(String), from the same code
  let words = new() |> push("hello")
  assert pop(words) == Ok(#("hello", Stack([])))

  assert pair_up(1, "one") == #(1, "one")

  let either: Either(Int, String) = Left(1)
  assert either != Right("one")
  //  NOTE  there are no interfaces, traits or type classes, so there's no
  //        way to say "any type that can be compared". you pass the
  //        function in instead (it's why `list.sort` takes a compare
  //        function)
}
