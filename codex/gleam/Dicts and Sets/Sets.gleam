// gleam, sets, unique, union, intersection, difference, contains, membership, subset, dedupe

import gleam/list
import gleam/set
import gleam/string

pub fn main() {
  let primary = set.from_list(["red", "yellow", "blue", "red"])
  let warm = set.from_list(["red", "orange", "yellow"])

  // no duplicates
  assert set.size(primary) == 3

  assert set.contains(primary, "red")
  assert !set.contains(primary, "green")

  // adding and removing (new sets, as usual)
  let more = set.insert(primary, "green")
  assert set.size(more) == 4
  assert set.delete(more, "green") == primary

  // sets have no order, so sort when you take the members back out
  let sorted = fn(s) { s |> set.to_list |> list.sort(string.compare) }

  assert sorted(set.union(primary, warm)) == ["blue", "orange", "red", "yellow"]
  assert sorted(set.intersection(primary, warm)) == ["red", "yellow"]
  assert sorted(set.difference(primary, warm)) == ["blue"]
  assert sorted(set.symmetric_difference(primary, warm)) == ["blue", "orange"]

  assert set.is_subset(set.from_list(["red"]), of: primary)
  assert set.is_disjoint(primary, set.from_list(["black", "white"]))

  // two sets with the same members are equal, whatever order they went in
  assert set.from_list([1, 2, 3]) == set.from_list([3, 2, 1])
}
