// gleam, data formats, csv, tsv, parse csv, write csv, quoted fields, header row, gsv

// gleam add gsv

import gleam/dict
import gleam/int
import gleam/list
import gleam/result
import gsv

pub fn main() {
  let csv =
    "name,sound,legs
Bessie,moo,4
\"Rocky, the Raccoon\",\"says \"\"hi\"\"\",4
"

  // rows of fields. quotes, and commas inside quotes, are taken care of
  assert gsv.to_lists(csv, separator: ",")
    == Ok([
      ["name", "sound", "legs"],
      ["Bessie", "moo", "4"],
      ["Rocky, the Raccoon", "says \"hi\"", "4"],
    ])

  // or one Dict per row, with the first row as the keys
  let assert Ok([bessie, rocky]) = gsv.to_dicts(csv, separator: ",")
  assert dict.get(bessie, "sound") == Ok("moo")
  assert dict.get(rocky, "name") == Ok("Rocky, the Raccoon")

  // everything is a String. numbers are yours to parse
  assert dict.get(bessie, "legs") |> result.try(int.parse) == Ok(4)

  // tab separated
  assert gsv.to_lists("a\tb\n1\t2", separator: "\t")
    == Ok([["a", "b"], ["1", "2"]])

  // a broken file is an Error that says which line
  assert gsv.to_lists("a,b\n\"never closed", separator: ",")
    == Error(gsv.MissingClosingQuote(starting_line: 2))

  // writing: it quotes what needs quoting
  let rows = [
    ["name", "legs"],
    ..list.map([#("Rocky, the Raccoon", 4), #("Captain", 2)], fn(animal) {
      [animal.0, int.to_string(animal.1)]
    })
  ]
  assert gsv.from_lists(rows, separator: ",", line_ending: gsv.Unix)
    == "name,legs\n\"Rocky, the Raccoon\",4\nCaptain,2\n"
}
