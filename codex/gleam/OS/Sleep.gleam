// gleam, os, sleep, wait, delay, pause, setTimeout, milliseconds

// gleam add gleam_erlang

import gleam/erlang/process
import gleam/io

pub fn main() {
  io.println("twinkle")

  // milliseconds. only the process that calls it sleeps, everything else
  // that's running carries on
  process.sleep(500)

  io.println("twinkle")
  //  NOTE  to do something LATER without waiting around for it, send
  //        yourself a message with `process.send_after` (see "Actors")
}
