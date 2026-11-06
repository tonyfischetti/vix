// gleam, web, simple web server, http server, wisp, mist, routing, handler, middleware, json response, query string, path parameters

// gleam add wisp mist gleam_erlang gleam_http gleam_json

import gleam/erlang/process
import gleam/http
import gleam/json
import gleam/list
import gleam/result
import mist
import wisp.{type Request, type Response}
import wisp/wisp_mist

pub fn main() {
  wisp.configure_logger()

  // for signing cookies and the like. a real app keeps one fixed secret
  // in the environment, not a new one every time it starts
  let secret_key_base = wisp.random_string(64)

  let assert Ok(_) =
    handle_request
    |> wisp_mist.handler(secret_key_base)
    |> mist.new
    |> mist.port(8000)
    |> mist.start

  // the server runs in its own processes. this keeps `main` from
  // returning (and the program from ending)
  process.sleep_forever()
}

// a handler is a function from a request to a response
fn handle_request(req: Request) -> Response {
  // middleware. each one wraps everything underneath it
  use <- wisp.log_request(req)
  use <- wisp.rescue_crashes

  // routing is pattern matching on the path
  case wisp.path_segments(req) {
    // /
    [] -> wisp.html_response("<h1>Hello, Joe!</h1>", 200)

    // /hello/alice  and  /hello/alice?greeting=Howdy
    ["hello", name] -> hello(req, name)

    // /api/rainbow
    ["api", "rainbow"] -> rainbow(req)

    _ -> wisp.not_found()
  }
}

fn hello(req: Request, name: String) -> Response {
  let greeting =
    wisp.get_query(req)
    |> list.key_find("greeting")
    |> result.unwrap("Hello")

  wisp.ok() |> wisp.string_body(greeting <> ", " <> name <> "!")
}

fn rainbow(req: Request) -> Response {
  // anything but a GET gets a 405
  use <- wisp.require_method(req, http.Get)

  let colors = ["red", "orange", "yellow", "green", "blue", "indigo", "violet"]
  json.object([#("colors", json.array(colors, of: json.string))])
  |> json.to_string
  |> wisp.json_response(200)
}
//  NOTE  $ curl localhost:8000/hello/alice?greeting=Howdy
//        Howdy, alice!
//        $ curl localhost:8000/api/rainbow
//        {"colors":["red","orange","yellow","green","blue","indigo","violet"]}
