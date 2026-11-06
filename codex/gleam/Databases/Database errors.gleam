// gleam, databases, sqlite, errors, error handling, sqlight error, error code, constraint, check, not null, foreign key, primary key, unique, syntax error, decoder failed, custom error type, map_error

// gleam add sqlight

import gleam/dynamic/decode
import gleam/result
import sqlight.{SqlightError}

// everything in sqlight gives a Result, and the Error is always a
//
//   SqlightError(code: ErrorCode, message: String, offset: Int)
//
// `code` is one of SQLite's result codes as a (long) custom type, so a
// `case` can tell them apart. `message` is SQLite's own wording

// the usual thing to do with one: turn the codes you expect into your own
// error type, and keep the rest as they are
type ArtistError {
  BornTooEarly
  NeedsALastName
  Database(sqlight.Error)
}

fn add_artist(
  conn: sqlight.Connection,
  last_name: String,
  born_on: Int,
) -> Result(Nil, ArtistError) {
  sqlight.query(
    "INSERT INTO artists (last_name, born_on) VALUES (NULLIF(?, ''), ?)",
    on: conn,
    with: [sqlight.text(last_name), sqlight.int(born_on)],
    expecting: decode.success(Nil),
  )
  |> result.replace(Nil)
  |> result.map_error(fn(error) {
    case error.code {
      sqlight.ConstraintCheck -> BornTooEarly
      sqlight.ConstraintNotnull -> NeedsALastName
      _ -> Database(error)
    }
  })
}

pub fn main() {
  use conn <- sqlight.with_connection(":memory:")
  let assert Ok(Nil) = sqlight.exec("PRAGMA foreign_keys = ON", conn)
  let assert Ok(Nil) = sqlight.exec(art, conn)

  assert add_artist(conn, "Carrington", 1917) == Ok(Nil)
  assert add_artist(conn, "Vermeer", 1632) == Error(BornTooEarly)
  assert add_artist(conn, "", 1907) == Error(NeedsALastName)

  // ***** what the errors look like *****

  // bad SQL is a GenericError. `offset` is how far into the string the
  // trouble is (or -1 when SQLite can't say)
  assert sqlight.exec("SELEC * FROM artists", conn)
    == Error(SqlightError(
      code: sqlight.GenericError,
      message: "near \"SELEC\": syntax error",
      offset: 0,
    ))

  assert sqlight.exec("SELECT nope FROM artists", conn)
    == Error(SqlightError(sqlight.GenericError, "no such column: nope", 7))

  assert sqlight.exec("SELECT * FROM nope", conn)
    == Error(SqlightError(sqlight.GenericError, "no such table: nope", -1))

  // each kind of constraint has a code of its own

  assert sqlight.exec(
      "INSERT INTO artists (last_name, born_on) VALUES ('Vermeer', 1632)",
      conn,
    )
    == Error(SqlightError(
      sqlight.ConstraintCheck,
      "CHECK constraint failed: born_on > 1870",
      -1,
    ))

  assert sqlight.exec("INSERT INTO artists (first_name) VALUES ('Cher')", conn)
    == Error(SqlightError(
      sqlight.ConstraintNotnull,
      "NOT NULL constraint failed: artists.last_name",
      -1,
    ))

  // (a UNIQUE column that isn't the key gives ConstraintUnique)
  assert sqlight.exec(
      "INSERT INTO artists (artist_id, last_name) VALUES (1, 'Sage')",
      conn,
    )
    == Error(SqlightError(
      sqlight.ConstraintPrimarykey,
      "UNIQUE constraint failed: artists.artist_id",
      -1,
    ))

  // there is no artist 99. (only with `PRAGMA foreign_keys = ON`)
  assert sqlight.exec(
      "INSERT INTO paintings (artist_id, painting_name, year_completed)
         VALUES (99, 'Untitled', 1950)",
      conn,
    )
    == Error(SqlightError(
      sqlight.ConstraintForeignkey,
      "FOREIGN KEY constraint failed",
      -1,
    ))

  // the wrong type for the column. (only in a STRICT table. without
  // STRICT, SQLite stores the text and says nothing)
  assert sqlight.exec(
      "INSERT INTO artists (last_name, born_on) VALUES ('Sage', 'eighteen')",
      conn,
    )
    == Error(SqlightError(
      sqlight.ConstraintDatatype,
      "cannot store TEXT value in INTEGER column artists.born_on",
      -1,
    ))

  // a decoder that doesn't fit what came back. the query itself was fine,
  // so it's a GenericError and the message is sqlight's, not SQLite's
  assert sqlight.query(
      "SELECT last_name FROM artists",
      on: conn,
      with: [],
      expecting: decode.at([0], decode.int),
    )
    == Error(SqlightError(
      sqlight.GenericError,
      "Decoder failed, expected Int, got String in 0",
      -1,
    ))

  // more values than `?`s
  assert sqlight.query(
      "SELECT last_name FROM artists WHERE artist_id = ?",
      on: conn,
      with: [sqlight.int(1), sqlight.int(2)],
      expecting: decode.at([0], decode.string),
    )
    == Error(SqlightError(sqlight.Range, "column index out of range", -1))
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
