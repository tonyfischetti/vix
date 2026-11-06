// gleam, concurrency, processes, threads, spawn, messages, subject, send, receive, timeout, async, await, promise, background work, erlang, beam

// gleam add gleam_erlang

// A process here isn't an OS process or a thread. It's a tiny thing that
// the Erlang VM schedules itself, and you can have hundreds of thousands
// of them. Processes share NO memory. The one way to get anything to or
// from a process is to send a message.

import gleam/erlang/process
import gleam/int
import gleam/io
import gleam/list

pub fn main() {
  // a Subject is a typed mailbox. the process that makes it is the one
  // that can receive from it, and anybody who has it can send to it
  let inbox = process.new_subject()

  // start a process. it does its work and sends the answer back
  process.spawn(fn() {
    process.sleep(100)
    process.send(inbox, "little bat")
  })

  // meanwhile this one carries on...
  io.println("twinkle twinkle")

  // ...until it wants the answer (this is the `await`).
  // it'll wait up to a second for it
  assert process.receive(inbox, within: 1000) == Ok("little bat")

  // nothing (else) turned up in time
  assert process.receive(inbox, within: 10) == Error(Nil)

  // lots at once: every one of these sleeps for 100ms, at the same time
  let results = process.new_subject()
  list.each([1, 2, 3, 4, 5], fn(n) {
    process.spawn(fn() {
      process.sleep(100)
      process.send(results, #(n, n * n))
    })
  })

  // the answers come in whatever order they finish in
  let squares =
    list.map([1, 2, 3, 4, 5], fn(_) {
      let assert Ok(square) = process.receive(results, within: 1000)
      square
    })
  assert list.sort(squares, fn(a, b) { int.compare(a.0, b.0) })
    == [#(1, 1), #(2, 4), #(3, 9), #(4, 16), #(5, 25)]
  //  NOTE  `spawn` links the new process to this one: if either crashes
  //        the other is taken down with it, so a failure can't go
  //        unnoticed. `process.spawn_unlinked` doesn't
}
