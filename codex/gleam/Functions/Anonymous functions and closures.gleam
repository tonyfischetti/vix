// gleam, functions, anonymous functions, lambdas, closures, higher-order functions, functions as values, return a function, generic function

import gleam/list

pub fn main() {
  // an anonymous function
  let add_one = fn(n) { n + 1 }
  assert add_one(1) == 2

  // with the types spelled out (optional, like everywhere else)
  let add = fn(a: Int, b: Int) -> Int { a + b }
  assert add(2, 1) == 3

  // named functions are values too. pass them along without calling them
  assert list.map([1, 2, 3], double) == [2, 4, 6]
  assert twice(double, 5) == 20
  assert twice(fn(s) { s <> "!" }, "hi") == "hi!!"

  // a closure keeps hold of the variables that were around when it was made
  let add_ten = make_adder(10)
  assert add_ten(5) == 15

  // a tuple argument gets destructured in the body, not in the parameters
  let add_pair = fn(pair) {
    let #(x, y) = pair
    x + y
  }
  assert list.map([#(0, 3), #(1, 2)], add_pair) == [3, 3]
}

fn double(n: Int) -> Int {
  n * 2
}

// takes a function. `a` is a type variable: any type, as long as it's the
// same one everywhere it appears
fn twice(f: fn(a) -> a, x: a) -> a {
  f(f(x))
}

// returns a function
fn make_adder(amount: Int) -> fn(Int) -> Int {
  fn(n) { n + amount }
}
