// gleam, lists, map, mapcar, index and value, index_map, flat_map, flatMap, map2, upper case, anaphors

import gleam/int
import gleam/list
import gleam/string

pub fn main() {
  let rainbow = ["red", "orange", "yellow", "green", "blue", "indigo", "violet"]

  // a function that already has the right shape can be passed by name
  assert list.map(rainbow, string.uppercase)
    == ["RED", "ORANGE", "YELLOW", "GREEN", "BLUE", "INDIGO", "VIOLET"]

  assert list.map([1, 2, 3], fn(n) { n * 10 }) == [10, 20, 30]

  // with the index
  assert list.index_map(["red", "orange"], fn(color, index) {
      "[" <> int.to_string(index) <> "] => '" <> color <> "'"
    })
    == ["[0] => 'red'", "[1] => 'orange'"]

  // map, then flatten one level
  assert list.flat_map([1, 2, 3], fn(n) { [n, n * 2] }) == [1, 2, 2, 4, 3, 6]

  // map over two lists at once (stops at the end of the shorter one)
  assert list.map2([1, 2, 3], [10, 20, 30], fn(a, b) { a + b }) == [11, 22, 33]
}
