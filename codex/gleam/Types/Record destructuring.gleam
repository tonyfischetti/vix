// gleam, types, records, destructuring, object destructuring, pattern matching, record update, spread, label shorthand, rename, field access

import gleam/list

type Paints {
  Paints(red: String, green: List(String), blue: String, black: String)
}

pub fn main() {
  let paints =
    Paints(
      red: "cadmium",
      green: ["viridian", "hookers"],
      blue: "phthalo",
      black: "lamp",
    )

  // one field
  assert paints.red == "cadmium"

  // a few at once. `red:` is short for `red: red`, and `..` skips the rest
  let Paints(red:, blue:, ..) = paints
  assert red == "cadmium"
  assert blue == "phthalo"

  // re-naming
  let Paints(red: kokkino, black: maupo, ..) = paints
  assert kokkino == "cadmium"
  assert maupo == "lamp"

  // patterns nest: reach inside the list in the same breath.
  // (`let assert`, because that list could have been empty)
  let assert Paints(green: [first_green, ..], ..) = paints
  assert first_green == "viridian"

  // in a `case`, with the fields used right there
  let description = case paints {
    Paints(black: "lamp", ..) -> "has lamp black"
    Paints(black:, ..) -> "has " <> black <> " black"
  }
  assert description == "has lamp black"

  // a copy with some fields replaced
  // (this is `{ ...obj1, green: [...obj1.green, "sap"] }`)
  let paints3 = Paints(..paints, green: list.append(paints.green, ["sap"]))
  assert paints3.green == ["viridian", "hookers", "sap"]
  assert paints3.red == "cadmium"
  assert paints.green == ["viridian", "hookers"]
  //  NOTE  there are no default values when destructuring, because a field
  //        can't be missing. something optional is an `Option` field
}
