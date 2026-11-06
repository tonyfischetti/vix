// gleam, lists, create a list, list length, indexing, nth element, first, last, repeat, is_empty, empty list

import gleam/list

pub fn main() {
  let tmp = [0, 1, 2, 3]

  // this walks the whole list (the length isn't stored anywhere)
  assert list.length(tmp) == 4

  // ...so don't compare the length to 0 to see if it's empty
  assert list.is_empty([])
  assert !list.is_empty(tmp)

  // the two ends. both are Results because the list might be empty
  assert list.first(tmp) == Ok(0)
  assert list.last(tmp) == Ok(3)
  assert list.first([]) == Error(Nil)

  // there is no `tmp[2]`. for the nth element, drop n and take the first
  assert tmp |> list.drop(2) |> list.first == Ok(2)
  assert tmp |> list.drop(10) |> list.first == Error(Nil)

  // or pattern match, when you know the shape
  let assert [_, second, ..] = tmp
  assert second == 1

  // a list of five zeros
  assert list.repeat(0, times: 5) == [0, 0, 0, 0, 0]

  // an empty list, annotated because there's nothing to infer the type from
  let empty: List(String) = []
  assert empty == []
}
