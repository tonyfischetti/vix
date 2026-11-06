// gleam, databases, sqlite, decode rows, records, custom types, decoder, row to record, null, option, optional column, boolean, join, find one, sqlight

// gleam add sqlight

import gleam/dynamic/decode.{type Decoder}
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/result
import sqlight

type Artist {
  Artist(
    id: Int,
    first_name: Option(String),
    last_name: String,
    born_on: Option(Int),
  )
}

type Painting {
  Painting(name: String, year: Int, postwar: Bool)
}

// columns are picked out by position, so the decoder has to agree with
// the SELECT list. spell the columns out (no `SELECT *`)
fn artist_decoder() -> Decoder(Artist) {
  use id <- decode.field(0, decode.int)
  // a column that can be NULL is an Option
  use first_name <- decode.field(1, decode.optional(decode.string))
  use last_name <- decode.field(2, decode.string)
  use born_on <- decode.field(3, decode.optional(decode.int))
  decode.success(Artist(id:, first_name:, last_name:, born_on:))
}

// the idiom is a function per query: the SQL, the values and the decoder
// stay together, and everyone else gets a properly typed result
fn artists_born_after(
  conn: sqlight.Connection,
  year: Int,
) -> Result(List(Artist), sqlight.Error) {
  sqlight.query(
    "SELECT artist_id, first_name, last_name, born_on
       FROM artists
       WHERE born_on > ? OR born_on IS NULL
       ORDER BY artist_id",
    on: conn,
    with: [sqlight.int(year)],
    expecting: artist_decoder(),
  )
}

// one row or none: the Option says that there might not be one, and the
// Result says that the database might have complained
fn find_artist(
  conn: sqlight.Connection,
  last_name: String,
) -> Result(Option(Artist), sqlight.Error) {
  sqlight.query(
    "SELECT artist_id, first_name, last_name, born_on
       FROM artists
       WHERE last_name = ?
       LIMIT 1",
    on: conn,
    with: [sqlight.text(last_name)],
    expecting: artist_decoder(),
  )
  |> result.map(fn(rows) { list.first(rows) |> option.from_result })
}

fn paintings_by(
  conn: sqlight.Connection,
  last_name: String,
) -> Result(List(Painting), sqlight.Error) {
  let decoder = {
    use name <- decode.field(0, decode.string)
    use year <- decode.field(1, decode.int)
    //  WARN  SQLite has no booleans, a comparison gives 0 or 1.
    //        `decode.bool` won't take those, `sqlight.decode_bool` will
    use postwar <- decode.field(2, sqlight.decode_bool())
    decode.success(Painting(name:, year:, postwar:))
  }

  sqlight.query(
    "SELECT painting_name, year_completed, year_completed > 1945
       FROM paintings
         INNER JOIN artists USING (artist_id)
       WHERE last_name = ?
       ORDER BY year_completed",
    on: conn,
    with: [sqlight.text(last_name)],
    expecting: decoder,
  )
}

pub fn main() {
  use conn <- sqlight.with_connection(":memory:")
  let assert Ok(Nil) = sqlight.exec(art, conn)

  // someone with NULLs for a first name and a year of birth
  let assert Ok(Nil) =
    sqlight.exec("INSERT INTO artists (last_name) VALUES ('Banksy')", conn)

  assert artists_born_after(conn, 1950)
    == Ok([
      Artist(5, Some("Jean-Michel"), "Basquiat", Some(1960)),
      Artist(6, None, "Banksy", None),
    ])

  assert find_artist(conn, "Sage")
    == Ok(Some(Artist(1, Some("Kay"), "Sage", Some(1898))))
  assert find_artist(conn, "Vermeer") == Ok(None)

  assert paintings_by(conn, "Magritte")
    == Ok([
      Painting("The Human Condition", 1935, False),
      Painting("The Treachery of Images", 1948, True),
      Painting("The Son of Man", 1964, True),
    ])
  //  NOTE  the other column types: REAL is `decode.float`, BLOB is
  //        `decode.bit_array`
}

// the art database (see "Create tables and insert rows")
const art =
  "
CREATE TABLE artists (
  artist_id INTEGER PRIMARY KEY, first_name TEXT, last_name TEXT NOT NULL,
  born_on INTEGER CHECK(born_on > 1870)
) STRICT;
CREATE TABLE paintings (
  painting_id INTEGER PRIMARY KEY, artist_id INTEGER REFERENCES artists,
  painting_name TEXT CHECK(LENGTH(painting_name) > 1),
  year_completed INTEGER CHECK(year_completed > 1800)
) STRICT;
INSERT INTO artists (first_name, last_name, born_on) VALUES
  ('Kay', 'Sage', 1898), ('Piet', 'Mondrian', 1872), ('Rene', 'Magritte', 1898),
  ('', 'Man Ray', 1890), ('Jean-Michel', 'Basquiat', 1960);
INSERT INTO paintings (artist_id, painting_name, year_completed) VALUES
  (4, 'Orquesta Sinfonica', 1916), (4, 'La Fortune', 1938),
  (1, 'Tomorrow is Never', 1955), (1, 'The Answer is No', 1958),
  (1, 'No Passing', 1954), (5, 'Bird on Money', 1981),
  (2, 'Place de la Concorde', 1943), (2, 'Composition No. 10', 1942),
  (3, 'The Human Condition', 1935), (3, 'The Treachery of Images', 1948),
  (3, 'The Son of Man', 1964);
"
