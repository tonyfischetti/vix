// gleam, os, get os info, platform, operating system, architecture, hostname, pid, cpu count, uptime, home directory, temporary directory, get process information, external, erlang, atom, charlist

// gleam add platform envoy simplifile gleam_erlang

import envoy
import gleam/erlang/atom.{type Atom}
import gleam/erlang/charlist.{type Charlist}
import gleam/result
import platform
import simplifile

pub fn main() {
  echo platform.os()
  // Darwin  (or Linux, Win32, FreeBsd...)
  echo platform.arch()
  // Arm64   (or X64...)
  echo platform.runtime()
  // Erlang  (or Node, Deno, Bun, Browser)

  // a lot of the rest is in the environment
  let env = fn(name) { envoy.get(name) |> result.unwrap("(not set)") }
  echo env("HOME")
  echo env("USER")
  echo env("SHELL")
  echo env("TMPDIR")

  let assert Ok(cwd) = simplifile.current_directory()
  echo cwd

  // *** PROCESS INFO ***
  // anything else Erlang knows about is one `@external` away (see below)

  let assert Ok(host) = hostname()
  echo charlist.to_string(host)
  // "Mac-285"
  echo charlist.to_string(os_pid())
  // "93652"
  echo system_info(atom.create("logical_processors"))
  // 10
  echo charlist.to_string(otp_release(atom.create("otp_release")))
  // "29"

  // bytes of memory the VM is using
  echo memory(atom.create("total"))
  // 51969080

  // milliseconds since the VM started (and since this was last called)
  echo statistics(atom.create("wall_clock"))
  // #(112, 112)
}

// Erlang hands back its own kinds of strings (charlists) and symbols
// (atoms). `gleam_erlang` has the types for them and the conversions

@external(erlang, "inet", "gethostname")
fn hostname() -> Result(Charlist, Nil)

@external(erlang, "os", "getpid")
fn os_pid() -> Charlist

@external(erlang, "erlang", "system_info")
fn system_info(item: Atom) -> Int

@external(erlang, "erlang", "system_info")
fn otp_release(item: Atom) -> Charlist

@external(erlang, "erlang", "memory")
fn memory(kind: Atom) -> Int

@external(erlang, "erlang", "statistics")
fn statistics(item: Atom) -> #(Int, Int)
