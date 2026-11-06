// gleam, data formats, json, encode, serialize, serialization, JSON.stringify, toJSON, object, array, null, nullable

// gleam add gleam_json

import gleam/dict
import gleam/json.{type Json}
import gleam/option.{type Option, None, Some}

type Animal {
  Animal(name: String, sound: Option(String), legs: Int)
}

pub fn main() {
  let cow = Animal(name: "Bessie", sound: Some("moo"), legs: 4)
  let birb = Animal(name: "Captain", sound: None, legs: 2)

  assert cow |> animal_to_json |> json.to_string
    == "{\"name\":\"Bessie\",\"sound\":\"moo\",\"legs\":4}"

  // a None becomes null
  assert birb |> animal_to_json |> json.to_string
    == "{\"name\":\"Captain\",\"sound\":null,\"legs\":2}"

  // a list, given the function that encodes one element
  assert json.array([cow, birb], of: animal_to_json) |> json.to_string
    == "[{\"name\":\"Bessie\",\"sound\":\"moo\",\"legs\":4},"
    <> "{\"name\":\"Captain\",\"sound\":null,\"legs\":2}]"

  // the other kinds of value
  let everything =
    json.object([
      #("string", json.string("twinkle")),
      #("int", json.int(850)),
      #("float", json.float(1.618)),
      #("bool", json.bool(True)),
      #("null", json.null()),
      #("array", json.array([1, 2, 3], of: json.int)),
    ])
  assert json.to_string(everything)
    == "{\"string\":\"twinkle\",\"int\":850,\"float\":1.618,\"bool\":true,"
    <> "\"null\":null,\"array\":[1,2,3]}"

  // a Dict: say how to make a string out of a key, and JSON out of a value
  let paints = dict.from_list([#("red", "cadmium")])
  assert json.dict(paints, fn(color) { color }, json.string) |> json.to_string
    == "{\"red\":\"cadmium\"}"
}

// nothing is serialized automatically. for each type you write a function
// that says what its JSON looks like (the language server will write it
// for you: the "Generate to-JSON function" code action)
fn animal_to_json(animal: Animal) -> Json {
  json.object([
    #("name", json.string(animal.name)),
    #("sound", json.nullable(animal.sound, of: json.string)),
    #("legs", json.int(animal.legs)),
  ])
}
