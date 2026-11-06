// gleam, databases, sqlite, query, select, where, parameters, placeholders, bind values, sql injection, sqlight, decode rows, like, count, no rows, one row

// gleam add sqlight

import gleam/dynamic/decode
import sqlight

pub fn main() {
  use conn <- sqlight.with_connection(":memory:")
  let assert Ok(Nil) = sqlight.exec(art, conn)

  // a row comes back as a tuple, so the decoder picks columns out by
  // position. you get a list with one decoded thing per row

  // one column
  let name = decode.at([0], decode.string)

  assert sqlight.query(
      "SELECT painting_name FROM paintings
        WHERE year_completed < 1940
        ORDER BY year_completed",
      on: conn,
      with: [],
      expecting: name,
    )
    == Ok(["Orquesta Sinfonica", "The Human Condition", "La Fortune"])

  // two columns, into a tuple
  let name_and_year = {
    use name <- decode.field(0, decode.string)
    use year <- decode.field(1, decode.int)
    decode.success(#(name, year))
  }

  // values go in through `?` placeholders, in order. each one is wrapped
  // to say what SQLite type it is: sqlight.text, int, float, bool, blob

  //  WARN  never build the SQL by gluing a value into the string.
  //        that's what SQL injection is

  // all paintings done by Kay Sage
  let by_artist =
    "SELECT painting_name, year_completed
       FROM paintings
       WHERE artist_id = (
         SELECT artist_id
         FROM artists
         WHERE last_name = ?)"

  assert sqlight.query(
      by_artist,
      on: conn,
      with: [sqlight.text("Sage")],
      expecting: name_and_year,
    )
    == Ok([
      #("Tomorrow is Never", 1955),
      #("The Answer is No", 1958),
      #("No Passing", 1954),
    ])

  // nothing found is an empty list, not an Error
  assert sqlight.query(
      by_artist,
      on: conn,
      with: [sqlight.text("Vermeer")],
      expecting: name_and_year,
    )
    == Ok([])

  // when there has to be exactly one row, say so with the pattern
  let assert Ok([how_many]) =
    sqlight.query(
      "SELECT COUNT(*) FROM paintings WHERE year_completed BETWEEN ? AND ?",
      on: conn,
      with: [sqlight.int(1940), sqlight.int(1959)],
      expecting: decode.at([0], decode.int),
    )
  assert how_many == 6

  // for LIKE, the wildcards go in the value, not around the `?`
  assert sqlight.query(
      "SELECT painting_name FROM paintings WHERE painting_name LIKE ?",
      on: conn,
      with: [sqlight.text("The %")],
      expecting: name,
    )
    == Ok([
      "The Answer is No",
      "The Human Condition",
      "The Treachery of Images",
      "The Son of Man",
    ])

  // `?1`, `?2`... name a value by its position, to use it more than once
  assert sqlight.query(
      "SELECT last_name FROM artists WHERE first_name = ?1 OR last_name = ?1",
      on: conn,
      with: [sqlight.text("Man Ray")],
      expecting: name,
    )
    == Ok(["Man Ray"])

  //  WARN  give it too few values and the rest are quietly NULL. that's
  //        not an Error, just a query that (probably) finds nothing
  assert sqlight.query(by_artist, on: conn, with: [], expecting: name_and_year)
    == Ok([])
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
