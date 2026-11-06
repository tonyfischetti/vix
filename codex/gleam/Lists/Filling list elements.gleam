// gleam, lists, filling list elements, fill, replace by index, index_map, repeat, list indexing, multiple indices

import gleam/list

pub fn main() {
  let rainbow = ["red", "orange", "yellow", "green", "blue", "indigo", "violet"]

  // there's nothing like `fill` built in, because there's no modifying a
  // list in place. `index_map` builds the new list
  assert fill(rainbow, with: "BLACK", from: 4, to: 7)
    == ["red", "orange", "yellow", "green", "BLACK", "BLACK", "BLACK"]

  // replacing a single element is the same idea
  assert fill(rainbow, with: "BLACK", from: 1, to: 2)
    == ["red", "BLACK", "yellow", "green", "blue", "indigo", "violet"]

  // a whole list of the same thing
  assert list.repeat("BLACK", times: 3) == ["BLACK", "BLACK", "BLACK"]
}

/// Replace the elements from index `start` up to (not including) `end`
fn fill(
  items: List(a),
  with value: a,
  from start: Int,
  to end: Int,
) -> List(a) {
  list.index_map(items, fn(item, index) {
    case index >= start && index < end {
      True -> value
      False -> item
    }
  })
}
