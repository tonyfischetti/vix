// gleam, functions, default arguments, default args, optional parameters, options record, record update, builder pattern, config

// There are no default arguments and no optional ones: a function takes
// exactly the arguments it says it does. These are the usual ways around it

import gleam/int
import gleam/option.{type Option, None, Some}

pub fn main() {
  // 1. two functions. the short one calls the long one
  assert check_with(1, 1) == #(1, 1)
  assert check(2) == #(2, 1)

  // 2. an options record, with a function that makes the defaults.
  //    the caller overrides what they want with a record update
  assert describe(default_options()) == "localhost:8080"
  assert describe(Options(..default_options(), port: 3000)) == "localhost:3000"

  // 3. the builder: start from the defaults and pipe through functions
  //    that each set one thing. libraries do this a lot
  let options = default_options() |> port(9000) |> verbose
  assert options == Options(port: 9000, host: "localhost", verbose: True)

  // 4. an Option, for a single thing that may or may not be given
  assert greet("Joe", None) == "Hello, Joe!"
  assert greet("Joe", Some("Howdy")) == "Howdy, Joe!"
}

fn check_with(a: Int, b: Int) -> #(Int, Int) {
  #(a, b)
}

fn check(a: Int) -> #(Int, Int) {
  check_with(a, 1)
}

type Options {
  Options(port: Int, host: String, verbose: Bool)
}

fn default_options() -> Options {
  Options(port: 8080, host: "localhost", verbose: False)
}

fn describe(options: Options) -> String {
  options.host <> ":" <> int.to_string(options.port)
}

fn port(options: Options, port: Int) -> Options {
  Options(..options, port:)
}

fn verbose(options: Options) -> Options {
  Options(..options, verbose: True)
}

fn greet(name: String, greeting: Option(String)) -> String {
  option.unwrap(greeting, or: "Hello") <> ", " <> name <> "!"
}
