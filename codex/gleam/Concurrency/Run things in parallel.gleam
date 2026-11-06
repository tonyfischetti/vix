// gleam, concurrency, parallel, parallel map, pmap, Promise.all, tasks, processes, spawn, timeout, async

// gleam add gleam_erlang gleam_time

import gleam/erlang/process
import gleam/list
import gleam/time/duration
import gleam/time/timestamp

pub fn main() {
  let start = timestamp.system_time()

  // five jobs that take 200ms each...
  let squares = parallel_map([1, 2, 3, 4, 5], slow_square)
  assert squares == [1, 4, 9, 16, 25]

  // ...are done in about 200ms, not a second
  let elapsed = timestamp.difference(start, timestamp.system_time())
  assert duration.to_milliseconds(elapsed) < 600

  // and if one of them takes too long?
  assert parallel_map_within([1, 2], slow_square, 500) == Ok([1, 4])
  assert parallel_map_within([1, 2], slow_square, 50) == Error(Nil)
}

fn slow_square(n: Int) -> Int {
  process.sleep(200)
  n * n
}

/// Run `f` on every item at the same time, each one in its own process.
/// The results come back in the order of the items
fn parallel_map(items: List(a), f: fn(a) -> b) -> List(b) {
  items
  // start them all. each gets its own subject to answer on
  |> list.map(fn(item) {
    let reply = process.new_subject()
    process.spawn(fn() { process.send(reply, f(item)) })
    reply
  })
  // then collect the answers, in order
  |> list.map(process.receive_forever)
}

/// The same, but giving up on anything that takes longer than `timeout`
/// milliseconds
fn parallel_map_within(
  items: List(a),
  f: fn(a) -> b,
  timeout: Int,
) -> Result(List(b), Nil) {
  items
  |> list.map(fn(item) {
    let reply = process.new_subject()
    process.spawn(fn() { process.send(reply, f(item)) })
    reply
  })
  |> list.try_map(process.receive(_, within: timeout))
}
