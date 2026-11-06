// gleam, terminal io, ansi escape sequences, escape codes, csi, cursor, move cursor, hide cursor, clear screen, clear line, carriage return, rewrite a line, 256 colors, truecolor, rgb, alternate screen, tui

// gleam add gleam_erlang

// An escape sequence is the ESC character (27), a `[`, some numbers and a
// letter. The terminal obeys it instead of printing it. They're only
// strings, so no package is needed (though "Output colored text" has one
// for the colors)

import gleam/erlang/process
import gleam/int
import gleam/io

// every sequence starts with this (the "CSI")
const esc = "\u{001b}["

// ***** moving the cursor

// A is up. B, C and D are down, right and left
fn up(lines: Int) -> String {
  esc <> int.to_string(lines) <> "A"
}

fn down(lines: Int) -> String {
  esc <> int.to_string(lines) <> "B"
}

// the row comes first, and both count from 1
fn move_to(row: Int, column: Int) -> String {
  esc <> int.to_string(row) <> ";" <> int.to_string(column) <> "H"
}

// (not an escape sequence, a plain carriage return)
const start_of_line = "\r"

const hide_cursor = esc <> "?25l"

const show_cursor = esc <> "?25h"

// ***** erasing

const clear_line = esc <> "2K"

const clear_to_end_of_line = esc <> "K"

const clear_screen = esc <> "2J"

// ***** styles. the numbers stack with `;` and `0` puts everything back

const reset = esc <> "0m"

const bold_red = esc <> "1;31m"

// one of the 256 colors. `38` is the text, `48` is the background
fn color_256(color: Int) -> String {
  esc <> "38;5;" <> int.to_string(color) <> "m"
}

// any color at all
fn background_rgb(red: Int, green: Int, blue: Int) -> String {
  esc
  <> "48;2;"
  <> int.to_string(red)
  <> ";"
  <> int.to_string(green)
  <> ";"
  <> int.to_string(blue)
  <> "m"
}

// ***** the alternate screen: a blank screen of your own (what vim and
// less use). leaving it puts back whatever was there before

const enter_alternate_screen = esc <> "?1049h"

const leave_alternate_screen = esc <> "?1049l"

pub fn main() {
  assert up(2) == "\u{001b}[2A"
  assert move_to(5, 10) == "\u{001b}[5;10H"

  io.println(bold_red <> "bold red" <> reset)
  io.println(color_256(208) <> "color 208 of 256" <> reset)
  io.println(background_rgb(102, 51, 153) <> "  a bar of purple  " <> reset)

  // a line that rewrites itself: back to the start, wipe it, print again.
  // (`print` and not `println`, to stay on the line)
  io.print(hide_cursor)
  countdown(3)
  io.println(start_of_line <> clear_line <> "liftoff")
  //  WARN  a hidden cursor stays hidden after the program ends. always
  //        show it again
  io.print(show_cursor)

  // going back up to change a line that's already printed
  io.println("twinkle twinkle little bat")
  io.println("how I wonder what you're at")
  process.sleep(500)
  io.print(up(2) <> start_of_line <> "TWINKLE" <> clear_to_end_of_line)
  io.print(down(2) <> start_of_line)

  // a whole screen to draw on, and then everything back as it was
  io.print(enter_alternate_screen <> clear_screen)
  io.print(move_to(5, 10) <> "row 5, column 10")
  io.print(move_to(1, 1) <> "top left")
  process.sleep(1500)
  io.print(leave_alternate_screen)
  //  NOTE  when the output is going into a file or a pipe, all of these
  //        end up in it as junk. `ansi.strip` takes them out again (see
  //        "Output colored text")
}

fn countdown(from: Int) -> Nil {
  case from {
    0 -> Nil
    _ -> {
      io.print(start_of_line <> clear_line <> "T minus " <> int.to_string(from))
      process.sleep(500)
      countdown(from - 1)
    }
  }
}
