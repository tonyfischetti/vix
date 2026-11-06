// gleam, web, CSS selectors, querySelector, web scraping, html parsing, fetch, presentable_soup, cheerio, attribute, relative link

// gleam add presentable_soup gleam_http gleam_httpc

import gleam/http/request
import gleam/httpc
import gleam/io
import gleam/list
import gleam/result
import gleam/string
import gleam/uri
import presentable_soup as soup

const portal_url = "https://download.cms.gov/nppes/NPI_Files.html"

pub fn main() {
  // there are no selector strings. a query is built out of matchers, and
  // says what to pull out of the element it finds.
  // this is `a[id='DDSMTH.ZIP.D']`, and its attributes
  let scraper =
    soup.element([soup.with_tag("a"), soup.with_id("DDSMTH.ZIP.D")])
    |> soup.return(soup.attributes())

  let html =
    "<html><body><ul>
       <li><a id='DDSMTH.ZIP.D' href='./NPPES_Data_V2.zip'>Monthly</a></li>
       <li><a id='DDSWKLY.ZIP.D' href='./NPPES_Weekly_V2.zip'>Weekly</a></li>
     </ul></body></html>"

  let assert Ok(attributes) = soup.scrape(scraper, html)
  assert list.key_find(attributes, "href") == Ok("./NPPES_Data_V2.zip")

  // the text of every link
  let link_text =
    soup.elements([soup.with_tag("a")])
    |> soup.return(soup.text_content())
  assert soup.scrape(link_text, html) == Ok([["Monthly"], ["Weekly"]])

  // not finding it is an Error
  let missing =
    soup.element([soup.with_class("nope")]) |> soup.return(soup.tag())
  assert soup.scrape(missing, html) == Error(soup.ScrapingFailed)

  // now on the real page
  case get_link() {
    Ok(link) -> io.println(link)
    Error(reason) -> io.println_error("couldn't find short link: " <> reason)
  }
  // https://download.cms.gov/nppes/NPPES_Data_Dissemination_November_2026_V2.zip
}

fn get_link() -> Result(String, String) {
  let scraper =
    soup.element([soup.with_tag("a"), soup.with_id("DDSMTH.ZIP.D")])
    |> soup.return(soup.attributes())

  use portal <- result.try(
    uri.parse(portal_url) |> result.replace_error("bad url"),
  )
  use req <- result.try(
    request.from_uri(portal) |> result.replace_error("bad url"),
  )
  use resp <- result.try(httpc.send(req) |> result.map_error(string.inspect))
  use attributes <- result.try(
    soup.scrape(scraper, resp.body) |> result.map_error(string.inspect),
  )
  use href <- result.try(
    list.key_find(attributes, "href") |> result.replace_error("no href"),
  )

  // the href is relative ("./NPPES_....zip"). resolve it against the page
  use relative <- result.try(
    uri.parse(href) |> result.replace_error("bad href"),
  )
  uri.merge(portal, relative)
  |> result.map(uri.to_string)
  |> result.replace_error("couldn't resolve " <> href)
}
