// gleam, lists, unique, dedupe, group, chunk, sized_chunk, window, intersperse, transpose, combinations, permutations, max, try_map

import gleam/dict
import gleam/int
import gleam/list

pub fn main() {
  // remove duplicates (keeps the first of each)
  assert list.unique([1, 2, 1, 3, 2]) == [1, 2, 3]

  // group into a Dict by some key
  let by_parity =
    list.group([1, 2, 3, 4, 5], by: fn(n) {
      case n % 2 {
        0 -> "even"
        _ -> "odd"
      }
    })
  assert dict.get(by_parity, "even") == Ok([4, 2])
  assert dict.get(by_parity, "odd") == Ok([5, 3, 1])

  // pieces of a fixed size
  assert list.sized_chunk([1, 2, 3, 4, 5], into: 2) == [[1, 2], [3, 4], [5]]

  // runs of neighbours that share a key
  assert list.chunk([1, 1, 2, 3, 3, 3], by: fn(n) { n })
    == [[1, 1], [2], [3, 3, 3]]

  // sliding windows
  assert list.window([1, 2, 3, 4], by: 2) == [[1, 2], [2, 3], [3, 4]]
  assert list.window_by_2([1, 2, 3]) == [#(1, 2), #(2, 3)]

  assert list.intersperse([1, 2, 3], with: 0) == [1, 0, 2, 0, 3]

  // rows <-> columns
  assert list.transpose([[1, 2, 3], [4, 5, 6]]) == [[1, 4], [2, 5], [3, 6]]

  assert list.combinations([1, 2, 3], by: 2) == [[1, 2], [1, 3], [2, 3]]
  assert list.combination_pairs([1, 2, 3]) == [#(1, 2), #(1, 3), #(2, 3)]
  assert list.permutations([1, 2, 3])
    == [[1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]]

  // the biggest, by a compare function
  assert list.max([3, 9, 4], int.compare) == Ok(9)

  // map with a function that can fail. stops at the first Error
  assert list.try_map(["1", "2", "3"], int.parse) == Ok([1, 2, 3])
  assert list.try_map(["1", "two", "3"], int.parse) == Error(Nil)
}
