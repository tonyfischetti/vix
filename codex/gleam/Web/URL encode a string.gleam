// gleam, web, URL encode, URI encode, percent encode, encodeURIComponent, decode, query string, parse a url, uri

import gleam/option.{None, Some}
import gleam/uri

pub fn main() {
  let test_string = "this is not & test"

  // one piece of a URL (this is `encodeURIComponent`)
  assert uri.percent_encode(test_string) == "this%20is%20not%20%26%20test"
  assert uri.percent_decode("this%20is%20not%20%26%20test") == Ok(test_string)

  // a whole query string, from pairs
  assert uri.query_to_string([#("q", test_string), #("page", "2")])
    == "q=this%20is%20not%20%26%20test&page=2"

  // and back
  assert uri.parse_query("q=this%20is%20not%20%26%20test&page=2")
    == Ok([#("q", test_string), #("page", "2")])

  // taking a URL apart
  let assert Ok(parsed) =
    uri.parse("https://example.com:8443/nppes/NPI_Files.html?q=bat#top")
  assert parsed.scheme == Some("https")
  assert parsed.host == Some("example.com")
  assert parsed.port == Some(8443)
  assert parsed.path == "/nppes/NPI_Files.html"
  assert parsed.query == Some("q=bat")
  assert parsed.fragment == Some("top")
  assert parsed.userinfo == None

  assert uri.path_segments(parsed.path) == ["nppes", "NPI_Files.html"]
  assert uri.origin(parsed) == Ok("https://example.com:8443")

  // putting one together (it's a record, so change the fields you want)
  let other_page = uri.Uri(..parsed, path: "/nppes/other.html", fragment: None)
  assert uri.to_string(other_page)
    == "https://example.com:8443/nppes/other.html?q=bat"

  // resolving a relative link against the page it was on
  let assert Ok(link) = uri.parse("./data.zip")
  let assert Ok(absolute) = uri.merge(parsed, link)
  assert uri.to_string(absolute) == "https://example.com:8443/nppes/data.zip"
}
