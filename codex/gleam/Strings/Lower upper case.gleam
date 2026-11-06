// gleam, strings, unicode, upper case, lower case, uppercase, lowercase, capitalise, toUpperCase, toLowerCase

import gleam/string

pub fn main() {
  let nfc = "Όλοι οι άνθρωποι"
  let english = "THIS IS NOT A TEST"

  assert string.uppercase(nfc) == "ΌΛΟΙ ΟΙ ΆΝΘΡΩΠΟΙ"
  assert string.lowercase(english) == "this is not a test"

  // first letter up, everything else down
  assert string.capitalise("mad HATTER") == "Mad hatter"
}
