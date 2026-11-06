// gleam, terminal io, read a keypress, single key, raw mode, press any key, yes or no prompt, confirm, without enter, arrow keys, getch, external, erlang

// gleam add gleam_erlang

// Normally the terminal holds on to what's typed until Enter. In "raw"
// mode every key arrives the moment it's pressed, and isn't printed.
// There's no Gleam function for it, but Erlang has one (since OTP 28)
// and it only takes an `@external` to call it (see "Externals")

import gleam/dynamic.{type Dynamic}
import gleam/dynamic/decode
import gleam/erlang/atom.{type Atom}
import gleam/io
import gleam/result
import gleam/string

@external(erlang, "shell", "start_interactive")
fn start_interactive(mode: #(Atom, Atom)) -> Dynamic

@external(erlang, "io", "get_chars")
fn get_chars(prompt: String, count: Int) -> Dynamic

// True if the terminal went along with it. (it can't if there isn't
// one: when the input is a pipe, say)
fn set_raw_mode(raw: Bool) -> Bool {
  let mode = case raw {
    True -> "raw"
    False -> "cooked"
  }
  // Erlang wants the tuple `{noshell, raw}`, and answers with the atom `ok`
  start_interactive(#(atom.create("noshell"), atom.create(mode)))
  == atom.to_dynamic(atom.create("ok"))
}

// waits for a key. a key can be more than one character (the arrows send
// three), so this asks for "up to 8" and gets however many there are.
// Error(Nil) is the end of the input
fn read_key() -> Result(String, Nil) {
  // what comes back is a string, or the atom `eof`
  get_chars("", 8)
  |> decode.run(decode.string)
  |> result.replace_error(Nil)
}

fn confirm(question: String) -> Bool {
  io.print(question <> " [y/n] ")
  case read_key() {
    Ok("y") | Ok("Y") -> True
    Ok("n") | Ok("N") | Error(Nil) -> False
    // any other key: wipe the line and ask again
    Ok(_) -> {
      io.print("\r\u{001b}[2K")
      confirm(question)
    }
  }
}

pub fn main() {
  case set_raw_mode(True) {
    False -> io.println("this needs a terminal")
    True -> {
      io.print("press any key to continue ")
      let _ = read_key()

      //  WARN  in raw mode a newline only goes DOWN. it takes "\r\n" to
      //        get back to the left edge as well, so no `println`
      io.print("\r\n")

      let more = confirm("more tea?")
      io.print(
        case more {
          True -> "yes please"
          False -> "no thank you"
        }
        <> "\r\n",
      )

      io.print("now an arrow key: ")
      let pressed = case read_key() {
        // these are what the terminal sends for the arrows
        Ok("\u{001b}[A") -> "up"
        Ok("\u{001b}[B") -> "down"
        Ok("\u{001b}[C") -> "right"
        Ok("\u{001b}[D") -> "left"
        Ok("\r") -> "enter"
        Ok("\u{001b}") -> "escape"
        Ok(other) -> "not an arrow, that was " <> string.inspect(other)
        Error(Nil) -> "the end of the input"
      }
      io.print(pressed <> "\r\n")

      // put the terminal back the way it was
      let _ = set_raw_mode(False)
      Nil
    }
  }
  //  NOTE  ctrl-c still goes to Erlang, which answers with its BREAK
  //        menu. ctrl-c a second time quits
  //
  //  NOTE  "Arrow key menu" puts this to work
}
