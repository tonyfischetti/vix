// gleam, terminal io, output colored text, colors, ansi, escape codes, bold, underline, background color, hex color, strip colors

// gleam add gleam_community_ansi

import gleam/io
import gleam/string
import gleam_community/ansi

pub fn main() {
  // each one wraps the string in the escape codes and gives it back
  io.println(ansi.red("red"))
  io.println(ansi.green("green"))
  io.println(ansi.bright_blue("bright blue"))
  io.println(ansi.bold("bold") <> " and " <> ansi.underline("underlined"))

  // they stack, so they pipe
  "white on red, bold"
  |> ansi.white
  |> ansi.bg_red
  |> ansi.bold
  |> io.println

  // any color, as a hex number
  io.println(ansi.hex("orange-ish", 0xff9900))
  io.println(ansi.bg_hex("  a bar of purple  ", 0x663399))

  // the escape codes are in the string, so it's longer than it looks
  let warning = ansi.yellow("careful")
  assert string.length(warning) > string.length("careful")

  // take them back out (for a log file, or to measure the text)
  assert ansi.strip(warning) == "careful"
}
