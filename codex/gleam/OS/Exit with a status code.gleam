// gleam, os, exit, exit code, status code, program termination, halt, process.exit, external

import gleam/io

pub fn main() {
  // when `main` returns, the program ends with status 0.
  // (a crash, like a failed `let assert`, ends it with status 1)

  io.println_error("something went wrong")
  exit(3)

  io.println("this never gets printed")
}

// for any other status there's nothing in the standard library, but both
// runtimes have a function for it
@external(erlang, "erlang", "halt")
@external(javascript, "node:process", "exit")
fn exit(status: Int) -> Nil
//  NOTE  if you already depend on `shellout`, it has this: `shellout.exit(3)`
