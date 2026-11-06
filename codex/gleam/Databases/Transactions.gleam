// gleam, databases, sqlite, transaction, begin, commit, rollback, all or nothing, atomic, sqlight, use, result.try, try_each

// gleam add sqlight

import gleam/dynamic/decode
import gleam/list
import gleam/result
import sqlight

// sqlight has no transaction function, but it's a short one to write:
// BEGIN, call the function, then COMMIT if it gave an Ok and ROLLBACK if
// it gave an Error
fn transaction(
  conn: sqlight.Connection,
  run: fn() -> Result(a, sqlight.Error),
) -> Result(a, sqlight.Error) {
  use Nil <- result.try(sqlight.exec("BEGIN", conn))
  let outcome = {
    use value <- result.try(run())
    use Nil <- result.map(sqlight.exec("COMMIT", conn))
    value
  }
  case outcome {
    Ok(value) -> Ok(value)
    Error(error) -> {
      // undo everything since the BEGIN. (if the ROLLBACK fails too
      // there's nothing left to try, so its result is dropped)
      let _ = sqlight.exec("ROLLBACK", conn)
      Error(error)
    }
  }
}

// an artist and their paintings go in together or not at all
fn add_artist_with_paintings(
  conn: sqlight.Connection,
  last_name: String,
  born_on: Int,
  paintings: List(#(String, Int)),
) -> Result(Int, sqlight.Error) {
  // everything below this line is the function `transaction` calls
  use <- transaction(conn)

  use rows <- result.try(sqlight.query(
    "INSERT INTO artists (last_name, born_on) VALUES (?, ?)
       RETURNING artist_id",
    on: conn,
    with: [sqlight.text(last_name), sqlight.int(born_on)],
    expecting: decode.at([0], decode.int),
  ))
  let assert [artist_id] = rows

  // `try_each` stops at the first Error, and that Error is what comes
  // out of this function
  use Nil <- result.try(
    list.try_each(paintings, fn(painting) {
      let #(name, year) = painting
      sqlight.query(
        "INSERT INTO paintings (artist_id, painting_name, year_completed)
           VALUES (?, ?, ?)",
        on: conn,
        with: [sqlight.int(artist_id), sqlight.text(name), sqlight.int(year)],
        expecting: decode.success(Nil),
      )
    }),
  )

  Ok(artist_id)
}

fn count(conn: sqlight.Connection, table: String) -> Int {
  // (a table name can't be a `?`. this one never comes from outside)
  let assert Ok([count]) =
    sqlight.query(
      "SELECT COUNT(*) FROM " <> table,
      on: conn,
      with: [],
      expecting: decode.at([0], decode.int),
    )
  count
}

pub fn main() {
  use conn <- sqlight.with_connection(":memory:")
  let assert Ok(Nil) = sqlight.exec(art, conn)
  assert #(count(conn, "artists"), count(conn, "paintings")) == #(5, 11)

  // it all works: committed
  assert add_artist_with_paintings(conn, "Carrington", 1917, [
      #("Self-Portrait", 1938),
      #("The Giantess", 1947),
    ])
    == Ok(6)
  assert #(count(conn, "artists"), count(conn, "paintings")) == #(6, 13)

  // the second painting breaks a CHECK (somebody typed the year wrong).
  // the artist and the first painting had already gone in, and the
  // ROLLBACK takes them back out
  let assert Error(error) =
    add_artist_with_paintings(conn, "Kahlo", 1907, [
      #("The Two Fridas", 1939),
      #("The Broken Column", 944),
    ])
  assert error.code == sqlight.ConstraintCheck
  assert #(count(conn, "artists"), count(conn, "paintings")) == #(6, 13)

  //  WARN  a BEGIN and a COMMIT in one `exec` string look like the same
  //        thing. they aren't: `exec` stops at the statement that failed
  //        and never reaches the COMMIT, so the transaction is left open
  //        with the first insert still in it
  let assert Error(_) =
    sqlight.exec(
      "BEGIN;
       INSERT INTO artists (last_name, born_on) VALUES ('Kahlo', 1907);
       INSERT INTO artists (last_name, born_on) VALUES ('Vermeer', 1632);
       COMMIT;",
      conn,
    )
  assert count(conn, "artists") == 7

  let assert Error(error) = sqlight.exec("BEGIN", conn)
  assert error.message == "cannot start a transaction within a transaction"

  let assert Ok(Nil) = sqlight.exec("ROLLBACK", conn)
  assert count(conn, "artists") == 6
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
