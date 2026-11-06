// gleam, strings, unicode awareness, utf-8, graphemes, code points, bytes, splitting strings, NFC, NFD, unicode, unicode escape

// Strings are UTF-8, and the `gleam/string` functions work in graphemes:
// what a person would call a character, however many code points it's
// made of. So the same word in NFC and NFD has the same length...

import gleam/list
import gleam/string

pub fn main() {
  // "Ό" as one code point / as "Ο" followed by a combining accent
  let nfc = "Όλοι οι άνθρωποι"
  let nfd = "Ο\u{0301}λοι οι α\u{0301}νθρωποι"

  assert string.length(nfc) == 16
  assert string.length(nfd) == 16

  // ...even though they're not the same code points, or bytes
  assert list.length(string.to_utf_codepoints(nfc)) == 16
  assert list.length(string.to_utf_codepoints(nfd)) == 18
  assert string.byte_size(nfc) == 30
  assert string.byte_size(nfd) == 34

  //  WARN  and so they're not equal (see "Unicode normalization")
  assert nfc != nfd

  let assert [nfc_word, ..] = string.split(nfc, on: " ")
  let assert [nfd_word, ..] = string.split(nfd, on: " ")

  // splitting into characters keeps the accent with its letter
  assert string.to_graphemes(nfc_word) == ["Ό", "λ", "ο", "ι"]
  assert list.length(string.to_graphemes(nfd_word)) == 4

  // the code points underneath
  let code_points = fn(s) {
    s |> string.to_utf_codepoints |> list.map(string.utf_codepoint_to_int)
  }
  assert code_points(nfc_word) == [908, 955, 959, 953]
  assert code_points(nfd_word) == [927, 769, 955, 959, 953]

  assert string.split(nfc_word, on: "λ") == ["Ό", "οι"]
  assert string.reverse(nfc_word) == "ιολΌ"
}
