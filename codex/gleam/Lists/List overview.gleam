// gleam, lists, overview, linked list, immutable, tuples, list vs array, dict

// Gleam has no arrays. `List` is an immutable singly-linked list:
//
//   - every element has the same type
//   - adding to / taking from the FRONT is constant time
//   - anything that has to reach the end (length, append, last, the nth
//     element) walks the list
//   - nothing is ever modified in place. every "change" returns a new list
//     (which shares its tail with the old one, so it's cheap)
//
// So there's no `list[3]`, no `push` and no `.length`. You prepend, you
// pattern match, and you use the functions in `gleam/list`.

import gleam/dict
import gleam/list

pub fn main() {
  let nums = ["zero", "one", "two", "three"]

  // this is a List(String). mixing types is a compile error
  // let nope = [0, "one"]

  // a fixed number of things of different types is a tuple, not a list
  let pair = #(0, "zero")
  assert pair.0 == 0
  assert pair.1 == "zero"

  // prepending is the cheap operation...
  let more = ["minus one", ..nums]
  assert list.length(more) == 5

  // ...and `nums` is untouched
  assert list.length(nums) == 4

  // if you want lookup by index (the other thing JS arrays are used for)
  // use a Dict
  let by_index = dict.from_list([#(0, "zero"), #(1, "one"), #(2, "two")])
  assert dict.get(by_index, 1) == Ok("one")
  assert dict.get(by_index, 9) == Error(Nil)
  //  NOTE  for a real array (constant time indexing) there are packages,
  //        like `glearray`
}
