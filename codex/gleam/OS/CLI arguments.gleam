// gleam, os, argv, cli arguments, command line arguments, parse arguments, subcommands, pattern matching, usage

// gleam add argv

import argv
import gleam/int
import gleam/io

pub fn main() {
  // gleam run -- add 850 11
  let args = argv.load()

  // only the arguments. the runtime and the program aren't in the list
  echo args.arguments
  // ["add", "850", "11"]
  echo args.program
  echo args.runtime

  // a list of strings is made for pattern matching
  io.println(run(args.arguments))

  assert run(["greet", "Joe"]) == "Hello, Joe!"
  assert run(["add", "850", "11"]) == "861"
  assert run(["add", "850", "eleven"]) == "those aren't numbers"
  assert run(["-h"]) == usage
  assert run([]) == usage
  assert run(["frobnicate", "x", "y"]) == "no such command: frobnicate"
}

const usage = "usage: thing greet <name> | thing add <a> <b>"

fn run(arguments: List(String)) -> String {
  case arguments {
    [] | ["-h"] | ["--help"] -> usage
    ["greet", name] -> "Hello, " <> name <> "!"
    ["add", a, b] ->
      case int.parse(a), int.parse(b) {
        Ok(a), Ok(b) -> int.to_string(a + b)
        _, _ -> "those aren't numbers"
      }
    [command, ..] -> "no such command: " <> command
  }
}
//  NOTE  for flags, defaults and generated help text there's the `glint`
//        package
