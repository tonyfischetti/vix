// gleam, logging, log levels, logger, debug, info, warning, error, environment variables, pino

// gleam add logging envoy

import envoy
import gleam/int
import gleam/result
import logging

pub fn main() {
  // once, when the program starts. this sets up Erlang's logger to print
  // in a readable way, at the Info level
  logging.configure()

  // this will show Info or more severe
  logging.log(logging.Debug, "this is debug output")
  logging.log(logging.Info, "this is info output")
  logging.log(logging.Warning, "this is warn output")
  logging.log(logging.Error, "this is error output")
  // INFO this is info output
  // WARN this is warn output
  // EROR this is error output

  // the level, from the environment
  let level = case envoy.get("LOG_LEVEL") |> result.unwrap("info") {
    "debug" -> logging.Debug
    "warning" -> logging.Warning
    "error" -> logging.Error
    _ -> logging.Info
  }
  logging.set_level(level)

  // you can do other specific things in here
  case envoy.get("APP_ENV") {
    Ok("dev") -> logging.set_level(logging.Debug)
    _ -> Nil
  }

  // a message is a String. anything else you want in there, you put in
  let some_id = 850
  logging.log(logging.Info, "sub invoked [" <> int.to_string(some_id) <> "]")
  // INFO sub invoked [850]
  //  NOTE  all the levels, most severe first: Emergency, Alert, Critical,
  //        Error, Warning, Notice, Info, Debug
}
