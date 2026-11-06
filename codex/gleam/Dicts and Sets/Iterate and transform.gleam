// gleam, dicts, hash tables, iteration, loop over a dict, keys, values, entries, to_list, each, fold, map_values, filter, for in, Object.keys, Object.values

import gleam/dict
import gleam/io
import gleam/list
import gleam/string

pub fn main() {
  let paints =
    dict.from_list([
      #("red", "cadmium"),
      #("blue", "cobalt"),
      #("green", "viridian"),
    ])

  // keys and values. they come out in no particular order, so sort them
  // if you care
  assert paints |> dict.keys |> list.sort(string.compare)
    == ["blue", "green", "red"]
  assert paints |> dict.values |> list.sort(string.compare)
    == ["cadmium", "cobalt", "viridian"]

  // the entries, as a list of pairs
  let entries =
    paints
    |> dict.to_list
    |> list.sort(fn(a, b) { string.compare(a.0, b.0) })
  assert entries
    == [#("blue", "cobalt"), #("green", "viridian"), #("red", "cadmium")]

  // for (const key in obj)
  dict.each(paints, fn(color, pigment) {
    io.println("paints[" <> color <> "] = " <> pigment)
  })

  // in a known order: go through the sorted entries
  list.each(entries, fn(entry) { io.println(entry.0 <> ": " <> entry.1) })

  // a new dict with every value changed
  let shouting = dict.map_values(paints, fn(_color, p) { string.uppercase(p) })
  assert dict.get(shouting, "red") == Ok("CADMIUM")

  // a new dict with only some of the entries
  let short =
    dict.filter(paints, fn(color, _pigment) { string.length(color) < 5 })
  assert dict.keys(short) |> list.sort(string.compare) == ["blue", "red"]

  // boil it down to one value
  assert dict.fold(paints, 0, fn(total, _color, p) { total + string.length(p) })
    == 21
}
