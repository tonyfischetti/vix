// gleam, dicts, hash tables, dictionary, map, objects, create a hash table, get, insert, delete, has_key, upsert, merge, take, drop

import gleam/dict
import gleam/option.{None, Some}

pub fn main() {
  // from a list of pairs
  let paints =
    dict.from_list([
      #("red", "cadmium"),
      #("blue", "cobalt"),
      #("black", "lamp"),
    ])

  // or start empty and add to it
  let same =
    dict.new()
    |> dict.insert("red", "cadmium")
    |> dict.insert("blue", "cobalt")
    |> dict.insert("black", "lamp")
  assert same == paints

  assert dict.size(paints) == 3

  // a lookup is a Result, since the key might not be there
  assert dict.get(paints, "red") == Ok("cadmium")
  assert dict.get(paints, "puce") == Error(Nil)
  assert dict.has_key(paints, "blue")

  // `insert` adds or replaces. like everything else, it returns a NEW dict
  let paints = dict.insert(paints, "green", "viridian")
  let paints = dict.insert(paints, "blue", "phthalo")
  assert dict.get(paints, "blue") == Ok("phthalo")

  let paints = dict.delete(paints, "black")
  assert !dict.has_key(paints, "black")

  // change a value based on what's there (or isn't) already
  let paints =
    dict.upsert(paints, "green", fn(existing) {
      case existing {
        Some(pigment) -> pigment <> " hue"
        None -> "sap"
      }
    })
  assert dict.get(paints, "green") == Ok("viridian hue")

  // merge. when both have a key, the second one wins
  let more = dict.from_list([#("red", "vermilion"), #("white", "titanium")])
  let all = dict.merge(into: paints, from: more)
  assert dict.get(all, "red") == Ok("vermilion")
  assert dict.size(all) == 4

  // only some keys / all but some keys
  assert dict.take(all, ["red", "white"]) == more
  assert dict.size(dict.drop(all, ["red", "white"])) == 2

  // keys can be any type (so can values), as long as they're all the same
  let by_point = dict.from_list([#(#(0, 0), "origin"), #(#(1, 0), "east")])
  assert dict.get(by_point, #(1, 0)) == Ok("east")
  //  NOTE  a Dict has no order. sort what comes out of `to_list` or `keys`
  //        if the order matters
}
