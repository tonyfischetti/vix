// gleam, data formats, json, decode, parse, deserialize, JSON.parse, decoder, dynamic, optional field, nested field, validation

// gleam add gleam_json

import gleam/dict
import gleam/dynamic/decode.{type Decoder}
import gleam/int
import gleam/json
import gleam/option.{type Option, None, Some}

type Animal {
  Animal(name: String, sound: Option(String), legs: Int)
}

// JSON can't be parsed into "whatever it is". you describe the shape you
// expect with a decoder, and get back a properly typed value or an Error.
// (the language server will write this one for you: the "Generate dynamic
// decoder" code action)
fn animal_decoder() -> Decoder(Animal) {
  use name <- decode.field("name", decode.string)
  use legs <- decode.field("legs", decode.int)
  // this field can be missing (then it's None) or null (also None)
  use sound <- decode.optional_field(
    "sound",
    None,
    decode.optional(decode.string),
  )
  decode.success(Animal(name:, sound:, legs:))
}

pub fn main() {
  let cow = "{\"name\":\"Bessie\",\"sound\":\"moo\",\"legs\":4}"
  assert json.parse(cow, animal_decoder())
    == Ok(Animal(name: "Bessie", sound: Some("moo"), legs: 4))

  assert json.parse("{\"name\":\"Captain\",\"legs\":2}", animal_decoder())
    == Ok(Animal(name: "Captain", sound: None, legs: 2))

  // the wrong shape. the error says what it wanted, what it got and where
  assert json.parse("{\"name\":\"Captain\",\"legs\":\"two\"}", animal_decoder())
    == Error(
      json.UnableToDecode([
        decode.DecodeError(expected: "Int", found: "String", path: ["legs"]),
      ]),
    )

  // not JSON at all
  assert json.parse("{\"name\":", animal_decoder())
    == Error(json.UnexpectedEndOfInput)

  // decoders are built out of smaller ones

  assert json.parse("[1, 2, 3]", decode.list(decode.int)) == Ok([1, 2, 3])

  assert json.parse("[" <> cow <> "]", decode.list(animal_decoder()))
    == Ok([Animal("Bessie", Some("moo"), 4)])

  // reach in for one thing and ignore the rest
  assert json.parse(
      "{\"a\": {\"b\": [10, 20]}, \"c\": true}",
      decode.at(["a", "b"], decode.list(decode.int)),
    )
    == Ok([10, 20])

  // an object with any keys at all
  assert json.parse(
      "{\"red\": 1, \"blue\": 2}",
      decode.dict(decode.string, decode.int),
    )
    == Ok(dict.from_list([#("red", 1), #("blue", 2)]))

  // either a string or a number, ending up as a String
  let stringish =
    decode.one_of(decode.string, or: [decode.int |> decode.map(int.to_string)])
  assert json.parse("12", stringish) == Ok("12")
  assert json.parse("\"twelve\"", stringish) == Ok("twelve")
}
