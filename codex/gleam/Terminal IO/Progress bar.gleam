// gleam, terminal io, progress bar, loading bar, percent, percentage done, carriage return, rewrite a line, index_fold, block characters

// gleam add gleam_erlang

import gleam/erlang/process
import gleam/int
import gleam/io
import gleam/list
import gleam/string

// the bar itself is only a string
fn bar(done: Int, total: Int, width: Int) -> String {
  let filled = done * width / total
  string.repeat("█", filled) <> string.repeat("░", width - filled)
}

// redraw it where the last one was: back to the start of the line, wipe
// the line, print. no newline, so the next one lands on top of it
fn draw(done: Int, total: Int, label: String) -> Nil {
  let percent = int.to_string(done * 100 / total)
  io.print(
    "\r\u{001b}[2K"
    <> bar(done, total, 30)
    <> " "
    <> string.pad_start(percent, to: 3, with: " ")
    <> "% "
    <> label,
  )
}

pub fn main() {
  assert bar(0, 10, 10) == "░░░░░░░░░░"
  assert bar(5, 10, 10) == "█████░░░░░"
  assert bar(10, 10, 10) == "██████████"

  let paints = ["cadmium red", "cobalt blue", "viridian", "raw umber", "ochre"]
  let total = list.length(paints)

  // `index_fold` hands over each item along with its position
  list.index_fold(paints, Nil, fn(_, paint, index) {
    draw(index, total, "mixing " <> paint)
    // (the work)
    process.sleep(400)
  })

  draw(total, total, "done")
  // and now the newline, to keep the finished bar on the screen
  io.println("")
}
