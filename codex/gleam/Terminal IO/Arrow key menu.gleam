// gleam, terminal io, arrow key menu, interactive menu, select from a list, pick one, choose, raw mode, keys, cursor, redraw, highlight, tui

// gleam add gleam_erlang

// A menu is raw mode (see "Read a keypress") and a few escape sequences
// (see "ANSI escape sequences"): draw the choices, wait for a key, go
// back up, draw them again

import gleam/bool
import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode
import gleam/erlang/atom.{type Atom}
import gleam/int
import gleam/io
import gleam/list
import gleam/string

pub fn main() {
  let paints = ["cadmium red", "cobalt blue", "viridian", "raw umber"]

  case pick("Which paint? (arrows or j/k, then enter)", paints) {
    Ok(paint) -> io.println("you picked " <> paint)
    Error(Nil) -> io.println("never mind")
  }
}

// Error(Nil) if nothing got picked (escape, q, or no terminal to ask in)
fn pick(question: String, choices: List(String)) -> Result(String, Nil) {
  use <- bool.guard(when: !set_raw_mode(True), return: Error(Nil))

  io.print(hide_cursor <> question <> "\r\n")
  draw(choices, 0)
  let picked = choose(choices, 0)

  // tidy up: back up over the menu and the question, wipe everything
  // from there down, cursor back, raw mode off
  io.print(up(list.length(choices) + 1) <> clear_down <> show_cursor)
  let _ = set_raw_mode(False)
  picked
}

// one line per choice with the selected one highlighted. the cursor ends
// up on the line under the menu
fn draw(choices: List(String), selected: Int) -> Nil {
  list.index_map(choices, fn(choice, index) {
    let line = case index == selected {
      True -> inverse <> " > " <> choice <> " " <> reset
      False -> "   " <> choice
    }
    clear_line <> line <> "\r\n"
  })
  |> string.concat
  |> io.print
}

fn choose(choices: List(String), selected: Int) -> Result(String, Nil) {
  let last = list.length(choices) - 1
  let select = fn(index) {
    io.print(up(list.length(choices)))
    draw(choices, index)
    choose(choices, index)
  }

  case read_key() {
    Up -> select(int.max(selected - 1, 0))
    Down -> select(int.min(selected + 1, last))
    Enter -> choices |> list.drop(selected) |> list.first
    Quit -> Error(Nil)
    Other -> choose(choices, selected)
  }
}

// ***** the keys

type Key {
  Up
  Down
  Enter
  Quit
  Other
}

fn read_key() -> Key {
  case get_chars("", 8) |> decode.run(decode.string) {
    Ok("\u{001b}[A") | Ok("k") -> Up
    Ok("\u{001b}[B") | Ok("j") -> Down
    Ok("\r") -> Enter
    // escape, q, or the input came to an end
    Ok("\u{001b}") | Ok("q") | Error(_) -> Quit
    Ok(_) -> Other
  }
}

@external(erlang, "io", "get_chars")
fn get_chars(prompt: String, count: Int) -> Dynamic

@external(erlang, "shell", "start_interactive")
fn start_interactive(mode: #(Atom, Atom)) -> Dynamic

fn set_raw_mode(raw: Bool) -> Bool {
  let mode = case raw {
    True -> "raw"
    False -> "cooked"
  }
  start_interactive(#(atom.create("noshell"), atom.create(mode)))
  == atom.to_dynamic(atom.create("ok"))
}

// ***** the escape sequences

const hide_cursor = "\u{001b}[?25l"

const show_cursor = "\u{001b}[?25h"

const clear_line = "\u{001b}[2K"

const clear_down = "\u{001b}[J"

// swaps the text color and the background color
const inverse = "\u{001b}[7m"

const reset = "\u{001b}[0m"

fn up(lines: Int) -> String {
  "\u{001b}[" <> int.to_string(lines) <> "A"
}
