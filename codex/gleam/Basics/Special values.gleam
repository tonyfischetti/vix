// gleam, basics, special values, null, undefined, nil, bottom values, option, result, check if null, testing for special values, nan, infinity, special numbers

// There is no null and no undefined. A String is always a String.
// "It might not be there" has to be said in the type...
//
//   Option(a)     Some(value) or None          it's optional, on purpose
//   Result(a, e)  Ok(value)   or Error(reason) it can fail
//
// ...and then the compiler won't let you forget the other case.

import gleam/dict
import gleam/float
import gleam/option.{type Option, None, Some}
import gleam/result

type User {
  User(name: String, nickname: Option(String))
}

pub fn main() {
  // Nil is a real value with its own type (think `void`). functions that
  // have nothing to return, return it. it is not null: nothing else can
  // ever be Nil
  let nothing = Nil
  assert nothing == Nil

  // ***** Option *************************************
  let william = User(name: "William", nickname: Some("Bill"))
  let ann = User(name: "Ann", nickname: None)
  assert display_name(william) == "Bill"
  assert display_name(ann) == "Ann"

  // or with a default, instead of a `case`
  assert option.unwrap(ann.nickname, or: "(none)") == "(none)"

  // ***** Result *************************************
  // what you get back from anything that can come up empty or fail
  let paints = dict.from_list([#("red", "cadmium")])
  assert dict.get(paints, "red") == Ok("cadmium")
  // (when there's nothing more to say about the failure, the error is Nil)
  assert dict.get(paints, "puce") == Error(Nil)

  assert result.unwrap(dict.get(paints, "puce"), or: "idk") == "idk"
  assert result.is_error(dict.get(paints, "puce"))

  // ***** numbers ************************************
  // no NaN and no Infinity either
  //   - dividing by zero is 0
  //   - parsing garbage is an Error
  assert 1.0 /. 0.0 == 0.0
  assert float.parse("NaN") == Error(Nil)
  assert float.parse("Infinity") == Error(Nil)
}

fn display_name(user: User) -> String {
  case user.nickname {
    Some(nickname) -> nickname
    None -> user.name
  }
}
