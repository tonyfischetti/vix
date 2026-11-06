// gleam, web, http, request, GET, POST, fetch, httpc, headers, status code, json, response body, timeout, redirect, error handling

// gleam add gleam_http gleam_httpc gleam_json

import gleam/bool
import gleam/dynamic/decode
import gleam/http
import gleam/http/request
import gleam/http/response
import gleam/httpc
import gleam/io
import gleam/json
import gleam/result
import gleam/uri

pub fn main() {
  // a request is built from a URL (a Result, in case the URL is nonsense)
  let assert Ok(req) = request.to("https://ifconfig.me/ip")

  // sending it waits for the response. there's no promise to chain
  let assert Ok(resp) = httpc.send(req)

  // which is a plain record: `status`, `headers` and `body`
  assert resp.status == 200
  echo resp.headers
  // [#("connection", "close"), #("date", "Fri, 06 Nov 2026 00:20:10 GMT"),
  //   #("content-length", "39"), #("content-type", "text/plain"), ...]
  assert response.get_header(resp, "content-type") == Ok("text/plain")

  // TEXT

  io.println(resp.body)

  // JSON

  let assert Ok(req) = request.to("https://ifconfig.me/all.json")
  let assert Ok(resp) = httpc.send(req)
  let assert Ok(ip_addr) =
    json.parse(resp.body, decode.at(["ip_addr"], decode.string))
  io.println(ip_addr)

  // (for BINARY data see "Download and write a binary file")

  // the request is a record as well, and everything about it can be set
  let post =
    request.new()
    |> request.set_method(http.Post)
    |> request.set_host("example.com")
    |> request.set_path("/api/bats")
    |> request.set_query([#("twinkle", "twinkle")])
    |> request.set_header("content-type", "application/json")
    |> request.set_body("{\"name\": \"little bat\"}")
  assert post |> request.to_uri |> uri.to_string
    == "https://example.com/api/bats?twinkle=twinkle"

  // options for how it gets sent
  let config =
    httpc.configure()
    |> httpc.timeout(5000)
    |> httpc.follow_redirects(True)
  assert fetch_ip(config) == Ok(ip_addr)
  //  NOTE  on the JavaScript target this is the `gleam_fetch` package, and
  //        you get promises
}

// in a real program: no `let assert`, and every way it can go wrong is in
// the type
pub type FetchError {
  BadUrl
  CouldNotSend(httpc.HttpError)
  BadStatus(Int)
  BadJson(json.DecodeError)
}

fn fetch_ip(config: httpc.Configuration) -> Result(String, FetchError) {
  use req <- result.try(
    request.to("https://ifconfig.me/all.json") |> result.replace_error(BadUrl),
  )
  use resp <- result.try(
    httpc.dispatch(config, req) |> result.map_error(CouldNotSend),
  )
  //  WARN  a 404 or a 500 is still an `Ok`: the request itself worked. you
  //        have to look at the status
  use <- bool.guard(resp.status != 200, return: Error(BadStatus(resp.status)))

  json.parse(resp.body, decode.at(["ip_addr"], decode.string))
  |> result.map_error(BadJson)
}
