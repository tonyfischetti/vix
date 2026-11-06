// gleam, lists, sort, sort a list, compare, order, descending, sort by field, sort by two keys, break_tie

import gleam/int
import gleam/list
import gleam/order
import gleam/string

type Paint {
  Paint(color: String, n: Int)
}

pub fn main() {
  let rainbow = ["red", "orange", "yellow", "green", "blue", "indigo", "violet"]

  // you always say how to compare. there's a `compare` for each basic type
  assert list.sort(rainbow, by: string.compare)
    == ["blue", "green", "indigo", "orange", "red", "violet", "yellow"]

  // descending
  assert list.sort([3, 1, 2], by: order.reverse(int.compare)) == [3, 2, 1]

  // by something computed. the sort is stable, so ties stay in the order
  // they were in
  assert list.sort(rainbow, by: fn(a, b) {
      int.compare(string.length(a), string.length(b))
    })
    == ["red", "blue", "green", "orange", "yellow", "indigo", "violet"]

  // a list of records, on a field
  let paints = [Paint("red", 1), Paint("blue", 10), Paint("green", 10)]
  assert list.sort(paints, by: fn(a, b) { string.compare(a.color, b.color) })
    == [Paint("blue", 10), Paint("green", 10), Paint("red", 1)]

  // on two keys: biggest `n` first, then by color
  assert list.sort(paints, by: fn(a, b) {
      int.compare(b.n, a.n)
      |> order.break_tie(string.compare(a.color, b.color))
    })
    == [Paint("blue", 10), Paint("green", 10), Paint("red", 1)]
  //  NOTE  nothing is sorted in place. `rainbow` and `paints` are unchanged
}
