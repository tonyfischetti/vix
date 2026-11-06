// gleam, terminal io, print a table, table, aligned columns, rows, header, box drawing, borders, wrap text, tobble, title

// gleam add tobble

import gleam/int
import gleam/io
import gleam/list
import tobble
import tobble/table_render_opts as option

pub fn main() {
  // a row is a list of strings, and the first row is the header
  let assert Ok(table) =
    tobble.builder()
    |> tobble.add_row(["artist_name", "painting_name"])
    |> tobble.add_row(["Sage, Kay", "Tomorrow is Never"])
    |> tobble.add_row(["Mondrian, Piet", "Composition No. 10"])
    |> tobble.add_row(["Magritte, Rene", "The Son of Man"])
    |> tobble.build

  // `render` makes the string. it doesn't print anything
  assert tobble.render(table) == "+----------------+--------------------+
| artist_name    | painting_name      |
+----------------+--------------------+
| Sage, Kay      | Tomorrow is Never  |
| Mondrian, Piet | Composition No. 10 |
| Magritte, Rene | The Son of Man     |
+----------------+--------------------+"

  // proper lines
  io.println(
    tobble.render_with_options(table, [
      option.line_type_box_drawing_characters(),
    ]),
  )

  // no lines at all, only the columns lined up
  io.println(
    tobble.render_with_options(table, [
      option.line_type_blank(),
      option.no_horizontal_rules(),
    ]),
  )

  // squeezed into 30 columns. the text wraps inside its cell
  io.println(
    tobble.render_with_options(table, [
      option.line_type_rounded_corner_box_drawing_characters(),
      option.horizontal_rules_after_every_row(),
      option.table_width(30),
    ]),
  )

  // rows out of data: fold them into the builder. everything has to be
  // a String by the time it goes in
  let paintings = [
    #("Orquesta Sinfonica", 1916),
    #("La Fortune", 1938),
    #("Bird on Money", 1981),
  ]
  let assert Ok(table) =
    list.fold(
      paintings,
      tobble.builder()
        |> tobble.set_title("Paintings")
        |> tobble.add_row(["painting_name", "year_completed"]),
      fn(builder, painting) {
        tobble.add_row(builder, [painting.0, int.to_string(painting.1)])
      },
    )
    |> tobble.build
  io.println(tobble.render(table))

  // `build` gives a Result because some tables can't be drawn
  assert tobble.builder()
    |> tobble.add_row(["a", "b"])
    |> tobble.add_row(["c"])
    |> tobble.build
    == Error(tobble.InconsistentColumnCountError(expected: 2, got: 1))

  assert tobble.build(tobble.builder()) == Error(tobble.EmptyTableError)
}
