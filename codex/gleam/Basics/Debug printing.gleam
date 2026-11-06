// gleam, basics, debug printing, echo, print, println, console.log, inspect, stderr, stdout, pipeline debugging

import gleam/int
import gleam/io
import gleam/list
import gleam/string

pub fn main() {
  // strings (and only strings) to stdout
  io.println("Hello, Joe!")
  io.print("no newline at the end of this one")
  io.println("")

  // to stderr
  io.println_error("something's wrong")

  // anything that isn't a String has to be made into one
  io.println("the answer is " <> int.to_string(42))
  io.println(string.inspect(#(1, "two", [3.0])))

  // `echo` prints ANY value (to stderr, with the file and line number) and
  // then hands the value back. so it can go in front of an expression...
  let doubled = echo list.map([1, 2, 3], fn(n) { n * 2 })
  assert doubled == [2, 4, 6]

  // ...or in the middle of a pipeline, without disturbing it
  let total =
    [1, 2, 3]
    |> list.map(fn(n) { n * 2 })
    |> echo
    |> list.fold(0, int.add)
    |> echo as "the total"
  assert total == 12
  //  NOTE  `echo` is only for debugging. `gleam publish` refuses to publish
  //        a package that still has one in it
}
