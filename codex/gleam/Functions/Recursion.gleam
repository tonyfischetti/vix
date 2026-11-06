// gleam, functions, recursion, tail recursion, tail call optimisation, accumulator, loop, factorial, pattern matching, big integers

import gleam/list

pub fn main() {
  assert factorial(5) == 120
  assert factorial_tail(5) == 120
  assert length(["a", "b", "c"]) == 3
  assert map([1, 2, 3], fn(n) { n * 2 }) == [2, 4, 6]

  // (Ints don't overflow on the Erlang target)
  assert factorial_tail(25) == 15_511_210_043_330_985_984_000_000
}

// the textbook version. the multiplying happens AFTER the recursive call
// comes back, so every call has to be kept around until the end
fn factorial(n: Int) -> Int {
  case n {
    0 -> 1
    _ -> n * factorial(n - 1)
  }
}

// tail recursive: the answer so far rides along as an argument (the
// accumulator), which makes the recursive call the last thing that
// happens. the compiler turns that into a loop
fn factorial_tail(n: Int) -> Int {
  factorial_loop(n, 1)
}

fn factorial_loop(n: Int, acc: Int) -> Int {
  case n {
    0 -> acc
    _ -> factorial_loop(n - 1, acc * n)
  }
}

// walking a list: one clause for empty, one for "the first and the rest"
fn length(items: List(a)) -> Int {
  length_loop(items, 0)
}

fn length_loop(items: List(a), count: Int) -> Int {
  case items {
    [] -> count
    [_, ..rest] -> length_loop(rest, count + 1)
  }
}

// building a list: prepend to the accumulator, reverse once at the end
fn map(items: List(a), f: fn(a) -> b) -> List(b) {
  map_loop(items, f, [])
}

fn map_loop(items: List(a), f: fn(a) -> b, acc: List(b)) -> List(b) {
  case items {
    [] -> list.reverse(acc)
    [first, ..rest] -> map_loop(rest, f, [f(first), ..acc])
  }
}
