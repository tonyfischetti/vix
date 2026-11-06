// gleam, basics, loops, for loops, for of, while, do while, recursion, tail recursion, break, fold_until, each, int.range, boomer loops

// There are no loop statements. What you do instead:
//
//   1. a function from `gleam/list` (each, map, fold...) if you have a list
//   2. `int.range` if you have a count
//   3. a recursive function for everything else (that's your `while`)

import gleam/int
import gleam/io
import gleam/list
import gleam/string

pub fn main() {
  let nums = [1, 2, 3, 4]

  // for (const element of nums)
  list.each(nums, fn(element) {
    io.println("current element: " <> int.to_string(element))
  })

  // for (const character of string)
  "Όλοι" |> string.to_graphemes |> list.each(io.println)

  // for (let i = 0; i < 3; i++)
  int.range(from: 0, to: 3, with: Nil, run: fn(_, i) {
    io.println("i is " <> int.to_string(i))
  })

  // a loop that builds something up is a fold
  assert list.fold(nums, 0, fn(total, n) { total + n }) == 10

  // `break`: fold_until stops as soon as you say so
  assert list.fold_until(nums, 0, fn(total, n) {
      case n > 2 {
        True -> list.Stop(total)
        False -> list.Continue(total + n)
      }
    })
    == 3

  // while (count < 5) { count++ }
  assert count_up(from: 0, to: 5) == 5

  // any other loop: recursion, with the loop's state as arguments
  assert collatz_steps(27) == 111
}

// the loop variable is an argument, and the next iteration is a call
fn count_up(from count: Int, to limit: Int) -> Int {
  case count < limit {
    True -> {
      io.println("Count: " <> int.to_string(count))
      count_up(from: count + 1, to: limit)
    }
    False -> count
  }
}

// the usual shape: a public function that starts a private `_loop` function
// off with the initial state
fn collatz_steps(n: Int) -> Int {
  collatz_loop(n, 0)
}

fn collatz_loop(n: Int, steps: Int) -> Int {
  case n {
    1 -> steps
    _ if n % 2 == 0 -> collatz_loop(n / 2, steps + 1)
    _ -> collatz_loop(3 * n + 1, steps + 1)
  }
}
//  NOTE  when the recursive call is the very last thing the function does
//        (like in both of these) it doesn't use any stack, so it can go
//        around forever
