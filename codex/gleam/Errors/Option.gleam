// gleam, errors, option, some, none, optional value, nullable, maybe, null, default value, to_result, from_result

// Option is for data that's allowed to be absent: a field, an argument.
// (For "the operation failed", or "the lookup found nothing", the
// convention is a Result.)

import gleam/option.{type Option, None, Some}
import gleam/string

type Person {
  Person(first: String, middle: Option(String), last: String)
}

pub fn main() {
  let ringo = Person(first: "Richard", middle: None, last: "Starkey")
  let paul = Person(first: "James", middle: Some("Paul"), last: "McCartney")

  assert full_name(ringo) == "Richard Starkey"
  assert full_name(paul) == "James Paul McCartney"

  // a default
  assert option.unwrap(ringo.middle, or: "(none)") == "(none)"

  // change what's inside, if there's anything inside
  assert option.map(paul.middle, string.uppercase) == Some("PAUL")
  assert option.map(ringo.middle, string.uppercase) == None

  assert option.is_some(paul.middle)
  assert option.is_none(ringo.middle)

  // the first one that's there
  assert option.or(ringo.middle, Some("Ringo")) == Some("Ringo")

  // to and from Result
  assert option.to_result(ringo.middle, "no middle name")
    == Error("no middle name")
  assert option.from_result(Ok(1)) == Some(1)
  assert option.from_result(Error("anything")) == None

  // keep the ones that are there
  assert option.values([Some(1), None, Some(3)]) == [1, 3]
}

fn full_name(person: Person) -> String {
  case person.middle {
    Some(middle) -> person.first <> " " <> middle <> " " <> person.last
    None -> person.first <> " " <> person.last
  }
}
