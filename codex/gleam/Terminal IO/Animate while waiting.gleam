// gleam, terminal io, concurrency, loading animation, animate while waiting, wait for a result, receive with timeout, process, spawn, frames, bouncing, by hand

// gleam add gleam_erlang

// A loading animation with no package: the work goes into another
// process and this one draws. `process.receive` with a timeout is the
// clock. Either the answer turns up, or it's time for the next frame

import gleam/erlang/process.{type Subject}
import gleam/int
import gleam/io
import gleam/string

// a dot going back and forth:  0 1 2 3 2 1 0 1 2 ...
fn bounce(frame: Int, width: Int) -> String {
  let there_and_back = { width - 1 } * 2
  let step = frame % there_and_back
  let position = case step < width {
    True -> step
    False -> there_and_back - step
  }
  string.repeat(" ", position)
  <> "●"
  <> string.repeat(" ", width - 1 - position)
}

fn wait_for(answer: Subject(a), label: String, frame: Int) -> a {
  case process.receive(answer, within: 60) {
    // it's here. wipe the animation and hand it over
    Ok(value) -> {
      io.print("\r\u{001b}[2K")
      value
    }
    // 60ms went by with nothing: draw, and wait again
    Error(Nil) -> {
      io.print("\r\u{001b}[2K[" <> bounce(frame, 12) <> "] " <> label)
      wait_for(answer, label, frame + 1)
    }
  }
}

// (something that takes a while)
fn count_the_treacle_wells() -> Int {
  process.sleep(2500)
  3
}

pub fn main() {
  assert bounce(0, 4) == "●   "
  assert bounce(3, 4) == "   ●"
  assert bounce(4, 4) == "  ● "
  assert bounce(6, 4) == "●   "

  // the answer comes back as a message to this subject
  let answer = process.new_subject()
  process.spawn(fn() { process.send(answer, count_the_treacle_wells()) })

  let wells = wait_for(answer, "counting the treacle wells", 0)
  io.println(int.to_string(wells) <> " treacle wells")
  //  NOTE  the "spinner" package does the same job the other way round:
  //        the animation is the process, and the work stays in this one
  //        (see "Loading spinner")
}
