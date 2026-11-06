// gleam, databases, sqlite, insert, update, delete, returning, last insert id, new row id, rows affected, changes, null, nullable, parameters, sqlight

// gleam add sqlight

import gleam/dynamic/decode
import gleam/option.{type Option, None, Some}
import gleam/result
import sqlight

// a statement that takes values still goes through `query`, even when
// it has no rows to give back. the decoder never runs then, so any will do
fn run(
  conn: sqlight.Connection,
  sql: String,
  values: List(sqlight.Value),
) -> Result(Nil, sqlight.Error) {
  sqlight.query(sql, on: conn, with: values, expecting: decode.success(Nil))
  |> result.replace(Nil)
}

// RETURNING makes an INSERT hand back the row it made, so there's the
// new id
fn add_artist(
  conn: sqlight.Connection,
  first_name: Option(String),
  last_name: String,
  born_on: Int,
) -> Result(Int, sqlight.Error) {
  let values = [
    // an Option: None goes in as NULL
    sqlight.nullable(sqlight.text, first_name),
    sqlight.text(last_name),
    sqlight.int(born_on),
  ]
  use rows <- result.try(sqlight.query(
    "INSERT INTO artists (first_name, last_name, born_on)
       VALUES (?, ?, ?)
       RETURNING artist_id",
    on: conn,
    with: values,
    expecting: decode.at([0], decode.int),
  ))
  let assert [id] = rows
  Ok(id)
}

// how many rows the last INSERT, UPDATE or DELETE touched
fn changes(conn: sqlight.Connection) -> Int {
  let assert Ok([count]) =
    sqlight.query(
      "SELECT changes()",
      on: conn,
      with: [],
      expecting: decode.at([0], decode.int),
    )
  count
}

pub fn main() {
  use conn <- sqlight.with_connection(":memory:")
  let assert Ok(Nil) = sqlight.exec(art, conn)

  assert add_artist(conn, Some("Leonora"), "Carrington", 1917) == Ok(6)
  assert add_artist(conn, None, "Balthus", 1908) == Ok(7)

  // say we just found out that all kay sage paintings were completed
  // one year before previously thought
  let assert Ok(Nil) =
    run(
      conn,
      "UPDATE paintings
         SET year_completed = year_completed - 1
         WHERE artist_id = (
           SELECT artist_id
           FROM artists
           WHERE last_name = ?)",
      [sqlight.text("Sage")],
    )
  assert changes(conn) == 3

  // fake data for illustration
  let assert Ok(Nil) =
    run(
      conn,
      "INSERT INTO paintings (artist_id, painting_name, year_completed)
         VALUES (?, ?, ?)",
      [sqlight.int(1), sqlight.text("100% FUN!!"), sqlight.int(2024)],
    )

  // RETURNING works on UPDATE and DELETE too. here, what got deleted
  assert sqlight.query(
      "DELETE FROM paintings
         WHERE painting_name LIKE ?
         RETURNING painting_name, year_completed",
      on: conn,
      with: [sqlight.text("%FUN%")],
      expecting: {
        use name <- decode.field(0, decode.string)
        use year <- decode.field(1, decode.int)
        decode.success(#(name, year))
      },
    )
    == Ok([#("100% FUN!!", 2024)])

  // nothing matched: not an Error, just no changes
  let assert Ok(Nil) =
    run(conn, "DELETE FROM paintings WHERE year_completed > ?", [
      sqlight.int(3000),
    ])
  assert changes(conn) == 0
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
