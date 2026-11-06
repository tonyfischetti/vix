// gleam, types, polymorphism, abstract classes, interfaces, variants, record of functions, dispatch, strategy pattern

// An abstract class says "subclasses, fill in this one method". Without
// classes there are two ways to say it. Which one depends on who gets to
// add new kinds.

type SqlFragment =
  String

// 1. A CLOSED set of kinds: variants and a `case`.
//    Adding a dialect is adding a variant, and then the compiler points at
//    every `case` that needs a new clause

type Dialect {
  Sqlite
  Postgres
}

fn escape_id(dialect: Dialect, id: String) -> String {
  case dialect {
    Sqlite -> "`" <> id <> "`"
    Postgres -> "\"" <> id <> "\""
  }
}

fn from_clause(dialect: Dialect, table_name: String) -> SqlFragment {
  "FROM " <> escape_id(dialect, table_name)
}

// 2. An OPEN set of kinds: a record that carries the functions.
//    This is the abstract class. Anybody, in any module, can make a new
//    adapter by building the record

type DialectAdapter {
  DialectAdapter(table_name: String, escape_id: fn(String) -> String)
}

fn sqlite_adapter(table_name: String) -> DialectAdapter {
  DialectAdapter(table_name:, escape_id: fn(id) { "`" <> id <> "`" })
}

fn postgres_adapter(table_name: String) -> DialectAdapter {
  DialectAdapter(table_name:, escape_id: fn(id) { "\"" <> id <> "\"" })
}

// the shared ("inherited") behaviour is a function that uses the record
fn to_sql(adapter: DialectAdapter) -> SqlFragment {
  "FROM " <> adapter.escape_id(adapter.table_name)
}

pub fn main() {
  assert from_clause(Sqlite, "main") == "FROM `main`"
  assert from_clause(Postgres, "main") == "FROM \"main\""

  assert to_sql(sqlite_adapter("main")) == "FROM `main`"
  assert to_sql(postgres_adapter("main")) == "FROM \"main\""
}
