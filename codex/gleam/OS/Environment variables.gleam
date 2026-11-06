// gleam, os, environment variables, env, getenv, setenv, process.env, home directory, PATH, default value

// gleam add envoy

import envoy
import gleam/dict
import gleam/int
import gleam/result
import gleam/string

pub fn main() {
  // a Result, because it might not be set
  let assert Ok(home) = envoy.get("HOME")
  echo home
  // "/Users/tony"

  assert envoy.get("NOT_A_REAL_VARIABLE") == Error(Nil)

  // with a default (this is `process.env.PINO_LEVEL ?? "info"`)
  let level = envoy.get("LOG_LEVEL") |> result.unwrap("info")
  assert level == "info"

  // they're always strings. a number has to be parsed
  let port =
    envoy.get("PORT")
    |> result.try(int.parse)
    |> result.unwrap(8080)
  assert port == 8080

  // set and unset (for this program and anything it starts)
  envoy.set("GREETING", "howdy")
  assert envoy.get("GREETING") == Ok("howdy")
  envoy.unset("GREETING")
  assert envoy.get("GREETING") == Error(Nil)

  // all of them, as a Dict
  let everything = envoy.all()
  assert dict.has_key(everything, "PATH")

  let assert Ok(path) = envoy.get("PATH")
  echo string.split(path, on: ":")
}
