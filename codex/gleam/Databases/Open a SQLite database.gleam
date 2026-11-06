// gleam, databases, sqlite, open a database, sqlight, connection, close, in memory database, database file, read only, with_connection, use

// gleam add sqlight envoy filepath

//  NOTE  SQLite itself gets compiled into the program (the first build
//        wants a C compiler). there's no server, and nothing to install

import envoy
import filepath
import gleam/dynamic/decode
import gleam/result
import sqlight

pub fn main() {
  // a database in memory. it's gone when the connection is closed
  let assert Ok(conn) = sqlight.open(":memory:")
  let assert Ok(Nil) = sqlight.close(conn)

  // a database in a file. the file is created if it isn't there
  let tmp = envoy.get("TMPDIR") |> result.unwrap("/tmp")
  let path = filepath.join(tmp, "codex-example.db")

  let assert Ok(conn) = sqlight.open(path)
  let assert Ok(Nil) =
    sqlight.exec(
      "DROP TABLE IF EXISTS artists;
       CREATE TABLE artists (last_name TEXT) STRICT;
       INSERT INTO artists VALUES ('Sage'), ('Mondrian');",
      conn,
    )
  let assert Ok(Nil) = sqlight.close(conn)
  //  WARN  using a connection after it's closed isn't an Error, it's a
  //        crash

  // `with_connection` opens, calls the function, closes, and hands back
  // whatever the function returned. with `use`, the function is the rest
  // of the block
  let last_names = {
    use conn <- sqlight.with_connection(path)
    let assert Ok(rows) =
      sqlight.query(
        "SELECT last_name FROM artists",
        on: conn,
        with: [],
        expecting: decode.at([0], decode.string),
      )
    rows
  }
  assert last_names == ["Sage", "Mondrian"]

  // SQLite's "file:" URIs are how the options go in. read only:
  let assert Ok(conn) = sqlight.open("file:" <> path <> "?mode=ro")
  let assert Error(error) = sqlight.exec("DELETE FROM artists", conn)
  assert error.code == sqlight.Readonly
  assert error.message == "attempt to write a readonly database"
  let assert Ok(Nil) = sqlight.close(conn)

  // read only also means it won't be created, so this is how to open a
  // database only if it exists
  let assert Error(error) = sqlight.open("file:" <> path <> ".nope?mode=ro")
  assert error.code == sqlight.Cantopen
}
