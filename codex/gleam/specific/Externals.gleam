// gleam, externals, ffi, foreign function interface, interop, erlang, javascript, @external, call erlang from gleam, call javascript from gleam, external type

// One attribute borrows a function from the runtime underneath. You give
// it a Gleam type and the compiler takes your word for it, so if the type
// is wrong you find out at runtime.

import gleam/list

// an Erlang function: the module, then the function
@external(erlang, "erlang", "unique_integer")
fn unique_integer() -> Int

// both targets. on JavaScript it's a module, and a function it exports
@external(erlang, "erlang", "halt")
@external(javascript, "node:process", "exit")
fn exit(status: Int) -> Nil

// with a body, the external is used where there is one and the Gleam code
// everywhere else. here: Erlang's own reverse, or this one on JavaScript
@external(erlang, "lists", "reverse")
fn reverse(items: List(a)) -> List(a) {
  list.fold(items, [], fn(acc, item) { [item, ..acc] })
}

// a type with no constructors stands for a foreign value that Gleam code
// can hold and pass around but can't look inside
type Reference

@external(erlang, "erlang", "make_ref")
fn make_reference() -> Reference

pub fn main() {
  assert unique_integer() != unique_integer()
  assert reverse([1, 2, 3]) == [3, 2, 1]
  assert make_reference() != make_reference()

  exit(0)
}
// ***************** your own *****************
//
// put a file next to your Gleam code, and point at it
//
//   src/my_project_ffi.erl
//
//     -module(my_project_ffi).
//     -export([shout/1]).
//
//     shout(String) ->
//         string:uppercase(String).
//
//   src/my_project_ffi.mjs
//
//     export function shout(string) {
//       return string.toUpperCase();
//     }
//
//   src/my_project.gleam
//
//     @external(erlang, "my_project_ffi", "shout")
//     @external(javascript, "./my_project_ffi.mjs", "shout")
//     fn shout(string: String) -> String
//
// ***************** how the types line up *****************
//
//   Gleam            Erlang                    JavaScript
//   String           binary  <<"hi">>          string
//   Int, Float       integer, float            number
//   Bool             true / false (atoms)      boolean
//   Nil              nil (atom)                undefined
//   List(a)          list                      a linked list (NOT an array)
//   #(a, b)          {A, B}                    array
//   Ok(x)            {ok, X}                   an `Ok` object
//   Error(x)         {error, X}                an `Error` object
//   Cow("bessie")    {cow, <<"bessie">>}       a `Cow` object
//   BitArray         bitstring                 a `BitArray` object
//
//  NOTE  Erlang strings ("charlists") and atoms aren't Gleam Strings. the
//        types and conversions for them are in the `gleam_erlang` package
//        (see "Get OS info")
