// gleam, databases, sqlite, create table, insert, exec, sqlight, schema, strict, primary key, foreign key, pragma, multiple statements, art database

// gleam add sqlight

import gleam/dynamic/decode
import sqlight

// the art database from the sql codex ("Create art sqlite db")
const schema =
  "
CREATE TABLE artists (
  artist_id         INTEGER   PRIMARY KEY,
  first_name        TEXT,
  last_name         TEXT      NOT NULL,
  born_on           INTEGER   CHECK(born_on > 1870)
) STRICT;

CREATE TABLE paintings (
  painting_id       INTEGER   PRIMARY KEY,
  artist_id         INTEGER   REFERENCES artists,
  painting_name     TEXT      CHECK(LENGTH(painting_name) > 1),
  year_completed    INTEGER   CHECK(year_completed > 1800)
) STRICT;
"

const rows =
  "
INSERT INTO artists (first_name, last_name, born_on)
  VALUES ('Kay',         'Sage',     1898),
         ('Piet',        'Mondrian', 1872),
         ('Rene',        'Magritte', 1898),
         ('',            'Man Ray',  1890),
         ('Jean-Michel', 'Basquiat', 1960);

INSERT INTO paintings (artist_id, painting_name, year_completed)
  VALUES (4, 'Orquesta Sinfonica',      1916),
         (4, 'La Fortune',              1938),
         (1, 'Tomorrow is Never',       1955),
         (1, 'The Answer is No',        1958),
         (1, 'No Passing',              1954),
         (5, 'Bird on Money',           1981),
         (2, 'Place de la Concorde',    1943),
         (2, 'Composition No. 10',      1942),
         (3, 'The Human Condition',     1935),
         (3, 'The Treachery of Images', 1948),
         (3, 'The Son of Man',          1964);
"

pub fn main() {
  use conn <- sqlight.with_connection(":memory:")

  // `exec` is for SQL that takes no values and gives nothing back.
  // it runs as many statements as are in the string

  //  NOTE  SQLite only enforces foreign keys if you ask, and you have to
  //        ask on every connection
  let assert Ok(Nil) = sqlight.exec("PRAGMA foreign_keys = ON", conn)
  let assert Ok(Nil) = sqlight.exec(schema, conn)
  let assert Ok(Nil) = sqlight.exec(rows, conn)

  // `query` is for everything else. it runs ONE statement, and decodes
  // the rows that come back (see "Query a database")
  let count = decode.at([0], decode.int)
  assert sqlight.query(
      "SELECT COUNT(*) FROM paintings",
      on: conn,
      with: [],
      expecting: count,
    )
    == Ok([11])

  //  WARN  `exec` stops at the first statement that fails, and the ones
  //        before it have already happened. here the first insert
  //        sticks even though the call is an Error (see "Transactions")
  let assert Error(_) =
    sqlight.exec(
      "INSERT INTO artists (last_name, born_on) VALUES ('Carrington', 1917);
       INSERT INTO artists (last_name, born_on) VALUES ('Vermeer', 1632);",
      conn,
    )
  assert sqlight.query(
      "SELECT COUNT(*) FROM artists",
      on: conn,
      with: [],
      expecting: count,
    )
    == Ok([6])
}
