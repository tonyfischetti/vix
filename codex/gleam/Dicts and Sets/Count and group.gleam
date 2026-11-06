// gleam, dicts, hash tables, count occurrences, frequency, tally, histogram, group by, upsert, most common

import gleam/dict
import gleam/int
import gleam/list
import gleam/option
import gleam/string

pub fn main() {
  let words =
    "twinkle twinkle little bat how I wonder what you're at"
    |> string.split(on: " ")

  // count them: fold into a dict, bumping the count for each word
  let counts =
    list.fold(words, dict.new(), fn(counts, word) {
      dict.upsert(counts, word, fn(count) { option.unwrap(count, 0) + 1 })
    })
  assert dict.get(counts, "twinkle") == Ok(2)
  assert dict.get(counts, "bat") == Ok(1)
  assert dict.get(counts, "star") == Error(Nil)

  // the most common
  let most_common =
    counts
    |> dict.to_list
    |> list.sort(fn(a, b) { int.compare(b.1, a.1) })
    |> list.first
  assert most_common == Ok(#("twinkle", 2))

  // group by a key
  let by_length = list.group(words, by: string.length)
  assert dict.get(by_length, 3) == Ok(["how", "bat"])
  assert dict.get(by_length, 7) == Ok(["twinkle", "twinkle"])
  //  NOTE  each group's list is in the reverse of the order they were found
}
