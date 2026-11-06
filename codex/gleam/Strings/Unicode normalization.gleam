// gleam, strings, unicode normalization, NFD, NFC, unicode, external, ffi, erlang

// There's nothing for this in the standard library, but Erlang has it,
// and borrowing an Erlang function is one line (see "Externals")

@external(erlang, "unicode", "characters_to_nfc_binary")
fn to_nfc(string: String) -> String

@external(erlang, "unicode", "characters_to_nfd_binary")
fn to_nfd(string: String) -> String

pub fn main() {
  let nfc = "Όλοι οι άνθρωποι"
  let nfd = "Ο\u{0301}λοι οι α\u{0301}νθρωποι"

  // they look the same, but they aren't equal
  assert nfd != nfc

  assert to_nfc(nfd) == nfc
  assert to_nfd(nfc) == nfd

  // so normalize both sides before comparing text that came from outside
  assert to_nfc(nfd) == to_nfc(nfc)
  //  NOTE  on the JavaScript target the same thing is a tiny .mjs file next
  //        to this one
  //
  //          export function to_nfc(string) {
  //            return string.normalize("NFC");
  //          }
  //
  //        and a second attribute on the function
  //
  //          @external(javascript, "./normalize_ffi.mjs", "to_nfc")
}
